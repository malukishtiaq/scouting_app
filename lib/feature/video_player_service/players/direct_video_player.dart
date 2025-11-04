import 'dart:async';
import 'package:video_player/video_player.dart' as vp;
import '../services/i_video_player.dart';

class DirectVideoPlayer implements IVideoPlayer {
  vp.VideoPlayerController? _controller;
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

  DirectVideoPlayer(this._url);

  @override
  Future<void> initialize() async {
    try {
      print('🎬 DirectVideoPlayer: Initializing with URL: $_url');
      print('🎬 DirectVideoPlayer: URL validation: ${_isValidVideoUrl(_url)}');

      _controller = vp.VideoPlayerController.networkUrl(Uri.parse(_url));
      print('🎬 DirectVideoPlayer: Controller created, initializing...');

      await _controller!.initialize();
      print('✅ DirectVideoPlayer: Controller initialized successfully');

      _duration = _controller!.value.duration;
      _dur.add(_duration);
      print('⏱️ DirectVideoPlayer: Duration: ${_duration.inSeconds}s');

      _controller!.addListener(() {
        _position = _controller!.value.position;
        _pos.add(_position);

        _isPlaying = _controller!.value.isPlaying;
        _play.add(_isPlaying);
      });

      _isInitialized = true;
      _ready.add(true);
      print('✅ DirectVideoPlayer: Initialization completed successfully');
      print('✅ DirectVideoPlayer: Video ready for playback');
    } catch (e, stackTrace) {
      print('❌ DirectVideoPlayer: Error initializing: $e');
      print('❌ DirectVideoPlayer: Stack trace: $stackTrace');
      print('❌ DirectVideoPlayer: URL: $_url');
      _isInitialized = false;
    }
  }

  bool _isValidVideoUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
    } catch (e) {
      print('⚠️ DirectVideoPlayer: Invalid URL: $url');
      return false;
    }
  }

  @override
  Future<void> play() async {
    if (_controller != null && _isInitialized) {
      await _controller!.play();
    }
  }

  @override
  Future<void> pause() async {
    if (_controller != null && _isInitialized) {
      await _controller!.pause();
    }
  }

  @override
  Future<void> stop() async {
    if (_controller != null && _isInitialized) {
      await _controller!.pause();
      await _controller!.seekTo(Duration.zero);
    }
  }

  @override
  Future<void> seekTo(Duration position) async {
    if (_controller != null && _isInitialized) {
      await _controller!.seekTo(position);
    }
  }

  @override
  Future<void> setMuted(bool muted) async {
    if (_controller != null && _isInitialized) {
      await _controller!.setVolume(muted ? 0 : 1);
      _isMuted = muted;
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
    // Not implemented for direct video
  }

  @override
  Future<void> exitFullscreen() async {
    // Not implemented for direct video
  }

  vp.VideoPlayerController? get controller => _controller;

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
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
      await _controller!.setPlaybackSpeed(speed);
    }
  }
}
