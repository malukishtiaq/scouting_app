import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../services/i_viewport_observer.dart';

class ViewportObserverImpl implements IViewportObserver {
  final Map<String, _VideoObserver> _observers = {};
  final Map<String, double> _visibilityFractions = {};

  @override
  void startObserving(
      String videoId, VoidCallback onVisible, VoidCallback onHidden) {
    if (_observers.containsKey(videoId)) {
      _observers[videoId]!.dispose();
    }

    _observers[videoId] = _VideoObserver(
      onVisible: onVisible,
      onHidden: onHidden,
    );

    _visibilityFractions[videoId] = 0.0;
  }

  @override
  void stopObserving(String videoId) {
    _observers[videoId]?.dispose();
    _observers.remove(videoId);
    _visibilityFractions.remove(videoId);
  }

  @override
  bool isVisible(String videoId) {
    return (_visibilityFractions[videoId] ?? 0.0) > 0.5;
  }

  @override
  double getVisibilityFraction(String videoId) {
    return _visibilityFractions[videoId] ?? 0.0;
  }

  /// Update visibility fraction for a video (called by ScrollController)
  void updateVisibility(String videoId, double fraction) {
    _visibilityFractions[videoId] = fraction;

    final observer = _observers[videoId];
    if (observer != null) {
      if (fraction > 0.5 && !observer.isVisible) {
        observer.isVisible = true;
        observer.onVisible();
      } else if (fraction <= 0.5 && observer.isVisible) {
        observer.isVisible = false;
        observer.onHidden();
      }
    }
  }

  @override
  void dispose() {
    for (final observer in _observers.values) {
      observer.dispose();
    }
    _observers.clear();
    _visibilityFractions.clear();
  }
}

class _VideoObserver {
  final VoidCallback onVisible;
  final VoidCallback onHidden;
  bool isVisible = false;

  _VideoObserver({
    required this.onVisible,
    required this.onHidden,
  });

  void dispose() {
    // Cleanup if needed
  }
}
