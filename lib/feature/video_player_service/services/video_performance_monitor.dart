import 'dart:async';
import 'dart:developer' as developer;
// Removed unused import

class VideoPerformanceMonitor {
  static final Map<String, VideoPerformanceData> _performanceData = {};
  static final Map<String, Timer> _performanceTimers = {};

  /// Start monitoring a video's performance
  static void startMonitoring(String videoId, String videoUrl, String source) {
    print('📊 VideoPerformanceMonitor: Starting monitoring for video $videoId');

    _performanceData[videoId] = VideoPerformanceData(
      videoId: videoId,
      videoUrl: videoUrl,
      source: source,
      startTime: DateTime.now(),
    );

    // Monitor every 5 seconds
    _performanceTimers[videoId] = Timer.periodic(
      const Duration(seconds: 5),
      (timer) => _updatePerformanceMetrics(videoId),
    );
  }

  /// Stop monitoring a video's performance
  static void stopMonitoring(String videoId) {
    print('📊 VideoPerformanceMonitor: Stopping monitoring for video $videoId');

    _performanceTimers[videoId]?.cancel();
    _performanceTimers.remove(videoId);

    final data = _performanceData[videoId];
    if (data != null) {
      data.endTime = DateTime.now();
      _logPerformanceSummary(data);
      _performanceData.remove(videoId);
    }
  }

  /// Record a performance event
  static void recordEvent(String videoId, VideoEvent event, {String? details}) {
    final data = _performanceData[videoId];
    if (data != null) {
      data.events.add(VideoEventData(
        event: event,
        timestamp: DateTime.now(),
        details: details,
      ));

      print('📊 VideoPerformanceMonitor: Event recorded for $videoId: $event');
    }
  }

  /// Update performance metrics
  static void _updatePerformanceMetrics(String videoId) {
    final data = _performanceData[videoId];
    if (data != null) {
      data.updateCount++;
      data.lastUpdateTime = DateTime.now();

      // Log performance metrics every 30 seconds
      if (data.updateCount % 6 == 0) {
        _logPerformanceMetrics(data);
      }
    }
  }

  /// Log performance metrics
  static void _logPerformanceMetrics(VideoPerformanceData data) {
    print(
        '📊 VideoPerformanceMonitor: Performance metrics for ${data.videoId}');
    print('   - Source: ${data.source}');
    print('   - Duration: ${data.duration.inSeconds}s');
    print('   - Events: ${data.events.length}');
    print('   - Updates: ${data.updateCount}');
    print('   - Last update: ${data.lastUpdateTime}');
  }

  /// Log performance summary
  static void _logPerformanceSummary(VideoPerformanceData data) {
    print(
        '📊 VideoPerformanceMonitor: Performance summary for ${data.videoId}');
    print('   - Total duration: ${data.totalDuration.inSeconds}s');
    print('   - Total events: ${data.events.length}');
    print('   - Total updates: ${data.updateCount}');
    print('   - Events breakdown:');

    final eventCounts = <VideoEvent, int>{};
    for (final eventData in data.events) {
      eventCounts[eventData.event] = (eventCounts[eventData.event] ?? 0) + 1;
    }

    for (final entry in eventCounts.entries) {
      print('     - ${entry.key}: ${entry.value}');
    }

    // Log to developer console for debugging
    developer.log(
      'Video Performance Summary',
      name: 'VideoPerformance',
      error: {
        'videoId': data.videoId,
        'source': data.source,
        'duration': data.totalDuration.inSeconds,
        'events': data.events.length,
        'updates': data.updateCount,
      },
    );
  }

  /// Get performance data for a video
  static VideoPerformanceData? getPerformanceData(String videoId) {
    return _performanceData[videoId];
  }

  /// Get all performance data
  static Map<String, VideoPerformanceData> getAllPerformanceData() {
    return Map.unmodifiable(_performanceData);
  }

  /// Clear all performance data
  static void clearAllData() {
    print('📊 VideoPerformanceMonitor: Clearing all performance data');
    for (final timer in _performanceTimers.values) {
      timer.cancel();
    }
    _performanceTimers.clear();
    _performanceData.clear();
  }

