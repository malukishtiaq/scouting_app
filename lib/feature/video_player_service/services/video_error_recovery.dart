import 'dart:async';
import 'dart:math';
import '../models/video_item.dart';
import '../services/i_video_player.dart';

class VideoErrorRecovery {
  static const int maxRetryAttempts = 3;
  static const Duration baseRetryDelay = Duration(seconds: 2);
  static const Duration maxRetryDelay = Duration(seconds: 30);

  static final Map<String, int> _retryCounts = {};
  static final Map<String, Timer> _retryTimers = {};

  /// Attempt to recover from a video error
  static Future<bool> attemptRecovery(
    String videoId,
    VideoItem videoItem,
    IVideoPlayer player,
    Function() onRecoverySuccess,
  ) async {
    print('🔄 VideoErrorRecovery: Attempting recovery for video $videoId');

    final retryCount = _retryCounts[videoId] ?? 0;
    print(
        '🔄 VideoErrorRecovery: Retry attempt $retryCount of $maxRetryAttempts');

    if (retryCount >= maxRetryAttempts) {
      print(
          '❌ VideoErrorRecovery: Max retry attempts reached for video $videoId');
      return false;
    }

    try {
      // Cancel any existing retry timer
      _retryTimers[videoId]?.cancel();

      // Calculate exponential backoff delay
      final delay = _calculateRetryDelay(retryCount);
      print(
          '⏰ VideoErrorRecovery: Waiting ${delay.inSeconds}s before retry...');

      // Wait before retry
      await Future.delayed(delay);

      // Attempt to reinitialize the player
      print('🔄 VideoErrorRecovery: Reinitializing player...');
      await player.initialize();

      // Check if player is ready
      if (player.isReady) {
        print('✅ VideoErrorRecovery: Player recovered successfully');
        _retryCounts.remove(videoId);
        _retryTimers.remove(videoId);
        onRecoverySuccess();
        return true;
      } else {
        print('⚠️ VideoErrorRecovery: Player not ready after reinitialization');
        return await _scheduleNextRetry(
            videoId, videoItem, player, onRecoverySuccess);
      }
    } catch (e, stackTrace) {
      print('❌ VideoErrorRecovery: Recovery attempt failed: $e');
      print('❌ VideoErrorRecovery: Stack trace: $stackTrace');
      return await _scheduleNextRetry(
          videoId, videoItem, player, onRecoverySuccess);
    }
  }

  /// Schedule the next retry attempt
  static Future<bool> _scheduleNextRetry(
    String videoId,
    VideoItem videoItem,
    IVideoPlayer player,
    Function() onRecoverySuccess,
  ) async {
    _retryCounts[videoId] = (_retryCounts[videoId] ?? 0) + 1;

    if (_retryCounts[videoId]! >= maxRetryAttempts) {
      print('❌ VideoErrorRecovery: Max retry attempts reached, giving up');
      _retryCounts.remove(videoId);
      return false;
    }

    // Schedule next retry
    final delay = _calculateRetryDelay(_retryCounts[videoId]!);
    print('⏰ VideoErrorRecovery: Scheduling next retry in ${delay.inSeconds}s');

    _retryTimers[videoId] = Timer(delay, () async {
      await attemptRecovery(videoId, videoItem, player, onRecoverySuccess);
    });

    return false;
  }

  /// Calculate retry delay with exponential backoff and jitter
  static Duration _calculateRetryDelay(int retryCount) {
    final exponentialDelay = baseRetryDelay * pow(2, retryCount);
    final jitter = Duration(milliseconds: Random().nextInt(1000));
    final totalDelay = exponentialDelay + jitter;

    // Cap at max delay
    return totalDelay > maxRetryDelay ? maxRetryDelay : totalDelay;
  }

  /// Reset retry count for a video
  static void resetRetryCount(String videoId) {
    print('🔄 VideoErrorRecovery: Resetting retry count for video $videoId');
    _retryCounts.remove(videoId);
    _retryTimers[videoId]?.cancel();
    _retryTimers.remove(videoId);
  }

  /// Clear all retry data
  static void clearAllRetries() {
    print('🔄 VideoErrorRecovery: Clearing all retry data');
    _retryCounts.clear();
    for (final timer in _retryTimers.values) {
      timer.cancel();
    }
    _retryTimers.clear();
  }

  /// Get retry count for a video
  static int getRetryCount(String videoId) {
    return _retryCounts[videoId] ?? 0;
  }

  /// Check if video is currently being retried
  static bool isRetrying(String videoId) {
    return _retryTimers.containsKey(videoId);
  }
}

/// Video error types for better error handling
enum VideoErrorType {
  networkError,
  initializationError,
  playbackError,
  userGestureRequired,
  unsupportedFormat,
  unknownError,
}

/// Video error information
class VideoErrorInfo {
  final VideoErrorType type;
  final String message;
  final String? details;
  final DateTime timestamp;

  VideoErrorInfo({
    required this.type,
    required this.message,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return 'VideoErrorInfo(type: $type, message: $message, details: $details, timestamp: $timestamp)';
  }
}

/// Video error analyzer
class VideoErrorAnalyzer {
  /// Analyze an error and determine its type
  static VideoErrorInfo analyzeError(dynamic error, String videoUrl) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') || errorString.contains('connection')) {
      return VideoErrorInfo(
        type: VideoErrorType.networkError,
        message: 'Network connection error',
        details: error.toString(),
      );
    } else if (errorString.contains('initialization') ||
        errorString.contains('init')) {
      return VideoErrorInfo(
        type: VideoErrorType.initializationError,
        message: 'Video player initialization failed',
        details: error.toString(),
      );
    } else if (errorString.contains('user gesture') ||
        errorString.contains('interaction')) {
      return VideoErrorInfo(
        type: VideoErrorType.userGestureRequired,
        message: 'User interaction required to play video',
        details: error.toString(),
      );
    } else if (errorString.contains('format') ||
        errorString.contains('codec')) {
      return VideoErrorInfo(
        type: VideoErrorType.unsupportedFormat,
        message: 'Unsupported video format',
        details: error.toString(),
      );
    } else if (errorString.contains('playback') ||
        errorString.contains('play')) {
      return VideoErrorInfo(
        type: VideoErrorType.playbackError,
        message: 'Video playback error',
        details: error.toString(),
      );
    } else {
      return VideoErrorInfo(
        type: VideoErrorType.unknownError,
        message: 'Unknown video error',
        details: error.toString(),
      );
    }
  }

  /// Get user-friendly error message
  static String getUserFriendlyMessage(VideoErrorInfo errorInfo) {
    switch (errorInfo.type) {
      case VideoErrorType.networkError:
        return 'Please check your internet connection and try again.';
      case VideoErrorType.initializationError:
        return 'Failed to load video. Please try again.';
      case VideoErrorType.userGestureRequired:
        return 'Tap the video to start playback.';
      case VideoErrorType.unsupportedFormat:
        return 'This video format is not supported.';
      case VideoErrorType.playbackError:
        return 'Video playback failed. Please try again.';
      case VideoErrorType.unknownError:
        return 'An error occurred while loading the video.';
    }
  }

  /// Check if error is recoverable
  static bool isRecoverable(VideoErrorInfo errorInfo) {
    switch (errorInfo.type) {
      case VideoErrorType.networkError:
      case VideoErrorType.initializationError:
      case VideoErrorType.playbackError:
        return true;
      case VideoErrorType.userGestureRequired:
      case VideoErrorType.unsupportedFormat:
      case VideoErrorType.unknownError:
        return false;
    }
  }
}
