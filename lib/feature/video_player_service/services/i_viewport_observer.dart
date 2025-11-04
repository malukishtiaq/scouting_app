import 'package:flutter/foundation.dart';

abstract class IViewportObserver {
  /// Start observing viewport changes for a specific video
  void startObserving(
      String videoId, VoidCallback onVisible, VoidCallback onHidden);

  /// Stop observing viewport changes for a specific video
  void stopObserving(String videoId);

  /// Check if a video is currently visible in viewport
  bool isVisible(String videoId);

  /// Get the visibility fraction (0.0 to 1.0) for a video
  double getVisibilityFraction(String videoId);

  /// Dispose the observer
  void dispose();
}
