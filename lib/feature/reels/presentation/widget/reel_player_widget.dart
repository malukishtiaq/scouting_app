import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entity/reels_response_entity.dart';
import '../../../../../mainapis.dart';
import '../../../../../core/video/video_cache_manager.dart';
import 'reel_controls_widget.dart';

class ReelPlayerWidget extends StatefulWidget {
  final PostDataEntity reel;
  final bool isActive;

  const ReelPlayerWidget({
    super.key,
    required this.reel,
    required this.isActive,
  });

  @override
  State<ReelPlayerWidget> createState() => _ReelPlayerWidgetState();
}

class _ReelPlayerWidgetState extends State<ReelPlayerWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isYouTube = false;
  bool _isVisible = false;
  bool _isDisposed = false;
  bool _isPlaying = false;
  bool _isLoading = true;
  String? _videoUrl;

  // User interaction tracking
  bool _userPaused = false; // Track if user manually paused

  @override
  void initState() {
    super.initState();
    _setupVideoUrl();
    // Always initialize video for better performance
    _initializeVideo();
  }

  @override
  void didUpdateWidget(ReelPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reel.id != widget.reel.id) {
      // Reset all state for new video
      _userPaused = false;

      // Dispose old controller safely
      _disposeController();
      _setupVideoUrl();

      // Small delay to let old controller fully release before starting new one
      // This prevents MediaCodec "flush on released state" errors
      Future.delayed(const Duration(milliseconds: 50), () {
        if (!_isDisposed && mounted) {
          _initializeVideo();
        }
      });
    } else if (oldWidget.isActive != widget.isActive) {
      // Reset user pause when becoming inactive
      if (!widget.isActive) {
        _userPaused = false;
      }

      // Handle play/pause based on visibility
      if (widget.isActive && _isInitialized && !_userPaused) {
        _playVideo();
      } else if (!widget.isActive && _isInitialized) {
        _pauseVideo();
      }
    }
  }

  /// Check if video is preloaded
  bool get isVideoPreloaded {
    if (_videoUrl == null) return false;
    return VideoCacheManager().isVideoPreloaded(_videoUrl!);
  }

  /// Force refresh video - Manual recovery only
  void _forceVideoRefresh() {
    if (_isDisposed || !mounted) return;

    // Only log on manual refresh (user action)
    print('🔄 MANUAL REFRESH: User double-tapped video');

    // Dispose current controller
    _disposeController();

    // Reset all state
    setState(() {
      _isInitialized = false;
      _hasError = false;
      _isLoading = true;
      _isPlaying = false;
      _userPaused = false; // Reset pause on manual refresh
    });

    // Reinitialize video
    _initializeVideo();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _disposeController();
    super.dispose();
  }

  void _setupVideoUrl() {
    if (widget.reel.video.isNotEmpty) {
      _videoUrl = MainAPIS.getCoverImage(widget.reel.video);
      _isYouTube = false;
    } else {
      _videoUrl = null;
      _isYouTube = false;

      // Log when no video source is found
      print(
          '❌ NO VIDEO SOURCE: Post has no video URL | Post ID: ${widget.reel.id}');
    }
  }

  void _disposeController() {
    if (_isDisposed) return;

    // CRITICAL: Stop/pause BEFORE disposing to prevent MediaCodec errors
    try {
      if (_controller != null && _controller!.value.isInitialized) {
        if (_controller!.value.isPlaying) {
          _controller!.pause();
        }
      }
    } catch (e) {
      // Ignore pause errors during disposal
    }

    // Don't dispose cached controllers, just clear reference
    if (_controller != null) {
      if (_videoUrl != null && !_isYouTube) {
        // Only dispose if not cached
        if (!VideoCacheManager().isControllerCached(_videoUrl!)) {
          try {
            _controller?.dispose();
          } catch (e) {
            // Ignore disposal errors (codec already released)
            print('⚠️ Controller disposal error (safe to ignore): $e');
          }
        }
      } else {
        try {
          _controller?.dispose();
        } catch (e) {
          // Ignore disposal errors
          print('⚠️ Controller disposal error (safe to ignore): $e');
        }
      }
      _controller = null;
    }

    _isInitialized = false;
    _hasError = false;
    _isYouTube = false;
    _isVisible = false;
    _isPlaying = false;
    _isLoading = true;
    _userPaused = false;
  }

  void _pauseVideo() {
    if (_controller != null && _controller!.value.isPlaying) {
      _controller!.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _playVideo() {
    // Don't play if user manually paused
    if (_userPaused) {
      return;
    }

    if (_controller != null &&
        _controller!.value.isInitialized &&
        !_controller!.value.isPlaying) {
      _controller!.play();
      setState(() {
        _isPlaying = true;
      });
    } else if (_controller != null && !_controller!.value.isInitialized) {
      // Log WHY video can't play
      print(
          '❌ CANNOT PLAY: Video not initialized | URL: ${_videoUrl?.substring(0, 50)}...');
    }
  }

  void _initializeVideo() async {
    if (_isDisposed || _videoUrl == null) return;

    if (mounted) {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
    }

    // Reduced timeout from 10s to 5s for faster error detection
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isDisposed && _isLoading) {
        print(
            '❌ TIMEOUT ERROR: Video took >5s to initialize | Post ID: ${widget.reel.id}');
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    });

    try {
      if (_isYouTube) {
        _initializeYouTubeVideo();
        return;
      }

      // Check cache first for MUCH better performance
      final cachedController =
          await VideoCacheManager().getCachedController(_videoUrl!);
      if (cachedController != null) {
        _controller = cachedController;
        if (mounted && !_isDisposed) {
          setState(() {
            _isInitialized = true;
            _hasError = false;
            _isLoading = false;
          });

          // Auto-play if this is the active reel and user didn't pause
          if (widget.isActive && !_userPaused) {
            _playVideo();
          }
        }
        // Removed verbose cache hit log - not useful for debugging
        return;
      }

      // Create new controller - optimized for faster loading
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(_videoUrl!),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      // Add listener BEFORE initialization for better state tracking
      _controller!.addListener(_videoListener);

      // Reduced retry attempts from 3 to 2 for faster loading
      const int maxAttempts = 2;
      bool initialized = false;
      String? lastError;

      for (int attempt = 1; attempt <= maxAttempts; attempt++) {
        try {
          await _controller!.initialize();
          initialized = true;
          break;
        } catch (e) {
          lastError = e.toString();
          // Only retry once with minimal delay
          if (attempt < maxAttempts) {
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
      }

      if (!initialized) {
        // Log detailed error reason
        print(
            '❌ INIT FAILED: ${lastError ?? "Unknown error"} | Post ID: ${widget.reel.id} | URL: ${_videoUrl?.substring(0, 60)}...');

        if (mounted && !_isDisposed) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
        return;
      }

      // Cache the controller for future use
      VideoCacheManager().cacheController(_videoUrl!, _controller!);

      if (mounted && !_isDisposed) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
          _isLoading = false;
        });

        // Log successful initialization
        print('✅ VIDEO READY: Post ${widget.reel.id} initialized successfully');

        // Auto-play if this is the active reel and user didn't pause
        if (widget.isActive && !_userPaused) {
          _playVideo();
        }
      }
    } catch (e) {
      // Log detailed error with context
      print(
          '❌ CRITICAL ERROR: Video initialization exception | Post ID: ${widget.reel.id} | Error: $e');

      if (mounted && !_isDisposed) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  void _videoListener() {
    if (_controller == null || _isDisposed) return;

    final value = _controller!.value;
    if (mounted && !_isDisposed) {
      setState(() {
        _isPlaying = value.isPlaying;

        // Clear error/loading once the controller is healthy
        if (value.isInitialized && !value.hasError) {
          _hasError = false;
          _isLoading = false;
        }

        // Capture genuine error and log reason
        if (value.hasError) {
          _hasError = true;
          _isLoading = false;

          // Log detailed error information
          final errorMsg = value.errorDescription ?? 'No error description';
          print(
              '❌ VIDEO ERROR: $errorMsg | Post ID: ${widget.reel.id} | Playing: ${value.isPlaying} | Buffering: ${value.isBuffering}');
        }
      });
    }

    // BLACK SCREEN DETECTION DISABLED
    // Users can double-tap to manually refresh if needed
  }

  void _initializeYouTubeVideo() {
    // YouTube support removed - only standard video files supported
    if (mounted && !_isDisposed) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reel_${widget.reel.id}'),
      onVisibilityChanged: (visibilityInfo) {
        final isVisible = visibilityInfo.visibleFraction > 0.7;
        if (_isVisible != isVisible) {
          _isVisible = isVisible;
          if (isVisible && _isInitialized && !_userPaused) {
            // Only auto-play if user didn't manually pause
            _playVideo();
          } else if (!isVisible && _isInitialized) {
            // Always pause when not visible (but don't mark as user pause)
            _pauseVideo();
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video Player
            if (_hasError)
              _buildErrorWidget()
            else if (_isLoading || !_isInitialized)
              _buildLoadingWidget()
            else if (_isYouTube)
              _buildYouTubePlayer()
            else
              _buildVideoPlayer(),

            // Controls Overlay
            ReelControlsWidget(
              reel: widget.reel,
              controller: _controller,
              isPlaying: _isPlaying,
              onPlayPause: () {
                if (_controller != null) {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                    setState(() {
                      _isPlaying = false;
                      _userPaused = true; // Track user pause
                    });
                  } else {
                    _controller!.play();
                    setState(() {
                      _isPlaying = true;
                      _userPaused = false; // User resumed
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_controller == null || !_isInitialized) {
      return _buildLoadingWidget();
    }

    return GestureDetector(
      onTap: () {
        if (_controller != null && _controller!.value.isInitialized) {
          if (_controller!.value.isPlaying) {
            _controller!.pause();
            setState(() {
              _isPlaying = false;
              _userPaused = true; // Track user pause
            });
          } else {
            _controller!.play();
            setState(() {
              _isPlaying = true;
              _userPaused = false; // User resumed
            });
          }
        }
      },
      onDoubleTap: () {
        // Force refresh on double tap (manual recovery)
        setState(() {
          _userPaused = false; // Reset pause state on refresh
        });
        _forceVideoRefresh();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
    );
  }

  Widget _buildYouTubePlayer() {
    // YouTube support removed - only standard video files supported
    return _buildErrorWidget();
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            const Text(
              'Loading video...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (_videoUrl != null) ...[
              const SizedBox(height: 8),
              const Text(
                'Preparing playback...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Double tap to refresh if stuck',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              _getErrorTitle(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getErrorMessage(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap Retry or double-tap video',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _initializeVideo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorTitle() {
    if (_controller != null && _controller!.value.hasError) {
      return 'Video Playback Error';
    } else if (_videoUrl == null) {
      return 'No Video Source';
    } else {
      return 'Video Failed to Load';
    }
  }

  String _getErrorMessage() {
    if (_videoUrl == null) {
      return 'This post does not contain a video.\nIt may have been removed.';
    } else if (_controller != null && _controller!.value.hasError) {
      final error =
          _controller!.value.errorDescription ?? 'Unknown playback error';
      return 'Error: $error\n\nCheck console logs for details.';
    } else {
      return 'Video failed to initialize.\nCheck console logs for details.';
    }
  }
}
