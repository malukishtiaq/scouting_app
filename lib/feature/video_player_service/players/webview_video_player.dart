import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/i_video_player.dart';

class WebViewVideoPlayer implements IVideoPlayer {
  WebViewController? _controller;
  final _pos = StreamController<Duration>.broadcast();
  final _dur = StreamController<Duration>.broadcast();
  final _play = StreamController<bool>.broadcast();
  final _ready = StreamController<bool>.broadcast();

  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isMuted = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  final String _url;

  WebViewVideoPlayer(this._url);

  @override
  Future<void> initialize() async {
    try {
      print('🎬 WebViewVideoPlayer: Initializing with URL: $_url');
      print('🎬 WebViewVideoPlayer: URL validation: ${_isValidUrl(_url)}');

      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (String url) {
            print('🌐 WebViewVideoPlayer: Page loading started: $url');
          },
          onPageFinished: (String url) {
            print('✅ WebViewVideoPlayer: Page loading finished: $url');
            print(
                '🔧 WebViewVideoPlayer: Injecting video detection JavaScript...');
            _injectVideoDetectionJavaScript();
          },
          onWebResourceError: (WebResourceError error) {
            print(
                '❌ WebViewVideoPlayer: Web resource error: ${error.description}');
            print('❌ WebViewVideoPlayer: Error code: ${error.errorCode}');
          },
        ))
        ..addJavaScriptChannel(
          'VideoPlayerChannel',
          onMessageReceived: (JavaScriptMessage message) {
            print('📨 WebViewVideoPlayer: JS message: ${message.message}');
            _handleJavaScriptMessage(message.message);
          },
        )
        ..loadRequest(Uri.parse(_url));

      _isInitialized = true;
      _ready.add(true);
      print('✅ WebViewVideoPlayer: Initialization completed');
    } catch (e, stackTrace) {
      print('❌ WebViewVideoPlayer: Error initializing: $e');
      print('❌ WebViewVideoPlayer: Stack trace: $stackTrace');
      print('❌ WebViewVideoPlayer: URL: $_url');
      _isInitialized = false;
    }
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
    } catch (e) {
      print('⚠️ WebViewVideoPlayer: Invalid URL: $url');
      return false;
    }
  }

  void _injectVideoDetectionJavaScript() {
    if (_controller == null) return;

    final js = '''
      (function() {
        console.log('WebViewVideoPlayer: Video detection script loaded');
        
        // Function to find video elements
        function findVideoElement() {
          const video = document.querySelector('video');
          if (video) {
            console.log('WebViewVideoPlayer: Video element found');
            return video;
          }
          return null;
        }
        
        // Wait for video element to be available
        function waitForVideo() {
          const video = findVideoElement();
          if (video) {
            setupVideoListeners(video);
          } else {
            setTimeout(waitForVideo, 100);
          }
        }
        
        // Setup video event listeners
        function setupVideoListeners(video) {
          console.log('WebViewVideoPlayer: Setting up video listeners');
          
          video.addEventListener('play', function() {
            VideoPlayerChannel.postMessage('play');
          });
          
          video.addEventListener('pause', function() {
            VideoPlayerChannel.postMessage('pause');
          });
          
          video.addEventListener('timeupdate', function() {
            VideoPlayerChannel.postMessage('time:' + video.currentTime);
          });
          
          video.addEventListener('loadedmetadata', function() {
            VideoPlayerChannel.postMessage('duration:' + video.duration);
          });
          
          video.addEventListener('error', function(e) {
            VideoPlayerChannel.postMessage('error:' + e.message);
          });
        }
        
        // Start waiting for video element
        waitForVideo();
        
        // Expose functions to Flutter
        window.playVideo = function() {
          const video = findVideoElement();
          if (video) {
            try {
              video.play();
              return true;
            } catch (e) {
              console.log('WebViewVideoPlayer: Play failed:', e);
              return false;
            }
          }
          return false;
        };
        
        window.pauseVideo = function() {
          const video = findVideoElement();
          if (video) {
            video.pause();
            return true;
          }
          return false;
        };
        
        window.seekVideo = function(time) {
          const video = findVideoElement();
          if (video) {
            video.currentTime = time;
            return true;
          }
          return false;
        };
        
        window.setMuted = function(muted) {
          const video = findVideoElement();
          if (video) {
            video.muted = muted;
            return true;
          }
          return false;
        };
      })();
    ''';

    _controller!.runJavaScript(js);
  }

  void _handleJavaScriptMessage(String message) {
    print('📨 WebViewVideoPlayer: Processing JS message: $message');

    if (message.startsWith('play')) {
      _isPlaying = true;
      _play.add(true);
    } else if (message.startsWith('pause')) {
      _isPlaying = false;
      _play.add(false);
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
    } else if (message.startsWith('error:')) {
      final errorMsg = message.substring(6);
      print('❌ WebViewVideoPlayer: Video error: $errorMsg');
    }
  }

  @override
  Future<void> play() async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            "try{document.querySelector('video')?.play();}catch(e){}");
        _isPlaying = true;
        _play.add(true);
      } catch (e) {
        print('WebViewVideoPlayer: Error playing: $e');
      }
    }
  }

  @override
  Future<void> pause() async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            "try{document.querySelector('video')?.pause();}catch(e){}");
        _isPlaying = false;
        _play.add(false);
      } catch (e) {
        print('WebViewVideoPlayer: Error pausing: $e');
      }
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
        await _controller!.runJavaScript(
            "try{document.querySelector('video').currentTime=${position.inSeconds};}catch(e){}");
        _position = position;
        _pos.add(_position);
      } catch (e) {
        print('WebViewVideoPlayer: Error seeking: $e');
      }
    }
  }

  @override
  Future<void> setMuted(bool muted) async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            "try{document.querySelector('video').muted=${muted ? 'true' : 'false'};}catch(e){}");
        _isMuted = muted;
      } catch (e) {
        print('WebViewVideoPlayer: Error setting muted: $e');
      }
    }
  }

  @override
  bool get isPlaying => _isPlaying;
  @override
  bool get isMuted => _isMuted;
  @override
  Duration get position => _position;
  @override
  Duration get duration => _duration;
  @override
  bool get isReady => _isInitialized;

  @override
  Stream<bool> get playingStream => _play.stream;
  @override
  Stream<bool> get readyStream => _ready.stream;
  @override
  Stream<Duration> get positionStream => _pos.stream;
  @override
  Stream<Duration> get durationStream => _dur.stream;

  @override
  Future<void> enterFullscreen() async {
    // Not implemented for WebView
  }

  @override
  Future<void> exitFullscreen() async {
    // Not implemented for WebView
  }

  WebViewController? get controller => _controller;

  @override
  Future<void> dispose() async {
    await _pos.close();
    await _dur.close();
    await _play.close();
    await _ready.close();
  }

  // Legacy support methods
  Stream<Duration> get position$ => positionStream;
  Stream<Duration?> get duration$ => durationStream.map((d) => d);
  Stream<bool> get playing$ => playingStream;
  bool get isInitialized => _isInitialized;
  Future<void> setPlaybackSpeed(double speed) async {
    if (_controller != null && _isInitialized) {
      try {
        await _controller!.runJavaScript(
            "try{document.querySelector('video').playbackRate=$speed;}catch(e){}");
      } catch (e) {
        print('WebViewVideoPlayer: Error setting speed: $e');
      }
    }
  }
}
