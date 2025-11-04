import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoCacheManager {
  static final VideoCacheManager _instance = VideoCacheManager._internal();
  factory VideoCacheManager() => _instance;
  VideoCacheManager._internal() {
    _startPeriodicCleanup();
  }

  static const Duration _cacheValidDuration = Duration(days: 7);
  static const int _maxCacheObjects =
      3; // Current + 2 ahead for smooth forward swipes (increased for better preloading)

  final Map<String, VideoPlayerController> _controllerCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};

  // Periodic cleanup
  Timer? _cleanupTimer;
  DateTime _lastFullCleanup = DateTime.now();

  /// Get cached video controller or create new one
  Future<VideoPlayerController?> getCachedController(String videoUrl) async {
    // Check if controller is already cached and still valid
    if (_controllerCache.containsKey(videoUrl)) {
      final controller = _controllerCache[videoUrl];
      final timestamp = _cacheTimestamps[videoUrl];

      final isTimestampValid = timestamp != null &&
          DateTime.now().difference(timestamp) < _cacheValidDuration;

      if (controller != null && isTimestampValid) {
        // Guard against storing a controller that isn't initialized (or was disposed elsewhere)
        if (controller.value.isInitialized) {
          return controller;
        } else {
          // Invalidate bad cache entry
          try {
            controller.dispose();
          } catch (_) {}
          _controllerCache.remove(videoUrl);
          _cacheTimestamps.remove(videoUrl);
        }
      } else {
        // Remove expired controller
        try {
          controller?.dispose();
        } catch (_) {}
        _controllerCache.remove(videoUrl);
        _cacheTimestamps.remove(videoUrl);
      }
    }

    // Clean up old cache if needed
    _cleanupCache();

    return null;
  }

  /// Cache video controller
  void cacheController(String videoUrl, VideoPlayerController controller) {
    _controllerCache[videoUrl] = controller;
    _cacheTimestamps[videoUrl] = DateTime.now();

    // Aggressively cleanup if we exceed limit
    _cleanupCache();
  }

  /// Preload video for better performance
  Future<void> preloadVideo(String videoUrl) async {
    try {
      // Check if already cached
      if (_controllerCache.containsKey(videoUrl)) return;

      // Create and cache controller
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      await controller.initialize();
      cacheController(videoUrl, controller);
    } catch (e) {
      // Silently fail preloading
      if (kDebugMode) {
        print('Video preload failed for $videoUrl: $e');
      }
    }
  }

  /// Preload multiple videos for reels
  Future<void> preloadReelsVideos(List<String> videoUrls) async {
    // Removed verbose preload logs - only log errors
    final futures = videoUrls.map((url) => preloadVideo(url));
    await Future.wait(futures);
  }

  /// Intelligent preloading based on current position and scroll direction
  Future<void> preloadUpcomingVideos({
    required List<String> allVideoUrls,
    required int currentIndex,
    required int preloadCount,
  }) async {
    // ✅ FIX: Validate inputs to prevent RangeError
    if (allVideoUrls.isEmpty ||
        currentIndex < 0 ||
        currentIndex >= allVideoUrls.length) {
      return;
    }

    // Calculate which videos to preload
    final List<String> urlsToPreload = [];

    // Preload next videos (forward direction) - higher priority
    for (int i = 1; i <= preloadCount; i++) {
      final nextIndex = currentIndex + i;
      if (nextIndex < allVideoUrls.length) {
        urlsToPreload.add(allVideoUrls[nextIndex]);
      }
    }

    // Preload previous videos (backward direction) - lower priority
    for (int i = 1; i <= (preloadCount ~/ 2); i++) {
      final prevIndex = currentIndex - i;
      if (prevIndex >= 0 && prevIndex < allVideoUrls.length) {
        urlsToPreload.add(allVideoUrls[prevIndex]);
      }
    }

    if (urlsToPreload.isNotEmpty) {
      // Removed verbose preload log
      _preloadVideosInBackground(urlsToPreload);
    }
  }

  /// Preload videos in background with priority
  void _preloadVideosInBackground(List<String> videoUrls) {
    // Use Future.microtask to run in background
    Future.microtask(() async {
      try {
        // Preload high priority videos first (next 2 videos)
        final highPriorityUrls = videoUrls.take(2).toList();
        final lowPriorityUrls = videoUrls.skip(2).toList();

        // Preload high priority videos immediately
        if (highPriorityUrls.isNotEmpty) {
          await Future.wait(highPriorityUrls.map((url) => preloadVideo(url)));
        }

        // Preload low priority videos with delay to not overwhelm the system
        if (lowPriorityUrls.isNotEmpty) {
          await Future.delayed(const Duration(milliseconds: 500));
          await Future.wait(lowPriorityUrls.map((url) => preloadVideo(url)));
        }

        // Removed verbose completion log
      } catch (e) {
        // Only log actual errors
        print('❌ PRELOAD ERROR: Failed to preload videos | Error: $e');
      }
    });
  }

  /// Check if video is already preloaded and ready
  bool isVideoPreloaded(String videoUrl) {
    return _controllerCache.containsKey(videoUrl) &&
        _controllerCache[videoUrl]?.value.isInitialized == true;
  }

  /// Get preload status for multiple videos
  Map<String, bool> getPreloadStatus(List<String> videoUrls) {
    final Map<String, bool> status = {};
    for (final url in videoUrls) {
      status[url] = isVideoPreloaded(url);
    }
    return status;
  }

  /// Prepare a small window of controllers around current index (current ± windowRadius)
  /// Ensures those controllers are initialized and disposes others to avoid black frames and memory pressure
  Future<void> prepareControllersWindow({
    required List<String> allVideoUrls,
    required int currentIndex,
    int windowRadius = 1,
  }) async {
    if (allVideoUrls.isEmpty ||
        currentIndex < 0 ||
        currentIndex >= allVideoUrls.length) return;

    // Compute target window
    final Set<String> target = {};
    final start =
        (currentIndex - windowRadius).clamp(0, allVideoUrls.length - 1);
    final end = (currentIndex + windowRadius).clamp(0, allVideoUrls.length - 1);
    for (int i = start; i <= end; i++) {
      target.add(allVideoUrls[i]);
    }

    // Initialize or re-initialize controllers for target window
    final List<Future<void>> prepareFutures = [];
    for (final url in target) {
      // If not preloaded, preload now
      if (!isVideoPreloaded(url)) {
        prepareFutures.add(preloadVideo(url));
      }
    }
    await Future.wait(prepareFutures);

    // Dispose controllers that are far outside the window to keep only a few active
    final List<String> toDispose = [];
    for (final cachedUrl in _controllerCache.keys) {
      if (!target.contains(cachedUrl)) {
        toDispose.add(cachedUrl);
      }
    }
    for (final url in toDispose) {
      disposeController(url);
    }
  }

  /// Clean up old cache entries - AGGRESSIVE for memory
  void _cleanupCache() {
    // Always cleanup if we exceed max (now 5)
    if (_controllerCache.length <= _maxCacheObjects) return;

    // Sort by timestamp and remove ALL excess entries
    final sortedEntries = _cacheTimestamps.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Remove enough to get back to max limit
    final removeCount = _controllerCache.length - _maxCacheObjects;
    final entriesToRemove = sortedEntries.take(removeCount);

    print(
        '🧹 MEMORY CLEANUP: Disposing $removeCount video controllers (${_controllerCache.length} -> $_maxCacheObjects)');

    for (final entry in entriesToRemove) {
      try {
        _controllerCache[entry.key]?.dispose();
      } catch (e) {
        // Ignore disposal errors
      }
      _controllerCache.remove(entry.key);
      _cacheTimestamps.remove(entry.key);
    }
  }

  /// Clear all cached controllers
  void clearCache() {
    print(
        '🧹 FULL CACHE CLEAR: Disposing ALL ${_controllerCache.length} video controllers');

    for (final controller in _controllerCache.values) {
      try {
        controller.dispose();
      } catch (e) {
        // Ignore disposal errors
      }
    }
    _controllerCache.clear();
    _cacheTimestamps.clear();
    _lastFullCleanup = DateTime.now();
  }

  /// Dispose specific controller
  void disposeController(String videoUrl) {
    try {
      _controllerCache[videoUrl]?.dispose();
    } catch (e) {
      // Ignore disposal errors
    }
    _controllerCache.remove(videoUrl);
    _cacheTimestamps.remove(videoUrl);
  }

  /// Check if controller is cached
  bool isControllerCached(String videoUrl) {
    return _controllerCache.containsKey(videoUrl);
  }

  /// Start periodic cleanup timer (every 30 minutes)
  void _startPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      _performPeriodicCleanup();
    });
  }

  /// Perform periodic cleanup
  void _performPeriodicCleanup() {
    // Clear ALL cache every 5 hours
    final timeSinceLastCleanup = DateTime.now().difference(_lastFullCleanup);
    if (timeSinceLastCleanup.inHours >= 5) {
      print('⏰ 5-HOUR CLEANUP: Clearing all video cache to free memory');
      clearCache();
      return;
    }

    // Regular cleanup: remove old entries
    final now = DateTime.now();
    final keysToRemove = <String>[];

    _cacheTimestamps.forEach((key, timestamp) {
      if (now.difference(timestamp) > _cacheValidDuration) {
        keysToRemove.add(key);
      }
    });

    if (keysToRemove.isNotEmpty) {
      print(
          '🧹 PERIODIC CLEANUP: Removing ${keysToRemove.length} expired entries');
      for (final key in keysToRemove) {
        disposeController(key);
      }
    }
  }

  /// Force cleanup (call from app lifecycle)
  void forceCleanup({bool clearAll = false}) {
    if (clearAll) {
      clearCache();
    } else {
      // Just cleanup old entries
      _performPeriodicCleanup();
    }
  }

  /// Dispose cleanup timer
  void dispose() {
    _cleanupTimer?.cancel();
    clearCache();
  }
}
