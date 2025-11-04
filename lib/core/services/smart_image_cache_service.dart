import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Context for image loading - determines cache strategy
enum ImageContext {
  feedThumbnail, // Small thumbnails in feed
  feedImage, // Full images in feed
  detailView, // Detail/fullscreen view
  avatar, // User avatars
  story, // Story thumbnails
}

/// Smart image cache with LRU eviction and context-aware sizing
class SmartImageCacheService {
  static final SmartImageCacheService _instance =
      SmartImageCacheService._internal();
  factory SmartImageCacheService() => _instance;
  SmartImageCacheService._internal();

  // LRU cache for tracking access patterns
  final LinkedHashMap<String, DateTime> _accessMap = LinkedHashMap();
  final Set<String> _failedUrls = {};
  final Map<String, int> _failureCount = {};

  // Cache statistics
  int _hits = 0;
  int _misses = 0;

  static const int _maxFailedUrlsCache = 200;
  static const int _maxAccessTracking = 500;
  static const Duration _failedUrlCacheDuration = Duration(minutes: 5);

  /// Get optimal cache dimensions based on context
  CacheDimensions getDimensionsForContext(ImageContext context) {
    switch (context) {
      case ImageContext.feedThumbnail:
        return CacheDimensions(width: 200, height: 150);
      case ImageContext.feedImage:
        return CacheDimensions(width: 600, height: 450);
      case ImageContext.detailView:
        return CacheDimensions(width: 1200, height: 900);
      case ImageContext.avatar:
        return CacheDimensions(width: 100, height: 100);
      case ImageContext.story:
        return CacheDimensions(width: 120, height: 180);
    }
  }

  /// Check if URL has failed recently
  bool hasFailedRecently(String url) {
    return _failedUrls.contains(url);
  }

  /// Get failure count for URL
  int getFailureCount(String url) {
    return _failureCount[url] ?? 0;
  }

  /// Record failed URL
  void recordFailure(String url) {
    _failureCount[url] = (_failureCount[url] ?? 0) + 1;
    _failedUrls.add(url);

    // Clean up old failed URLs
    if (_failedUrls.length > _maxFailedUrlsCache) {
      final toRemove =
          _failedUrls.take(_failedUrls.length - _maxFailedUrlsCache).toList();
      _failedUrls.removeAll(toRemove);
      for (var url in toRemove) {
        _failureCount.remove(url);
      }
    }

    // Auto-clear failed URL after duration
    Future.delayed(_failedUrlCacheDuration, () {
      _failedUrls.remove(url);
      _failureCount.remove(url);
    });
  }

  /// Record successful load
  void recordSuccess(String url) {
    _failureCount.remove(url);
    _failedUrls.remove(url);
    _recordAccess(url);
    _hits++;
  }

  /// Record cache miss
  void recordMiss(String url) {
    _misses++;
  }

  /// Track image access for LRU
  void _recordAccess(String url) {
    _accessMap.remove(url);
    _accessMap[url] = DateTime.now();

    // Maintain size limit
    if (_accessMap.length > _maxAccessTracking) {
      final oldestKey = _accessMap.keys.first;
      _accessMap.remove(oldestKey);
    }
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    final total = _hits + _misses;
    return {
      'hits': _hits,
      'misses': _misses,
      'hitRate': total > 0 ? (_hits / total * 100).toStringAsFixed(1) : '0.0',
      'failedUrls': _failedUrls.length,
      'trackedUrls': _accessMap.length,
    };
  }

  /// Clear all cache data
  Future<void> clearAll() async {
    _accessMap.clear();
    _failedUrls.clear();
    _failureCount.clear();
    _hits = 0;
    _misses = 0;
    await DefaultCacheManager().emptyCache();
  }

  /// Clear old cache entries (memory pressure response)
  void clearOldEntries({int keepCount = 100}) {
    if (_accessMap.length <= keepCount) return;

    final toRemove = _accessMap.length - keepCount;
    final keysToRemove = _accessMap.keys.take(toRemove).toList();

    for (var key in keysToRemove) {
      _accessMap.remove(key);
    }

    debugPrint('🧹 Cleared $toRemove old cache entries');
  }
}

/// Cache dimensions for context-aware sizing
class CacheDimensions {
  final int width;
  final int height;

  CacheDimensions({required this.width, required this.height});
}
