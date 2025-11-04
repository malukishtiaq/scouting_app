import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/video_item.dart';
import '../services/i_video_player_service.dart';
import '../services/i_video_player.dart';
import '../services/i_viewport_observer.dart';
import 'viewport_observer_impl.dart';

class VideoPlayerServiceImpl implements IVideoPlayerService {
  final Map<String, IVideoPlayer> _players = {};
  final Map<String, VideoItem> _videoItems = {};
  final IViewportObserver _viewportObserver = ViewportObserverImpl();

  String? _currentPlayingVideoId;
  final StreamController<String?> _currentPlayingController =
      StreamController<String?>.broadcast();

  @override
  Future<void> registerPlayer(String videoId, VideoItem videoItem) async {
    _videoItems[videoId] = videoItem;

    // Set up viewport observation for auto-pause on scroll
    _viewportObserver.startObserving(
      videoId,
      () => _onVideoVisible(videoId),
      () => _onVideoHidden(videoId),
    );
  }

  /// Register an actual video player instance
  Future<void> registerVideoPlayer(String videoId, IVideoPlayer player) async {
    _players[videoId] = player;
    print('🎬 VideoPlayerService: Registered player for video $videoId');
  }

  @override
  Future<void> unregisterPlayer(String videoId) async {
    _viewportObserver.stopObserving(videoId);
    _videoItems.remove(videoId);

    if (_currentPlayingVideoId == videoId) {
      _currentPlayingVideoId = null;
      _currentPlayingController.add(null);
    }
  }

  @override
  Future<void> requestPlay(String videoId) async {
    if (_currentPlayingVideoId == videoId) return;

    // Pause current video if any
    if (_currentPlayingVideoId != null) {
      await requestPause(_currentPlayingVideoId!);
    }

    final player = _players[videoId];
    if (player != null && player.isReady) {
      await player.play();
      _currentPlayingVideoId = videoId;
      _currentPlayingController.add(videoId);
      print('🎬 VideoPlayerService: Started playing video $videoId');
    }
  }

  @override
  Future<void> requestPause(String videoId) async {
    final player = _players[videoId];
    if (player != null && player.isPlaying) {
      await player.pause();
      print('⏸️ VideoPlayerService: Paused video $videoId');
    }

    if (_currentPlayingVideoId == videoId) {
      _currentPlayingVideoId = null;
      _currentPlayingController.add(null);
    }
  }

  @override
  Future<void> requestStop(String videoId) async {
    final player = _players[videoId];
    if (player != null) {
      await player.stop();
      print('⏹️ VideoPlayerService: Stopped video $videoId');
    }

    if (_currentPlayingVideoId == videoId) {
      _currentPlayingVideoId = null;
      _currentPlayingController.add(null);
    }
  }

  @override
  bool isPlaying(String videoId) {
    return _currentPlayingVideoId == videoId;
  }

  @override
  String? get currentPlayingVideoId => _currentPlayingVideoId;

  @override
  Future<void> pauseAll() async {
    for (final videoId in _players.keys) {
      await requestPause(videoId);
    }
  }

  @override
  Future<void> stopAll() async {
    for (final videoId in _players.keys) {
      await requestStop(videoId);
    }
  }

  void _onVideoVisible(String videoId) {
    // Auto-play when video becomes visible (if it was playing before)
    if (_currentPlayingVideoId == videoId) {
      final player = _players[videoId];
      if (player != null && !player.isPlaying) {
        player.play();
      }
    }
  }

  void _onVideoHidden(String videoId) {
    // Auto-pause when video scrolls out of view
    if (_currentPlayingVideoId == videoId) {
      requestPause(videoId);
    }
  }

  @override
  Future<void> dispose() async {
    await pauseAll();
    _viewportObserver.dispose();
    _currentPlayingController.close();
  }
}
