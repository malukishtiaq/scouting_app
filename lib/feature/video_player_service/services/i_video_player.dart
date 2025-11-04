// Removed unused imports

abstract class IVideoPlayer {
  /// Initialize the video player
  Future<void> initialize();

  /// Start playing the video
  Future<void> play();

  /// Pause the video
  Future<void> pause();

  /// Stop the video and reset to beginning
  Future<void> stop();

  /// Set the video muted state
  Future<void> setMuted(bool muted);

  /// Get current playing state
  bool get isPlaying;

  /// Get current muted state
  bool get isMuted;

  /// Get current position
  Duration get position;

  /// Get total duration
  Duration get duration;

  /// Check if player is ready
  bool get isReady;

  /// Seek to specific position
  Future<void> seekTo(Duration position);

  /// Enter fullscreen mode
  Future<void> enterFullscreen();

  /// Exit fullscreen mode
  Future<void> exitFullscreen();

  /// Dispose the player
  Future<void> dispose();

  /// Stream for playing state changes
  Stream<bool> get playingStream;

  /// Stream for ready state changes
  Stream<bool> get readyStream;

  /// Stream for position changes
  Stream<Duration> get positionStream;

  /// Stream for duration changes
  Stream<Duration> get durationStream;
}
