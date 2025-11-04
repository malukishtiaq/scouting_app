import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/i_video_player.dart';

class YouTubeWebViewPlayer implements IVideoPlayer {
  WebViewController? _controller;
  final _pos = StreamController<Duration>.broadcast();
  final _dur = StreamController<Duration>.broadcast();
  final _play = StreamController<bool>.broadcast();
  final _ready = StreamController<bool>.broadcast();
  final _errorStream = StreamController<String>.broadcast();

  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isMuted = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  final String _videoId;

  YouTubeWebViewPlayer(this._videoId);

  @override
  Future<void> initialize() async {
    try {
      print('🎬 YouTubeWebViewPlayer: Initializing with video ID: $_videoId');
      print(
          '🎬 YouTubeWebViewPlayer: Video ID validation: ${_isValidYouTubeId(_videoId)}');

      // Create custom HTML with YouTube iframe that handles user gestures better
      final customHtml = '''
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { margin: 0; padding: 0; background: black; overflow: hidden; }
        #player-container { 
            position: relative;
            width: 100%; 
            height: 100vh;
        }
        #player { 
            position: absolute;
            top: 0;
            left: 0;
            width: 100%; 
            height: 100%; 
            border: none; 
        }
    </style>
</head>
<body>
    <div id="player-container">
        <iframe id="player"
                src="https://www.youtube.com/embed/$_videoId?autoplay=0&mute=0&controls=1&rel=0&showinfo=0&modestbranding=1&playsinline=1&fs=1&enablejsapi=1&origin=https://www.youtube.com" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen" 
                allowfullscreen
                webkitallowfullscreen
                mozallowfullscreen
                frameborder="0">
        </iframe>
    </div>
    
    <script>
        let isPlaying = false;
        let player = null;
        
        function startVideo() {
            console.log('🎬 Starting video playback');
            
            // Try to play the video using YouTube API
            if (player && player.playVideo) {
                player.playVideo();
                console.log('🎬 Video started using YouTube API');
            } else {
                // Fallback: reload iframe with autoplay
                const iframe = document.getElementById('player');
                let src = iframe.src;
                if (src.includes('autoplay=0')) {
                    iframe.src = src.replace('autoplay=0', 'autoplay=1');
                    console.log('🎬 Video started using iframe reload');
                }
            }
            
            // Set playing state
            isPlaying = true;
            
            // Notify Flutter
            if (window.VideoPlayerChannel) {
                window.VideoPlayerChannel.postMessage('play');
                console.log('🎬 Sent play message to Flutter');
            }
        }
        
        function pauseVideo() {
            console.log('⏸️ Pause requested for YouTube video');
            isPlaying = false;
            
            try {
                // Try multiple methods to ensure video pauses
                const iframe = document.getElementById('player');
                
                // Method 1: Try YouTube API if available
                if (player && player.pauseVideo) {
                    player.pauseVideo();
                    console.log('⏸️ Video paused using YouTube API');
                }
                
                // Method 2: Use postMessage to iframe
                if (iframe && iframe.contentWindow) {
                    iframe.contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
                    console.log('⏸️ Video paused using postMessage');
                }
                
                // Method 3: Reload iframe without autoplay as last resort
                if (iframe) {
                    let src = iframe.src;
                    if (src.includes('autoplay=1')) {
                        iframe.src = src.replace('autoplay=1', 'autoplay=0');
                        console.log('⏸️ Video paused using iframe reload');
                    }
                }
                
                console.log('✅ YouTube video pause completed');
            } catch (e) {
                console.log('❌ Error pausing YouTube video:', e);
            }
            
            // Notify Flutter
            if (window.VideoPlayerChannel) {
                window.VideoPlayerChannel.postMessage('pause');
            }
        }
        
        // Expose functions to Flutter
        window.playVideo = function() {
            console.log('playVideo called from Flutter');
            startVideo();
            return true;
        };
        
        window.pauseVideo = function() {
            // Remove redundant logging to prevent console spam
            pauseVideo();
            return true;
        };
        
        window.setMuted = function(muted) {
            console.log('setMuted called:', muted);
            return true;
        };
        
        // Initialize YouTube API when iframe loads
        function onYouTubeIframeAPIReady() {
            console.log('🎬 YouTube API ready');
            try {
                player = new YT.Player('player', {
                    events: {
                        'onReady': onPlayerReady,
                        'onStateChange': onPlayerStateChange
                    }
                });
            } catch (e) {
                console.log('❌ YouTube API initialization failed:', e);
            }
        }
        
        function onPlayerReady(event) {
            console.log('🎬 YouTube player ready');
        }
        
        function onPlayerStateChange(event) {
            console.log('🎬 YouTube player state changed:', event.data);
            if (event.data === YT.PlayerState.PLAYING) {
                isPlaying = true;
            } else if (event.data === YT.PlayerState.PAUSED) {
                isPlaying = false;
            }
        }
        
        console.log('YouTube player HTML loaded');
    </script>
    <script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>
      ''';

      final dataUri =
          'data:text/html;charset=utf-8,' + Uri.encodeComponent(customHtml);

      print(
          '🎬 YouTubeWebViewPlayer: Loading custom HTML with video ID: $_videoId');

      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..addJavaScriptChannel('VideoPlayerChannel',
            onMessageReceived: (JavaScriptMessage message) {
          _handleJavaScriptMessage(message.message);
        })
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (String url) {
            print('🌐 YouTubeWebViewPlayer: Page loading started: $url');
          },
          onPageFinished: (String url) {
            print('✅ YouTubeWebViewPlayer: Page loading finished: $url');
            _isInitialized = true;
            _ready.add(true);
            print('✅ YouTubeWebViewPlayer: Player marked as initialized');

            // Custom HTML already includes all necessary JavaScript
            print(
                '🔧 YouTubeWebViewPlayer: Custom HTML loaded with built-in JavaScript');
          },
          onWebResourceError: (WebResourceError error) {
            print(
                '❌ YouTubeWebViewPlayer: Web resource error: ${error.description}');
            print('❌ YouTubeWebViewPlayer: Error code: ${error.errorCode}');
            print('❌ YouTubeWebViewPlayer: Error type: ${error.errorType}');
            print(
                '❌ YouTubeWebViewPlayer: Is for main frame: ${error.isForMainFrame}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print(
                '🧭 YouTubeWebViewPlayer: Navigation request: ${request.url}');
            return NavigationDecision.navigate;
          },
        ))
        ..addJavaScriptChannel(
          'VideoPlayerChannel',
          onMessageReceived: (JavaScriptMessage message) {
            print(
                '📨 YouTubeWebViewPlayer: JS message received: ${message.message}');
            _handleJavaScriptMessage(message.message);
          },
        );

