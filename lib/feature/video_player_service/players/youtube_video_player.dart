import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../services/i_video_player.dart';

class YouTubeVideoPlayer implements IVideoPlayer {
  YoutubePlayerController? _ctl;
  final _pos = StreamController<Duration>.broadcast();
  final _dur = StreamController<Duration?>.broadcast();
  final _play = StreamController<bool>.broadcast();
  final _ready = StreamController<bool>.broadcast();
  bool _isReady = false;
  bool _hasTimedOut = false;
  String? _videoId;

  YouTubeVideoPlayer([this._videoId]);

  @override
  Future<void> initialize() async {
    try {
      print('YouTubeVideoPlayer: Initializing with video ID: $_videoId');

      if (_videoId == null || _videoId!.isEmpty) {
        print('YouTubeVideoPlayer: No video ID provided');
        return;
      }

      // Create controller with proper error handling
      _ctl = YoutubePlayerController(
        initialVideoId: _videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
          controlsVisibleAtStart: false,
          enableCaption: false,
          hideControls: true,
          forceHD: false,
          useHybridComposition: true,
        ),
      );

      // Add listener for state changes
      _ctl!.addListener(() {
        final value = _ctl!.value;
        print(
            'YouTubeVideoPlayer: Controller state changed - isReady: ${value.isReady}, isPlaying: ${value.isPlaying}, playerState: ${value.playerState}, videoId: ${value.metaData.videoId}');

        _play.add(value.isPlaying);

        // Check if player is ready and has the correct video ID
        if (value.isReady && value.metaData.videoId.isNotEmpty && !_isReady) {
          _isReady = true;
          _ready.add(true);
          print(
              'YouTubeVideoPlayer: Player is now ready with video ID: ${value.metaData.videoId}');
        }
      });

      // Wait for initial setup
      await Future.delayed(const Duration(seconds: 5));

      // Check if controller has the correct video ID
      if (_ctl!.value.metaData.videoId.isEmpty) {
        print(
            'YouTubeVideoPlayer: Controller video ID is empty, attempting to reload...');
        // Try to reload the video
        _ctl!.load(_videoId!);
        await Future.delayed(const Duration(seconds: 3));
      }

      // Check if already ready
      if (_ctl!.value.isReady && _ctl!.value.metaData.videoId.isNotEmpty) {
        _isReady = true;
        _ready.add(true);
        print(
            'YouTubeVideoPlayer: Controller was already ready with video ID: ${_ctl!.value.metaData.videoId}');
      } else {
        print(
            'YouTubeVideoPlayer: Controller not ready yet, waiting for ready event...');
        // Wait for the ready event with a longer timeout
        try {
          await _ready.stream.firstWhere((ready) => ready).timeout(
            const Duration(seconds: 20),
            onTimeout: () {
              print('YouTubeVideoPlayer: Timeout waiting for ready event');
              return false;
            },
          );
          print('YouTubeVideoPlayer: Ready event received');
        } catch (e) {
          print('YouTubeVideoPlayer: Error waiting for ready event: $e');
        }
      }

      // Final check - if still not ready, mark as failed
      if (!_isReady) {
        print(
            'YouTubeVideoPlayer: Failed to initialize properly after all attempts');
        print(
            'YouTubeVideoPlayer: Final state - isReady: ${_ctl!.value.isReady}, videoId: ${_ctl!.value.metaData.videoId}');
      }

      print('YouTubeVideoPlayer: Initialization completed');
    } catch (e) {
      print('YouTubeVideoPlayer: Error during initialization: $e');
      _isReady = false;
    }
  }

  @override
  Future<void> play() async {
    print(
        'YouTubeVideoPlayer: play() called, controller: $_ctl, isReady: $_isReady');

    if (_ctl == null) {
      print('YouTubeVideoPlayer: Controller not initialized yet');
      return;
    }

    // Check if we have a valid video ID
    if (_ctl!.value.metaData.videoId.isEmpty) {
      print(
          'YouTubeVideoPlayer: Cannot play - video ID is empty. YouTube API may not be working properly.');
      print('YouTubeVideoPlayer: This could be due to:');
      print('YouTubeVideoPlayer: 1. Network connectivity issues');
      print('YouTubeVideoPlayer: 2. YouTube API restrictions');
      print('YouTubeVideoPlayer: 3. Device compatibility issues');
      return;
    }

    // Wait for player to be ready if not already
    if (!await _waitForReady()) {
      print('YouTubeVideoPlayer: Cannot play - player not ready');
      return;
    }

    print('YouTubeVideoPlayer: Player is ready, proceeding with play');

    try {
      print('YouTubeVideoPlayer: Starting playback');
      _ctl!.play();
      _play.add(true);
      print('YouTubeVideoPlayer: Playback started successfully');
    } catch (e) {
      print('YouTubeVideoPlayer: Error starting playback: $e');
    }
  }

  @override
  Future<void> pause() async {
    print(
        'YouTubeVideoPlayer: pause() called, controller: $_ctl, isReady: $_isReady');

    if (_ctl == null) {
      print('YouTubeVideoPlayer: Controller not initialized yet');
      return;
    }

    if (!_isReady) {
      print('YouTubeVideoPlayer: Player not ready, cannot pause');
      return;
    }

    try {
      print('YouTubeVideoPlayer: Pausing playback');
      _ctl!.pause();
      _play.add(false);
      print('YouTubeVideoPlayer: Playback paused successfully');
    } catch (e) {
      print('YouTubeVideoPlayer: Error pausing playback: $e');
    }
  }

  @override
  Future<void> stop() async {
    print('YouTubeVideoPlayer: stop() called');
    try {
      await seekTo(Duration.zero);
      await pause();
      print('YouTubeVideoPlayer: Stop completed');
    } catch (e) {
      print('YouTubeVideoPlayer: Error during stop: $e');
    }
  }

  @override
  Future<void> seekTo(Duration position) async {
    if (_ctl == null || !_isReady) {
      print('YouTubeVideoPlayer: Cannot seek, player not ready');
      return;
    }

    try {
      print('YouTubeVideoPlayer: Seeking to position: $position');
      _ctl!.seekTo(position);
    } catch (e) {
      print('YouTubeVideoPlayer: Error seeking: $e');
    }
  }

  @override
  Future<void> setMuted(bool muted) async {
    if (_ctl == null) {
      print('YouTubeVideoPlayer: Cannot set mute, controller not initialized');
      return;
    }

    // Wait for player to be ready if not already
    if (!await _waitForReady()) {
      print('YouTubeVideoPlayer: Cannot set mute, player not ready');
      return;
    }

    try {
      if (muted) {
        _ctl!.mute();
        print('YouTubeVideoPlayer: Player muted');
      } else {
        _ctl!.unMute();
        print('YouTubeVideoPlayer: Player unmuted');
      }
    } catch (e) {
      print('YouTubeVideoPlayer: Error setting mute: $e');
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    if (_ctl == null) {
      print('YouTubeVideoPlayer: Cannot set speed, controller not initialized');
      return;
    }

    // Wait for player to be ready if not already
    if (!await _waitForReady()) {
      print('YouTubeVideoPlayer: Cannot set speed, player not ready');
      return;
    }

    try {
      print('YouTubeVideoPlayer: Setting playback speed to: $speed');
      _ctl!.setPlaybackRate(speed);
    } catch (e) {
      print('YouTubeVideoPlayer: Error setting playback speed: $e');
    }
  }

  Stream<Duration> get position$ => _pos.stream;

  Stream<Duration?> get duration$ => _dur.stream;

  Stream<bool> get playing$ => _play.stream;

  @override
  bool get isPlaying => _ctl?.value.isPlaying ?? false;

  bool get isInitialized => _ctl != null;

  @override
  bool get isReady => _isReady && _ctl != null && _ctl!.value.isReady;
  bool get hasTimedOut => _hasTimedOut;
  Stream<bool> get ready$ => _ready.stream;

  // Check if the controller is actually ready
  bool get isControllerReady => _ctl?.value.isReady ?? false;

  YoutubePlayerController? get controller => _ctl;

  /// Get detailed player status for debugging
  Map<String, dynamic> get playerStatus {
    if (_ctl == null) return {'error': 'Controller not initialized'};

    final value = _ctl!.value;
    return {
      'isReady': value.isReady,
      'videoId': value.metaData.videoId,
      'title': value.metaData.title,
      'author': value.metaData.author,
      'duration': value.metaData.duration.inSeconds,
      'playerState': value.playerState.toString(),
      'isPlaying': value.isPlaying,
      'position': value.position.inSeconds,
      'buffered': value.buffered,
      'volume': value.volume,
      'errorCode': value.errorCode,
    };
  }

  /// Wait for the player to be ready
  Future<bool> _waitForReady() async {
    if (_ctl == null) return false;

    // If already ready and has video ID, return true
    if (_ctl!.value.isReady && _ctl!.value.metaData.videoId.isNotEmpty) {
      _isReady = true;
      _ready.add(true);
      return true;
    }

    // Wait for ready event with timeout
    try {
      await _ready.stream.firstWhere((ready) => ready).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('YouTubeVideoPlayer: Timeout waiting for ready event');
          _hasTimedOut = true;
          return false;
        },
      );
      return true;
    } catch (e) {
      print('YouTubeVideoPlayer: Error waiting for ready event: $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    print('YouTubeVideoPlayer: Disposing player');
    try {
      _ctl?.dispose();
      await _pos.close();
      await _dur.close();
      await _play.close();
      await _ready.close();
      print('YouTubeVideoPlayer: Disposal completed');
    } catch (e) {
      print('YouTubeVideoPlayer: Error during disposal: $e');
    }
  }

  // Additional methods to match IVideoPlayer interface
  @override
  bool get isMuted => false; // Not directly accessible in this version

  @override
  Duration get position => Duration.zero; // Get from stream

  @override
  Duration get duration => Duration.zero; // Get from stream

  @override
  Stream<bool> get playingStream => playing$;

  @override
  Stream<bool> get readyStream => ready$;

  @override
  Stream<Duration> get positionStream => position$;

  @override
  Stream<Duration> get durationStream =>
      duration$.where((d) => d != null).map((d) => d!);

  @override
  Future<void> enterFullscreen() async {
    // Not implemented in this version
  }

  @override
  Future<void> exitFullscreen() async {
    // Not implemented in this version
  }
}