  /// Check for performance issues
  static List<String> checkPerformanceIssues() {
    final issues = <String>[];

    for (final data in _performanceData.values) {
      // Check for long initialization times
      final initEvent = data.events.firstWhere(
        (e) => e.event == VideoEvent.initializationStarted,
        orElse: () => VideoEventData(
          event: VideoEvent.initializationStarted,
          timestamp: data.startTime,
        ),
      );

      final initDuration = data.startTime.difference(initEvent.timestamp);
      if (initDuration.inSeconds > 10) {
        issues.add(
            'Video ${data.videoId} took ${initDuration.inSeconds}s to initialize');
      }

      // Check for too many errors
      final errorCount =
          data.events.where((e) => e.event == VideoEvent.error).length;
      if (errorCount > 3) {
        issues.add('Video ${data.videoId} has $errorCount errors');
      }

      // Check for long playback delays
      final playEvents = data.events
          .where((e) => e.event == VideoEvent.playRequested)
          .toList();
      if (playEvents.length > 1) {
        for (int i = 1; i < playEvents.length; i++) {
          final delay =
              playEvents[i].timestamp.difference(playEvents[i - 1].timestamp);
          if (delay.inSeconds > 5) {
            issues.add(
                'Video ${data.videoId} has ${delay.inSeconds}s delay between play requests');
          }
        }
      }
    }

    return issues;
  }
}

/// Video performance data
class VideoPerformanceData {
  final String videoId;
  final String videoUrl;
  final String source;
  final DateTime startTime;
  DateTime? endTime;
  DateTime lastUpdateTime;
  int updateCount = 0;
  final List<VideoEventData> events = [];

  VideoPerformanceData({
    required this.videoId,
    required this.videoUrl,
    required this.source,
    required this.startTime,
  }) : lastUpdateTime = startTime;

  Duration get duration => (endTime ?? DateTime.now()).difference(startTime);
  Duration get totalDuration => duration;
}

/// Video event data
class VideoEventData {
  final VideoEvent event;
  final DateTime timestamp;
  final String? details;

  VideoEventData({
    required this.event,
    required this.timestamp,
    this.details,
  });
}

/// Video events
enum VideoEvent {
  initializationStarted,
  initializationCompleted,
  initializationFailed,
  playRequested,
  playStarted,
  playPaused,
  playStopped,
  playCompleted,
  error,
  userGestureReceived,
  visibilityChanged,
  muteToggled,
  fullscreenEntered,
  fullscreenExited,
  seekPerformed,
  volumeChanged,
  qualityChanged,
  bufferingStarted,
  bufferingCompleted,
  networkError,
  formatError,
  permissionError,
}

/// Video performance analyzer
class VideoPerformanceAnalyzer {
  /// Analyze performance data and return insights
  static VideoPerformanceInsights analyze(VideoPerformanceData data) {
    final insights = VideoPerformanceInsights();

    // Calculate initialization time
    final initStart = data.events.firstWhere(
      (e) => e.event == VideoEvent.initializationStarted,
      orElse: () => VideoEventData(
        event: VideoEvent.initializationStarted,
        timestamp: data.startTime,
      ),
    );

    final initEnd = data.events.firstWhere(
      (e) => e.event == VideoEvent.initializationCompleted,
      orElse: () => VideoEventData(
        event: VideoEvent.initializationCompleted,
        timestamp: data.startTime,
      ),
    );

    insights.initializationTime =
        initEnd.timestamp.difference(initStart.timestamp);

    // Count events
    insights.totalEvents = data.events.length;
    insights.errorCount =
        data.events.where((e) => e.event == VideoEvent.error).length;
    insights.playCount =
        data.events.where((e) => e.event == VideoEvent.playRequested).length;
    insights.pauseCount =
        data.events.where((e) => e.event == VideoEvent.playPaused).length;

    // Calculate success rate
    if (insights.totalEvents > 0) {
      insights.successRate =
          (insights.totalEvents - insights.errorCount) / insights.totalEvents;
    }

    // Check for performance issues
    insights.hasLongInitialization = insights.initializationTime.inSeconds > 10;
    insights.hasManyErrors = insights.errorCount > 3;
    insights.hasLowSuccessRate = insights.successRate < 0.8;

    return insights;
  }
}

/// Video performance insights
class VideoPerformanceInsights {
  Duration initializationTime = Duration.zero;
  int totalEvents = 0;
  int errorCount = 0;
  int playCount = 0;
  int pauseCount = 0;
  double successRate = 0.0;
  bool hasLongInitialization = false;
  bool hasManyErrors = false;
  bool hasLowSuccessRate = false;

  @override
  String toString() {
    return 'VideoPerformanceInsights('
        'initTime: ${initializationTime.inSeconds}s, '
        'events: $totalEvents, '
        'errors: $errorCount, '
        'successRate: ${(successRate * 100).toStringAsFixed(1)}%, '
        'issues: ${_getIssues().join(", ")})';
  }

  List<String> _getIssues() {
    final issues = <String>[];
    if (hasLongInitialization) issues.add('Long initialization');
    if (hasManyErrors) issues.add('Many errors');
    if (hasLowSuccessRate) issues.add('Low success rate');
    return issues;
  }
}
