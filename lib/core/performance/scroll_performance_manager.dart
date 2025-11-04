import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Manages scroll performance by pausing expensive operations during fast scrolls
class ScrollPerformanceManager {
  static final ScrollPerformanceManager _instance =
      ScrollPerformanceManager._internal();
  factory ScrollPerformanceManager() => _instance;
  ScrollPerformanceManager._internal();

  bool _isScrolling = false;
  bool _isFastScrolling = false;
  Timer? _scrollEndTimer;
  DateTime? _lastScrollTime;

  // Callbacks for when scroll state changes
  final _scrollStateController = StreamController<bool>.broadcast();

  /// Stream indicating if currently scrolling
  Stream<bool> get scrollStateStream => _scrollStateController.stream;

  /// Whether currently scrolling
  bool get isScrolling => _isScrolling;

  /// Whether scrolling fast (should pause heavy operations)
  bool get isFastScrolling => _isFastScrolling;

  /// Notify that scrolling started
  void onScrollStart() {
    _scrollEndTimer?.cancel();

    if (!_isScrolling) {
      _isScrolling = true;
      _scrollStateController.add(true);
      debugPrint('📜 Scroll started - pausing heavy operations');
    }

    // Detect fast scrolling
    final now = DateTime.now();
    if (_lastScrollTime != null) {
      final diff = now.difference(_lastScrollTime!).inMilliseconds;
      _isFastScrolling =
          diff < 50; // Less than 50ms between scroll events = fast
    }
    _lastScrollTime = now;
  }

  /// Notify that scrolling updated
  void onScrollUpdate() {
    onScrollStart(); // Keep extending the timer
  }

  /// Notify that scrolling might have ended
  void onScrollEnd() {
    // Wait 200ms before marking scroll as ended
    // (handles momentum scrolling)
    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 200), () {
      _isScrolling = false;
      _isFastScrolling = false;
      _scrollStateController.add(false);
      debugPrint('📜 Scroll ended - resuming operations');
    });
  }

  /// Should pause image loading based on scroll state
  bool shouldPauseImageLoading() {
    return _isFastScrolling;
  }

  /// Should reduce image quality based on scroll state
  bool shouldReduceImageQuality() {
    return _isScrolling;
  }

  /// Get recommended concurrent image loads based on scroll state
  int getRecommendedConcurrentLoads(int baseLimit) {
    if (_isFastScrolling) {
      return 1; // Absolute minimum during fast scroll
    } else if (_isScrolling) {
      return (baseLimit * 0.5).ceil(); // Half during normal scroll
    } else {
      return baseLimit; // Full when not scrolling
    }
  }

  void dispose() {
    _scrollEndTimer?.cancel();
    _scrollStateController.close();
  }
}

/// Scroll notification listener that automatically manages performance
class PerformanceAwareScrollNotification extends StatefulWidget {
  final Widget child;
  final ScrollController? controller;

  const PerformanceAwareScrollNotification({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  State<PerformanceAwareScrollNotification> createState() =>
      _PerformanceAwareScrollNotificationState();
}

class _PerformanceAwareScrollNotificationState
    extends State<PerformanceAwareScrollNotification> {
  final _manager = ScrollPerformanceManager();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    _manager.onScrollUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          _manager.onScrollStart();
        } else if (notification is ScrollUpdateNotification) {
          _manager.onScrollUpdate();
        } else if (notification is ScrollEndNotification) {
          _manager.onScrollEnd();
        }
        return false;
      },
      child: widget.child,
    );
  }
}