      print('🎬 YouTubeWebViewPlayer: Loading YouTube embed page...');
      await _controller!.loadRequest(Uri.parse(dataUri));
      print('✅ YouTubeWebViewPlayer: Initialization completed successfully');
    } catch (e, stackTrace) {
      print('❌ YouTubeWebViewPlayer: Error initializing: $e');
      print('❌ YouTubeWebViewPlayer: Stack trace: $stackTrace');
      print('❌ YouTubeWebViewPlayer: Video ID: $_videoId');
      _isInitialized = false;
    }
  }

  bool _isValidYouTubeId(String videoId) {
    // YouTube video IDs are typically 11 characters long
    final isValid =
        videoId.length == 11 && RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(videoId);

    if (!isValid) {
      print('❌ YouTubeWebViewPlayer: Invalid video ID format: $videoId');
      print(
          '❌ YouTubeWebViewPlayer: Expected 11 characters, got ${videoId.length}');
      print(
          '❌ YouTubeWebViewPlayer: Characters: ${videoId.split('').join(', ')}');
    } else {
      print('✅ YouTubeWebViewPlayer: Valid video ID format: $videoId');
    }

    return isValid;
  }

  final js = '''
      (function() {
        let videoElement = null;
        let userGestureReceived = false;
        
        // Function to find video element
        function findVideoElement() {
          // Look for YouTube iframe first, then video element
          videoElement = document.querySelector('iframe[src*="youtube"]') || document.querySelector('video');
          if (videoElement) {
            console.log('Video element found:', videoElement.tagName);
            return true;
          }
          return false;
        }
        
        // Wait for video element to be available
        function waitForVideo() {
          if (findVideoElement()) {
            setupVideoListeners();
          } else {
            setTimeout(waitForVideo, 100);
          }
        }
        
        // Setup video event listeners
        function setupVideoListeners() {
          if (!videoElement) return;
          
          console.log('Setting up listeners for:', videoElement.tagName);
          
          // For YouTube iframes, we need to listen on the document level
          // because iframe events don't bubble up properly
          if (videoElement.tagName === 'IFRAME') {
            console.log('Setting up iframe-specific listeners');
            
            // Listen for any user interaction on the document
            document.addEventListener('click', function(event) {
              userGestureReceived = true;
              console.log('Document clicked - user gesture received for iframe');
            });
            
            document.addEventListener('touchstart', function(event) {
              userGestureReceived = true;
              console.log('Document touched - user gesture received for iframe');
            });
            
            document.addEventListener('mousedown', function(event) {
              userGestureReceived = true;
              console.log('Document mousedown - user gesture received for iframe');
            });
            
            // Also try to listen on the iframe itself
            videoElement.addEventListener('load', function() {
              console.log('YouTube iframe loaded');
              userGestureReceived = true; // Assume load means user interaction
            });
            
            // Listen for iframe error events
            videoElement.addEventListener('error', function() {
              console.log('YouTube iframe failed to load');
              if (window.VideoPlayerChannel) {
                window.VideoPlayerChannel.postMessage('error');
              }
            });
            
            // Handle YouTube API errors gracefully
            window.addEventListener('error', function(e) {
              if (e.message && e.message.includes('isExternalMethodAvailable')) {
                console.log('YouTube API error handled gracefully:', e.message);
                // Don't propagate this error as it's expected in some cases
                e.preventDefault();
                return false;
              }
            });
            
          } else {
            // For regular video elements, listen directly on the element AND document
            console.log('Setting up video element listeners');
            
            // Direct video element listeners
            videoElement.addEventListener('click', function(event) {
              userGestureReceived = true;
              console.log('Video clicked - user gesture received');
              event.preventDefault();
              event.stopPropagation();
            });
            
            videoElement.addEventListener('touchstart', function(event) {
              userGestureReceived = true;
              console.log('Video touched - user gesture received');
              event.preventDefault();
              event.stopPropagation();
            });
            
            videoElement.addEventListener('mousedown', function(event) {
              userGestureReceived = true;
              console.log('Video mousedown - user gesture received');
              event.preventDefault();
              event.stopPropagation();
            });
            
            // Also listen on the document for any interaction
            document.addEventListener('click', function(event) {
              userGestureReceived = true;
              console.log('Document clicked - user gesture received for video');
            });
            
            document.addEventListener('touchstart', function(event) {
              userGestureReceived = true;
              console.log('Document touched - user gesture received for video');
            });
            
            document.addEventListener('mousedown', function(event) {
              userGestureReceived = true;
              console.log('Document mousedown - user gesture received for video');
            });
          }
          
          // Listen for video events
          if (videoElement.tagName === 'VIDEO') {
            videoElement.addEventListener('play', function() {
              VideoPlayerChannel.postMessage('play');
            });
            
            videoElement.addEventListener('pause', function() {
              VideoPlayerChannel.postMessage('pause');
            });
            
            videoElement.addEventListener('timeupdate', function() {
              VideoPlayerChannel.postMessage('time:' + videoElement.currentTime);
            });
            
            videoElement.addEventListener('loadedmetadata', function() {
              VideoPlayerChannel.postMessage('duration:' + videoElement.duration);
            });
          }
        }
        
        // Start waiting for video element
        waitForVideo();
        
        // Global user gesture detection - always active
        document.addEventListener('click', function() {
          userGestureReceived = true;
          console.log('Global click detected - user gesture received');
        });
        
        document.addEventListener('touchstart', function() {
          userGestureReceived = true;
          console.log('Global touch detected - user gesture received');
        });
        
        document.addEventListener('mousedown', function() {
          userGestureReceived = true;
          console.log('Global mousedown detected - user gesture received');
        });
        
        // Expose functions to Flutter
        window.playVideo = function() {
          console.log('playVideo called - videoElement:', !!videoElement, 'userGestureReceived:', userGestureReceived);
          
          if (videoElement) {
            try {
              if (videoElement.tagName === 'IFRAME') {
                // For YouTube iframes, try to play regardless of user gesture
                // YouTube's user gesture detection is often unreliable in WebViews
                console.log('Attempting to play YouTube iframe...');
                videoElement.contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
                
                // Also try to enable autoplay by modifying the iframe src
                if (!userGestureReceived) {
                  console.log('No user gesture detected, trying to enable autoplay...');
                  const currentSrc = videoElement.src;
                  if (currentSrc.includes('autoplay=0')) {
                    videoElement.src = currentSrc.replace('autoplay=0', 'autoplay=1');
                    console.log('Updated iframe src to enable autoplay');
                  }
                }
                
                return true;
              } else {
                // For regular video elements, be more aggressive about playing
                console.log('Attempting to play video element...');
                
                // Try to play regardless of user gesture first
                const playPromise = videoElement.play();
                
                if (playPromise !== undefined) {
                  playPromise.then(function() {
                    console.log('Video play succeeded');
                    userGestureReceived = true; // Mark as received for future calls
                  }).catch(function(error) {
                    console.log('Video play failed:', error);
                    
                    // If play failed due to user gesture, try to enable autoplay
                    if (error.name === 'NotAllowedError') {
                      console.log('Play failed due to user gesture, trying to enable autoplay...');
                      videoElement.setAttribute('autoplay', 'true');
                      videoElement.setAttribute('playsinline', 'true');
                      
                      // Try again after a short delay
                      setTimeout(function() {
                        videoElement.play().then(function() {
                          console.log('Video play succeeded after autoplay enable');
                          userGestureReceived = true;
                        }).catch(function(e) {
                          console.log('Video play still failed:', e);
                        });
                      }, 100);
                    }
                  });
                }
                
                return true;
              }
            } catch (e) {
              console.log('Play failed:', e);
              return false;
            }
          } else {
            console.log('Cannot play: no video element');
            return false;
          }
        };
        
        // Removed duplicate pauseVideo function - using the main one above
        
        window.seekVideo = function(time) {
          if (videoElement) {
            videoElement.currentTime = time;
            return true;
          }
          return false;
        };
        
        window.setMuted = function(muted) {
          if (videoElement) {
            try {
              if (videoElement.tagName === 'IFRAME') {
                // For YouTube iframes, use postMessage
                videoElement.contentWindow.postMessage('{"event":"command","func":"' + (muted ? 'mute' : 'unMute') + '","args":""}', '*');
                return true;
              } else {
                // For regular video elements
                videoElement.muted = muted;
                return true;
              }
            } catch (e) {
              console.log('Mute failed:', e);
              return false;
            }
          }
          return false;
        };
        
        window.getVideoState = function() {
          if (!videoElement) return null;
          return {
            currentTime: videoElement.currentTime,
            duration: videoElement.duration,
            paused: videoElement.paused,
            muted: videoElement.muted,
            readyState: videoElement.readyState
          };
        };
      })();
    ''';

  void _handleJavaScriptMessage(String message) {
    print('🎬 YouTubeWebViewPlayer: JS message: $message');

    if (message.startsWith('play')) {
      print('🎬 YouTubeWebViewPlayer: Video play message received');
      _isPlaying = true;
      _play.add(true);
      print('✅ YouTubeWebViewPlayer: Playback started successfully');
    } else if (message.startsWith('pause')) {
      print('⏸️ YouTubeWebViewPlayer: Video pause message received');
      _isPlaying = false;
      _play.add(false);
      print('⏸️ YouTubeWebViewPlayer: Video paused');
    } else if (message.startsWith('time:')) {
      final timeStr = message.substring(5);
      final seconds = double.tryParse(timeStr) ?? 0.0;
      _position = Duration(milliseconds: (seconds * 1000).round());
      _pos.add(_position);
    } else if (message.startsWith('duration:')) {
      final durationStr = message.substring(9);
      final seconds = double.tryParse(durationStr) ?? 0.0;
      _duration = Duration(milliseconds: (seconds * 1000).round());
      _dur.add(_duration);
    } else if (message.startsWith('error')) {
      print('❌ YouTubeWebViewPlayer: Video error detected');
      _isPlaying = false; // Ensure we're not in playing state
      _play.add(false); // Ensure player is not marked as playing
      _errorStream.add('Video unavailable or failed to load.');
      // Don't mark as error for YouTube API issues that are handled gracefully
      if (!message.contains('isExternalMethodAvailable')) {
        print(
            '❌ YouTubeWebViewPlayer: Video failed to load - video may be unavailable');
        print('❌ YouTubeWebViewPlayer: Video ID: $_videoId');
        _isInitialized = false;
        _ready.add(false);
      } else {
        print('⚠️ YouTubeWebViewPlayer: YouTube API error handled gracefully');
      }
    }
  }

  @override
  Future<void> play() async {
    print('▶️ YouTubeWebViewPlayer: Play requested for video ID: $_videoId');
    print(
        '▶️ YouTubeWebViewPlayer: Controller available: ${_controller != null}');
    print('▶️ YouTubeWebViewPlayer: Is initialized: $_isInitialized');

    if (_controller != null && _isInitialized) {
      try {
        print('▶️ YouTubeWebViewPlayer: Attempting to start playback...');

        final result = await _controller!
            .runJavaScriptReturningResult('window.playVideo()');

        print('▶️ YouTubeWebViewPlayer: Play result: $result');

        if (result == 'true' || result == true) {
          print('✅ YouTubeWebViewPlayer: Playback started successfully');
          _isPlaying = true;
          _play.add(true);
        } else {
          print(
              '⚠️ YouTubeWebViewPlayer: Play command sent, waiting for response...');
          // The custom HTML will handle the play and send us a message
        }
      } catch (e, stackTrace) {
        print('❌ YouTubeWebViewPlayer: Error playing: $e');
        print('❌ YouTubeWebViewPlayer: Stack trace: $stackTrace');
        print('❌ YouTubeWebViewPlayer: Video ID: $_videoId');
      }
    } else {
      print('❌ YouTubeWebViewPlayer: Cannot play - not initialized');
      print('❌ YouTubeWebViewPlayer: Controller: ${_controller != null}');
      print('❌ YouTubeWebViewPlayer: Initialized: $_isInitialized');
    }
  }

  @override
  Future<void> pause() async {
    print('⏸️ YouTubeWebViewPlayer: Pause requested for video ID: $_videoId');
    print(
        '⏸️ YouTubeWebViewPlayer: Controller available: ${_controller != null}');
    print('⏸️ YouTubeWebViewPlayer: Is initialized: $_isInitialized');
    print('⏸️ YouTubeWebViewPlayer: Currently playing: $_isPlaying');

    if (_controller != null && _isInitialized) {
      try {
        print('⏸️ YouTubeWebViewPlayer: Executing pause command...');
        await _controller!.runJavaScript('window.pauseVideo()');
        _isPlaying = false;
        _play.add(false);
        print('✅ YouTubeWebViewPlayer: Pause command executed successfully');
      } catch (e, stackTrace) {
        print('❌ YouTubeWebViewPlayer: Error pausing: $e');
        print('❌ YouTubeWebViewPlayer: Stack trace: $stackTrace');
        // Still update state even if command fails
        _isPlaying = false;
        _play.add(false);
      }
    } else {
      print('❌ YouTubeWebViewPlayer: Cannot pause - not initialized');
      print('❌ YouTubeWebViewPlayer: Controller: ${_controller != null}');
      print('❌ YouTubeWebViewPlayer: Initialized: $_isInitialized');
      // Update state anyway to prevent stuck playing state
      _isPlaying = false;
      _play.add(false);
    }
  }

  @override
  Future<void> stop() async {
    await pause();
    await seekTo(Duration.zero);
  }

  @override
  Future<void> seekTo(Duration position) async {
    if (_controller != null && _isInitialized) {
      try {
        final seconds = position.inSeconds;
        await _controller!.runJavaScript('window.seekVideo($seconds)');
        _position = position;
        _pos.add(_position);
        print('YouTubeWebViewPlayer: Seeked to ${position.inSeconds}s');
      } catch (e) {
        print('YouTubeWebViewPlayer: Error seeking: $e');
      }
    }
  }

  @override
  Future<void> setMuted(bool muted) async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript('window.setMuted($muted)');
        _isMuted = muted;
        print('YouTubeWebViewPlayer: Mute set to: $muted');
      } catch (e) {
        print('YouTubeWebViewPlayer: Error setting muted: $e');
      }
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            'if(document.querySelector("video")){document.querySelector("video").playbackRate = $speed;}');
        print('YouTubeWebViewPlayer: Playback speed set to: $speed');
      } catch (e) {
        print('YouTubeWebViewPlayer: Error setting playback speed: $e');
      }
    }
  }

  @override
  Future<void> enterFullscreen() async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            'if(document.querySelector("video")){document.querySelector("video").requestFullscreen();}');
        print('YouTubeWebViewPlayer: Entered fullscreen');
      } catch (e) {
        print('YouTubeWebViewPlayer: Error entering fullscreen: $e');
      }
    }
  }

  @override
  Future<void> exitFullscreen() async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            'if(document.fullscreenElement){document.exitFullscreen();}');
        print('YouTubeWebViewPlayer: Exited fullscreen');
      } catch (e) {
        print('YouTubeWebViewPlayer: Error exiting fullscreen: $e');
      }
    }
  }

  @override
  bool get isPlaying => _isPlaying;

  @override
  bool get isReady => _isInitialized;

  @override
  bool get isMuted => _isMuted;

  @override
  Duration get position => _position;

  @override
  Duration get duration => _duration;

  @override
  Stream<bool> get playingStream => _play.stream;

  @override
  Stream<bool> get readyStream => _ready.stream;

  @override
  Stream<Duration> get positionStream => _pos.stream;

  @override
  Stream<Duration> get durationStream => _dur.stream;

  Stream<String> get errorStream => _errorStream.stream;

  WebViewController? get webViewController => _controller;

  @override
  Future<void> dispose() async {
    _pos.close();
    _dur.close();
    _play.close();
    _ready.close();
  }
}
