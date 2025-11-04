import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Memory pressure levels
enum MemoryPressure {
  normal, // < 50% used
  moderate, // 50-75% used
  high, // 75-90% used
  critical, // > 90% used
}

/// Memory pressure monitoring service
class MemoryPressureService {
  static final MemoryPressureService _instance =
      MemoryPressureService._internal();
  factory MemoryPressureService() => _instance;
  MemoryPressureService._internal();

  MemoryPressure _currentPressure = MemoryPressure.normal;
  Timer? _monitoringTimer;
  final _pressureController = StreamController<MemoryPressure>.broadcast();

  // Memory thresholds (in MB)
  static const int _moderateThresholdMB = 100;
  static const int _highThresholdMB = 200;
  static const int _criticalThresholdMB = 300;

  /// Current memory pressure
  MemoryPressure get currentPressure => _currentPressure;

  /// Stream of pressure changes
  Stream<MemoryPressure> get pressureStream => _pressureController.stream;

  /// Initialize and start monitoring
  void initialize() {
    _startMonitoring();

    // Listen to system memory warnings
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (message == 'AppLifecycleState.paused' ||
          message == 'AppLifecycleState.inactive') {
        _checkMemoryPressure();
      }
      return null;
    });
  }

  /// Start periodic memory monitoring
  void _startMonitoring() {
    _monitoringTimer?.cancel();
    _monitoringTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _checkMemoryPressure(),
    );
  }

  /// Check current memory pressure
  Future<void> _checkMemoryPressure() async {
    try {
      final info = await _getMemoryInfo();
      if (info == null) return;

      final usedMB = info['usedMB'] as double;
      final totalMB = info['totalMB'] as double;
      final usagePercent = (usedMB / totalMB) * 100;

      MemoryPressure newPressure;
      if (usedMB > _criticalThresholdMB || usagePercent > 90) {
        newPressure = MemoryPressure.critical;
      } else if (usedMB > _highThresholdMB || usagePercent > 75) {
        newPressure = MemoryPressure.high;
      } else if (usedMB > _moderateThresholdMB || usagePercent > 50) {
        newPressure = MemoryPressure.moderate;
      } else {
        newPressure = MemoryPressure.normal;
      }

      if (newPressure != _currentPressure) {
        _currentPressure = newPressure;
        _pressureController.add(_currentPressure);
        debugPrint(
            '💾 Memory pressure: ${_currentPressure.name} (${usedMB.toStringAsFixed(1)}MB / ${usagePercent.toStringAsFixed(1)}%)');
      }
    } catch (e) {
      debugPrint('⚠️ Error checking memory: $e');
    }
  }

  /// Get memory information
  Future<Map<String, double>?> _getMemoryInfo() async {
    try {
      if (Platform.isAndroid) {
        // Android memory info via method channel would go here
        // For now, using ProcessInfo as approximation
        final info = ProcessInfo.currentRss;
        return {
          'usedMB': info / (1024 * 1024),
          'totalMB': 512.0, // Estimate, would need platform channel
        };
      } else if (Platform.isIOS) {
        // iOS memory info via method channel would go here
        final info = ProcessInfo.currentRss;
        return {
          'usedMB': info / (1024 * 1024),
          'totalMB': 1024.0, // Estimate
        };
      }
    } catch (e) {
      debugPrint('Error getting memory info: $e');
    }
    return null;
  }

  /// Should reduce cache based on pressure
  bool shouldReduceCache() {
    return _currentPressure == MemoryPressure.high ||
        _currentPressure == MemoryPressure.critical;
  }

  /// Get recommended cache size multiplier
  double getCacheSizeMultiplier() {
    switch (_currentPressure) {
      case MemoryPressure.normal:
        return 1.0;
      case MemoryPressure.moderate:
        return 0.75;
      case MemoryPressure.high:
        return 0.5;
      case MemoryPressure.critical:
        return 0.25;
    }
  }

  /// Get max concurrent image loads based on memory
  int getMaxConcurrentLoads() {
    switch (_currentPressure) {
      case MemoryPressure.normal:
        return 6;
      case MemoryPressure.moderate:
        return 4;
      case MemoryPressure.high:
        return 2;
      case MemoryPressure.critical:
        return 1;
    }
  }

  /// Dispose resources
  void dispose() {
    _monitoringTimer?.cancel();
    _pressureController.close();
  }
}
