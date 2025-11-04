import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Viewport tracking for lazy loading
class ViewportTrackerService {
  static final ViewportTrackerService _instance =
      ViewportTrackerService._internal();
  factory ViewportTrackerService() => _instance;
  ViewportTrackerService._internal();

  // Track visible items
  final Set<String> _visibleItems = {};
  final Map<String, double> _visibilityPercentage = {};
  final _visibilityController = StreamController<Set<String>>.broadcast();

  /// Currently visible items
  Set<String> get visibleItems => Set.from(_visibleItems);

  /// Stream of visibility changes
  Stream<Set<String>> get visibilityStream => _visibilityController.stream;

  /// Register item visibility
  void updateVisibility(String key, double visiblePercentage) {
    _visibilityPercentage[key] = visiblePercentage;

    if (visiblePercentage > 0.1) {
      // Consider visible if > 10% visible
      if (!_visibleItems.contains(key)) {
        _visibleItems.add(key);
        _visibilityController.add(Set.from(_visibleItems));
      }
    } else {
      if (_visibleItems.contains(key)) {
        _visibleItems.remove(key);
        _visibilityController.add(Set.from(_visibleItems));
      }
    }
  }

  /// Remove item from tracking
  void removeItem(String key) {
    _visibleItems.remove(key);
    _visibilityPercentage.remove(key);
  }

  /// Clear all tracked items
  void clear() {
    _visibleItems.clear();
    _visibilityPercentage.clear();
  }

  /// Get visibility percentage for item
  double getVisibilityPercentage(String key) {
    return _visibilityPercentage[key] ?? 0.0;
  }

  /// Check if item is visible
  bool isVisible(String key) {
    return _visibleItems.contains(key);
  }

  /// Dispose resources
  void dispose() {
    _visibilityController.close();
  }
}

/// Widget that tracks its visibility in viewport
class ViewportTracker extends StatefulWidget {
  final String trackingKey;
  final Widget child;
  final void Function(double visiblePercentage)? onVisibilityChanged;

  const ViewportTracker({
    super.key,
    required this.trackingKey,
    required this.child,
    this.onVisibilityChanged,
  });

  @override
  State<ViewportTracker> createState() => _ViewportTrackerState();
}

class _ViewportTrackerState extends State<ViewportTracker> {
  final _service = ViewportTrackerService();

  @override
  void dispose() {
    _service.removeItem(widget.trackingKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.trackingKey),
      onVisibilityChanged: (info) {
        final percentage = info.visibleFraction;
        _service.updateVisibility(widget.trackingKey, percentage);
        widget.onVisibilityChanged?.call(percentage);
      },
      child: widget.child,
    );
  }
}
