import '../models/video_item.dart';
import '../services/i_video_player.dart';

abstract class IVideoPlayerService {
  /// Register a video player for a specific video item
  Future<void> registerPlayer(String videoId, VideoItem videoItem);

  /// Register an actual video player instance
  Future<void> registerVideoPlayer(String videoId, IVideoPlayer player);

  /// Unregister a video player
  Future<void> unregisterPlayer(String videoId);

  /// Request to play a specific video
  Future<void> requestPlay(String videoId);

  /// Request to pause a specific video
  Future<void> requestPause(String videoId);

  /// Request to stop a specific video
  Future<void> requestStop(String videoId);

  /// Check if a video is currently playing
  bool isPlaying(String videoId);

  /// Get current playing video ID
  String? get currentPlayingVideoId;

  /// Pause all videos
  Future<void> pauseAll();

  /// Stop all videos
  Future<void> stopAll();

  /// Dispose the service
  Future<void> dispose();
}
