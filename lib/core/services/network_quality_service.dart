import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Network quality levels
enum NetworkQuality {
  excellent, // WiFi or 4G/5G
  good, // 3G
  poor, // 2G or slow connection
  offline, // No connection
}

/// Network quality detection and monitoring service
class NetworkQualityService {
  static final NetworkQualityService _instance =
      NetworkQualityService._internal();
  factory NetworkQualityService() => _instance;
  NetworkQualityService._internal();

  final Connectivity _connectivity = Connectivity();
  NetworkQuality _currentQuality = NetworkQuality.excellent;
  final _qualityController = StreamController<NetworkQuality>.broadcast();
  StreamSubscription? _connectivitySubscription;

  // Bandwidth estimation
  DateTime? _lastCheckTime;
  int _bytesTransferred = 0;
  double _estimatedBandwidthMbps = 10.0; // Default assumption

  /// Current network quality
  NetworkQuality get currentQuality => _currentQuality;

  /// Stream of quality changes
  Stream<NetworkQuality> get qualityStream => _qualityController.stream;

  /// Estimated bandwidth in Mbps
  double get estimatedBandwidth => _estimatedBandwidthMbps;

  /// Initialize service and start monitoring
  Future<void> initialize() async {
    await _checkInitialQuality();
    _startMonitoring();
  }

  /// Check initial network quality
  Future<void> _checkInitialQuality() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateQualityFromConnectivity(result);
    } catch (e) {
      debugPrint('⚠️ Error checking connectivity: $e');
      _currentQuality = NetworkQuality.offline;
    }
  }

  /// Start monitoring network changes
  void _startMonitoring() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        _updateQualityFromConnectivity(result);
      },
    );
  }

  /// Update quality based on connectivity result
  void _updateQualityFromConnectivity(ConnectivityResult result) {
    NetworkQuality newQuality;

    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        newQuality = NetworkQuality.excellent;
        _estimatedBandwidthMbps = 50.0; // Assume good WiFi
        break;
      case ConnectivityResult.mobile:
        // Can't determine 2G/3G/4G precisely, assume good
        newQuality = NetworkQuality.good;
        _estimatedBandwidthMbps = 5.0; // Conservative mobile estimate
        break;
      case ConnectivityResult.vpn:
        newQuality = NetworkQuality.good;
        _estimatedBandwidthMbps = 10.0;
        break;
      case ConnectivityResult.none:
        newQuality = NetworkQuality.offline;
        _estimatedBandwidthMbps = 0.0;
        break;
      default:
        newQuality = NetworkQuality.good;
        _estimatedBandwidthMbps = 5.0;
    }

    if (newQuality != _currentQuality) {
      _currentQuality = newQuality;
      _qualityController.add(_currentQuality);
      debugPrint(
          '📶 Network quality changed: ${_currentQuality.name} (~${_estimatedBandwidthMbps}Mbps)');
    }
  }

  /// Record data transfer for bandwidth estimation
  void recordDataTransfer(int bytes) {
    _bytesTransferred += bytes;
    _lastCheckTime ??= DateTime.now();

    // Update bandwidth estimate every 5 seconds
    final elapsed = DateTime.now().difference(_lastCheckTime!);
    if (elapsed.inSeconds >= 5 && _bytesTransferred > 0) {
      final mbps = (_bytesTransferred * 8) / (elapsed.inMicroseconds);
      _estimatedBandwidthMbps = mbps;
      _bytesTransferred = 0;
      _lastCheckTime = DateTime.now();
      debugPrint('📊 Estimated bandwidth: ${mbps.toStringAsFixed(2)} Mbps');
    }
  }

  /// Get recommended image quality based on network
  ImageQuality getRecommendedImageQuality() {
    switch (_currentQuality) {
      case NetworkQuality.excellent:
        return ImageQuality.high;
      case NetworkQuality.good:
        return ImageQuality.medium;
      case NetworkQuality.poor:
        return ImageQuality.low;
      case NetworkQuality.offline:
        return ImageQuality.cacheOnly;
    }
  }

  /// Should preload images based on network quality
  bool shouldPreloadImages() {
    return _currentQuality == NetworkQuality.excellent;
  }

  /// Get max concurrent image loads based on quality
  int getMaxConcurrentLoads() {
    switch (_currentQuality) {
      case NetworkQuality.excellent:
        return 6;
      case NetworkQuality.good:
        return 3;
      case NetworkQuality.poor:
        return 1;
      case NetworkQuality.offline:
        return 0;
    }
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _qualityController.close();
  }
}

/// Recommended image quality levels
enum ImageQuality {
  high,
  medium,
  low,
  cacheOnly,
}
