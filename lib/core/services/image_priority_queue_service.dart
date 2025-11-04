import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';

/// Priority levels for image loading
enum ImagePriority {
  critical, // User avatar, visible posts
  high, // Next 2 posts
  medium, // Next 3-5 posts
  low, // Background preloading
}

/// Request in the priority queue
class ImageLoadRequest {
  final String url;
  final ImagePriority priority;
  final DateTime timestamp;
  final Completer<bool> completer;
  final Future<void> Function() loadAction;

  ImageLoadRequest({
    required this.url,
    required this.priority,
    required this.loadAction,
  })  : timestamp = DateTime.now(),
        completer = Completer<bool>();

  int get priorityValue => priority.index;
}

/// Priority queue for image loading
class ImagePriorityQueueService {
  static final ImagePriorityQueueService _instance =
      ImagePriorityQueueService._internal();
  factory ImagePriorityQueueService() => _instance;
  ImagePriorityQueueService._internal() {
    _startProcessing();
  }

  final Queue<ImageLoadRequest> _queue = Queue();
  final Set<String> _processing = {};
  final Set<String> _queued = {};
  int _maxConcurrent = 4;
  bool _isProcessing = false;

  /// Set maximum concurrent loads
  void setMaxConcurrent(int max) {
    _maxConcurrent = max.clamp(1, 10);
    _processQueue();
  }

  /// Add request to queue
  Future<bool> enqueue({
    required String url,
    required ImagePriority priority,
    required Future<void> Function() loadAction,
  }) async {
    // Skip if already processing or queued
    if (_processing.contains(url) || _queued.contains(url)) {
      return Future.value(false);
    }

    final request = ImageLoadRequest(
      url: url,
      priority: priority,
      loadAction: loadAction,
    );

    _queue.add(request);
    _queued.add(url);

    // Sort queue by priority
    _sortQueue();

    // Try to process immediately
    _processQueue();

    return request.completer.future;
  }

  /// Sort queue by priority (critical first)
  void _sortQueue() {
    final list = _queue.toList();
    list.sort((a, b) {
      // Higher priority first (lower index)
      final priorityCompare = a.priorityValue.compareTo(b.priorityValue);
      if (priorityCompare != 0) return priorityCompare;

      // If same priority, older requests first
      return a.timestamp.compareTo(b.timestamp);
    });

    _queue.clear();
    _queue.addAll(list);
  }

  /// Start processing queue
  void _startProcessing() {
    if (_isProcessing) return;
    _isProcessing = true;
    _processQueue();
  }

  /// Process queue
  Future<void> _processQueue() async {
    while (_queue.isNotEmpty && _processing.length < _maxConcurrent) {
      final request = _queue.removeFirst();
      _queued.remove(request.url);
      _processing.add(request.url);

      // Process request asynchronously
      _processRequest(request);
    }
  }

  /// Process individual request
  Future<void> _processRequest(ImageLoadRequest request) async {
    try {
      await request.loadAction();
      request.completer.complete(true);
    } catch (e) {
      debugPrint('❌ Image load failed in queue: ${request.url}');
      request.completer.complete(false);
    } finally {
      _processing.remove(request.url);

      // Process next in queue
      _processQueue();
    }
  }

  /// Cancel request by URL
  void cancel(String url) {
    _queued.remove(url);
    _queue.removeWhere((req) => req.url == url);
  }

  /// Clear all pending requests
  void clearAll() {
    for (var request in _queue) {
      request.completer.complete(false);
    }
    _queue.clear();
    _queued.clear();
    _processing.clear();
  }

  /// Get queue statistics
  Map<String, dynamic> getStats() {
    return {
      'queued': _queue.length,
      'processing': _processing.length,
      'maxConcurrent': _maxConcurrent,
    };
  }
}
