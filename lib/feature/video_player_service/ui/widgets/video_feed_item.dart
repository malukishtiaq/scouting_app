import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/video_item.dart';
import '../../services/i_video_player.dart';
import '../../services/i_video_player_service.dart';
import '../../factories/video_player_factory.dart';
import '../../players/youtube_video_player.dart';
import '../../players/youtube_webview_player.dart';
import '../../players/direct_video_player.dart';
import '../../players/webview_video_player.dart';
import 'video_player_controls.dart';
import 'youtube_webview_widget.dart';
import 'webview_video_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFeedItem extends StatefulWidget {
  final VideoItem item;
  final IVideoPlayerService service;

  const VideoFeedItem({
    super.key,
    required this.item,
    required this.service,
  });

  @override
  State<VideoFeedItem> createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late final IVideoPlayer _player;
  StreamSubscription? _posSub;
  bool _playing = false;
  bool _muted = true;
  bool _isInitialized = false;
  bool _hasError = false;
  double _lastVisibilityFraction =
      1.0; // Track last visibility to reduce logging

  @override
  bool get wantKeepAlive => true; // Keep widget alive when scrolling

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _player = _createPlayer(widget.item);
    _init();
  }

  IVideoPlayer _createPlayer(VideoItem item) {
    return VideoPlayerFactory.createPlayer(item);
  }

  Future<void> _init() async {
    try {
      print('🎬 VideoFeedItem: Initializing video for ${widget.item.id}');
      print('🎬 VideoFeedItem: Video details:');
      print('   - URL: ${widget.item.url}');
      print('   - Source: ${widget.item.source}');
      print('   - Thumbnail: ${widget.item.thumbnailUrl}');
      print('   - Title: ${widget.item.title}');
      print('   - Player type: ${_player.runtimeType}');

      // Initialize the player
      print('🎬 VideoFeedItem: Calling player.initialize()...');
      await _player.initialize();
      print('✅ VideoFeedItem: Player initialized successfully');

      // Listen to player state changes with detailed logging
      print('🎬 VideoFeedItem: Setting up player listeners...');

      _posSub = _player.positionStream.listen(
        (d) {
          if (mounted) {
            setState(() {});
            // Only log every 5 seconds to reduce console spam
            if (d.inSeconds % 5 == 0) {
              print('⏱️ VideoFeedItem: Position updated: ${d.inSeconds}s');
            }
          }
        },
        onError: (error) {
          print('❌ VideoFeedItem: Position stream error: $error');
        },
      );

      _player.durationStream.listen(
        (d) {
          if (mounted) {
            setState(() {});
            // Only log duration once when it's first set
            if (d.inSeconds > 0) {
              print('⏱️ VideoFeedItem: Duration set to ${d.inSeconds}s');
            }
          }
        },
        onError: (error) {
          print('❌ VideoFeedItem: Duration stream error: $error');
        },
      );

      _player.playingStream.listen(
        (p) {
          // Only log state changes, not every update
          if (_playing != p) {
            print(
                '▶️ VideoFeedItem: Playing state changed to $p for ${widget.item.id}');
          }
          if (mounted) {
            setState(() => _playing = p);
          }
        },
        onError: (error) {
          print('❌ VideoFeedItem: Playing stream error: $error');
        },
      );

      _player.readyStream.listen(
        (ready) {
          print(
              '🔧 VideoFeedItem: Ready state changed to $ready for ${widget.item.id}');
          if (!ready && _isInitialized) {
            // Video failed to load, show error
            if (mounted) {
              setState(() {
                _hasError = true;
              });
            }
          }
        },
        onError: (error) {
          print('❌ VideoFeedItem: Ready stream error: $error');
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        },
      );

      // Set initial muted state
      print('🎬 VideoFeedItem: Setting muted state to true...');
      await _player.setMuted(true);
      print('✅ VideoFeedItem: Muted state set successfully');

      if (mounted) {
        setState(() {});
        print('✅ VideoFeedItem: State updated successfully');
      }

      print('✅ VideoFeedItem: Initialization completed for ${widget.item.id}');
      _isInitialized = true;

      // Add timeout for YouTube videos to detect unavailable videos
      if (_player is YouTubeWebViewPlayer) {
        Timer(Duration(seconds: 15), () {
          if (mounted && !_player.isReady && !_hasError) {
            print(
                '⏰ VideoFeedItem: YouTube video timeout - marking as unavailable');
            setState(() {
              _hasError = true;
            });
          }
        });
      }
    } catch (e, stackTrace) {
      print(
          '❌ VideoFeedItem: Error initializing video for ${widget.item.id}: $e');
      print('❌ VideoFeedItem: Stack trace: $stackTrace');
      print('❌ VideoFeedItem: Player type: ${_player.runtimeType}');
      print('❌ VideoFeedItem: Video URL: ${widget.item.url}');
      print('❌ VideoFeedItem: Video source: ${widget.item.source}');

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _posSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Pause video when app goes to background
      if (_playing) {
        _player.pause();
      }
    }
  }

  void _onPlayPause() {
    try {
      print(
          '🎮 VideoFeedItem: Play/Pause button pressed for ${widget.item.id}');
      print('🎮 VideoFeedItem: Current playing state: $_playing');
      print('🎮 VideoFeedItem: Player ready state: ${_player.isReady}');
      print('🎮 VideoFeedItem: Has error: $_hasError');

      if (_hasError) {
        print('❌ VideoFeedItem: Video has error, cannot play/pause');
        return;
      }

      if (_playing) {
        print('⏸️ VideoFeedItem: Pausing video...');
        _player.pause();
      } else if (!_playing && _player.isReady) {
        print('▶️ VideoFeedItem: Playing video...');
        _player.play();
      } else {
        print('⚠️ VideoFeedItem: Player not ready, ignoring play request');
      }
    } catch (e, stackTrace) {
      print('❌ VideoFeedItem: Error in play/pause: $e');
      print('❌ VideoFeedItem: Stack trace: $stackTrace');
    }
  }

  void _onMute() {
    try {
      print('🔇 VideoFeedItem: Mute button pressed for ${widget.item.id}');
      print('🔇 VideoFeedItem: Current muted state: $_muted');

      _player.setMuted(!_muted);
      setState(() => _muted = !_muted);

      print('🔇 VideoFeedItem: Muted state changed to: $_muted');
    } catch (e, stackTrace) {
      print('❌ VideoFeedItem: Error in mute toggle: $e');
      print('❌ VideoFeedItem: Stack trace: $stackTrace');
    }
  }

  void _onFullscreen() {
    try {
      print(
          '🔍 VideoFeedItem: Fullscreen button pressed for ${widget.item.id}');
      _player.enterFullscreen();
    } catch (e, stackTrace) {
      print('❌ VideoFeedItem: Error entering fullscreen: $e');
      print('❌ VideoFeedItem: Stack trace: $stackTrace');
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    try {
      // Only log when visibility changes significantly or when state changes
      final wasVisible = _lastVisibilityFraction >= 0.8;
      final isVisible = info.visibleFraction >= 0.8;

      if (wasVisible != isVisible || (_playing && info.visibleFraction < 0.8)) {
        print('👁️ VideoFeedItem: Visibility changed for ${widget.item.id}');
        print('👁️ VideoFeedItem: Visible fraction: ${info.visibleFraction}');
        print('👁️ VideoFeedItem: Currently playing: $_playing');
      }

      // Pause immediately when video starts going out of screen (less than 80% visible)
      if (info.visibleFraction < 0.8) {
        if (_playing) {
          print(
              '⏸️ VideoFeedItem: Video going out of view (${(info.visibleFraction * 100).toStringAsFixed(0)}% visible), pausing immediately...');
          _player.pause();
        }
      } else if (info.visibleFraction >= 0.8) {
        if (!wasVisible) {
          print(
              '👁️ VideoFeedItem: Video fully in view (${(info.visibleFraction * 100).toStringAsFixed(0)}% visible)');
        }
        // Video is fully visible but we don't auto-play
        // User must tap to play
      }

      _lastVisibilityFraction = info.visibleFraction;
    } catch (e, stackTrace) {
      print('❌ VideoFeedItem: Error in visibility change: $e');
      print('❌ VideoFeedItem: Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return VisibilityDetector(
      key: Key(widget.item.id),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        child: _buildVideoPlayer(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    // Build a generic video player container that works with any player type
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.black,
      child: Stack(
        children: [
          // Video player content
          _buildPlayerContent(),
          // Video controls overlay - only show for non-YouTube players
          if (_player is! YouTubeWebViewPlayer)
            VideoPlayerControls(
              isPlaying: _playing,
              isMuted: _muted,
              onPlayPause: _onPlayPause,
              onMute: _onMute,
              onFullscreen: _onFullscreen,
            ),
        ],
      ),
    );
  }

  Widget _buildPlayerContent() {
    // Display the actual video player based on the player type
    if (_player is YouTubeWebViewPlayer) {
      final webViewPlayer = _player;
      return Stack(
        children: [
          // Show thumbnail as background when not playing
          if (!_playing &&
              widget.item.thumbnailUrl != null &&
              widget.item.thumbnailUrl!.isNotEmpty)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: widget.item.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 32,
                    ),
                  ),
                ),
                memCacheWidth: 400,
                memCacheHeight: 300,
                maxWidthDiskCache: 400,
                maxHeightDiskCache: 300,
              ),
            ),
          // Error message overlay for unavailable videos
          if (_hasError || (!_player.isReady && _isInitialized))
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Video unavailable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Watch on YouTube',
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // Video player - let YouTube handle its own controls
          Container(
            width: double.infinity,
            height: double.infinity,
            child: YouTubeWebViewWidget(
              player: webViewPlayer,
              aspectRatio: 16 / 9,
            ),
          ),
          // Don't show Flutter play overlay for YouTube WebView - it has its own built-in overlay
          // The JavaScript overlay in the webview handles play/pause
        ],
      );
    } else if (_player is YouTubeVideoPlayer) {
      // Fallback for native YouTube player if needed
      final youtubePlayer = _player;
      final controller = youtubePlayer.controller;

      if (controller != null && controller.value.isReady) {
        return GestureDetector(
          onTap: () {
            print('🎯 VideoFeedItem: Video area tapped for ${widget.item.id}');
            print('🎯 VideoFeedItem: Current playing state: $_playing');
            print('🎯 VideoFeedItem: Player ready state: ${_player.isReady}');

            if (_player.isReady) {
              if (_playing) {
                print('⏸️ VideoFeedItem: Pausing video...');
                _onPlayPause();
              } else {
                print('▶️ VideoFeedItem: Playing video...');
                _onPlayPause();
              }
            } else {
              print('⏳ VideoFeedItem: Player not ready yet');
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: YoutubePlayer(
              controller: controller,
              onReady: () {
                print('VideoFeedItem: YouTube native player ready');
                setState(() {});
              },
            ),
          ),
        );
      } else {
        // Show loading state for native player
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }
    } else if (_player is DirectVideoPlayer) {
      // Handle direct video player
      final directPlayer = _player;
      final controller = directPlayer.controller;

      if (controller != null && controller.value.isInitialized) {
        return GestureDetector(
          onTap: () {
            print(
                '🎯 VideoFeedItem: Direct video area tapped for ${widget.item.id}');
            print('🎯 VideoFeedItem: Current playing state: $_playing');
            print('🎯 VideoFeedItem: Player ready state: ${_player.isReady}');

            if (_player.isReady) {
              if (_playing) {
                print('⏸️ VideoFeedItem: Pausing direct video...');
                _onPlayPause();
              } else {
                print('▶️ VideoFeedItem: Playing direct video...');
                _onPlayPause();
              }
            } else {
              print('⏳ VideoFeedItem: Direct player not ready yet');
            }
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        );
      } else {
        // Show loading state for direct player
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }
    } else if (_player is WebViewVideoPlayer) {
      // Handle WebView video player
      final webViewPlayer = _player;
      return GestureDetector(
        onTap: () {
          print(
              '🎯 VideoFeedItem: WebView video area tapped for ${widget.item.id}');
          print('🎯 VideoFeedItem: Current playing state: $_playing');
          print('🎯 VideoFeedItem: Player ready state: ${_player.isReady}');

          if (_player.isReady) {
            if (_playing) {
              print('⏸️ VideoFeedItem: Pausing WebView video...');
              _onPlayPause();
            } else {
              print('▶️ VideoFeedItem: Playing WebView video...');
              _onPlayPause();
            }
          } else {
            print('⏳ VideoFeedItem: WebView player not ready yet');
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: WebViewVideoWidget(
            player: webViewPlayer,
            aspectRatio: 16 / 9,
          ),
        ),
      );
    } else {
      // Generic video player content for unknown player types
      return GestureDetector(
        onTap: () {
          print(
              '🎯 VideoFeedItem: Generic video area tapped for ${widget.item.id}');
          print('🎯 VideoFeedItem: Current playing state: $_playing');
          print('🎯 VideoFeedItem: Player ready state: ${_player.isReady}');
          print('🎯 VideoFeedItem: Player type: ${_player.runtimeType}');

          if (_player.isReady) {
            if (_playing) {
              print('⏸️ VideoFeedItem: Pausing generic video...');
              _onPlayPause();
            } else {
              print('▶️ VideoFeedItem: Playing generic video...');
              _onPlayPause();
            }
          } else {
            print('⏳ VideoFeedItem: Generic player not ready yet');
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white.withOpacity(0.7),
                ),
                const SizedBox(height: 16),
                Text(
                  'Video Player',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Source: ${widget.item.source.name}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Type: ${_player.runtimeType}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
