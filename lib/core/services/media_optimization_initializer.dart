import 'dart:async';
import 'network_quality_service.dart';
import 'memory_pressure_service.dart';
import 'smart_image_cache_service.dart';
import 'image_priority_queue_service.dart';
import '../performance/scroll_performance_manager.dart';

/// Initialize all media optimization services
class MediaOptimizationInitializer {
  static bool _initialized = false;
  static StreamSubscription? _networkSubscription;
  static StreamSubscription? _memorySubscription;
  static StreamSubscription? _scrollSubscription;

  /// Initialize all services
  static Future<void> initialize() async {
    if (_initialized) return;

    final networkService = NetworkQualityService();
    final memoryService = MemoryPressureService();
    final scrollManager = ScrollPerformanceManager();

    // Initialize network quality service
    await networkService.initialize();

    // Initialize memory pressure monitoring
    memoryService.initialize();

    // Services are singletons, just access them to ensure initialization
    SmartImageCacheService();
    ImagePriorityQueueService();

    // ✅ CRITICAL: Listen to network changes and adapt
    _networkSubscription = networkService.qualityStream.listen((quality) {
      print('📶 Network changed to ${quality.name} - adapting...');
      updateConcurrentLoads();
    });

    // ✅ CRITICAL: Listen to memory pressure and adapt
    _memorySubscription = memoryService.pressureStream.listen((pressure) {
      print('💾 Memory pressure ${pressure.name} - adapting...');
      updateConcurrentLoads();
      if (pressure == MemoryPressure.high ||
          pressure == MemoryPressure.critical) {
        handleMemoryPressure();
      }
    });

    // ✅ CRITICAL: Listen to scroll state and adapt
    _scrollSubscription = scrollManager.scrollStateStream.listen((isScrolling) {
      if (isScrolling) {
        print('📜 Scrolling detected - reducing concurrent loads');
      }
      updateConcurrentLoads();
    });

    // Set initial limits
    updateConcurrentLoads();

    _initialized = true;
    print('✅ Media optimization services initialized with reactive adaptation');
  }

  /// Update max concurrent loads based on conditions
  static void updateConcurrentLoads() {
    final networkService = NetworkQualityService();
    final memoryService = MemoryPressureService();
    final scrollManager = ScrollPerformanceManager();
    final queueService = ImagePriorityQueueService();

    // Get limits from all services and use the most restrictive one
    final networkLimit = networkService.getMaxConcurrentLoads();
    final memoryLimit = memoryService.getMaxConcurrentLoads();
    var finalLimit = networkLimit < memoryLimit ? networkLimit : memoryLimit;

    // ✅ CRITICAL: Reduce during scroll to prevent UI freezing
    finalLimit = scrollManager.getRecommendedConcurrentLoads(finalLimit);

    queueService.setMaxConcurrent(finalLimit);
  }

  /// Cleanup when memory pressure is high
  static Future<void> handleMemoryPressure() async {
    final memoryService = MemoryPressureService();
    final cacheService = SmartImageCacheService();

    if (memoryService.shouldReduceCache()) {
      // Clear old cache entries
      cacheService.clearOldEntries(keepCount: 50);
      print('🧹 Cleared cache due to memory pressure');
    }
  }

  /// Get cache statistics
  static Map<String, dynamic> getStats() {
    return {
      'imageCache': SmartImageCacheService().getStats(),
      'queueStats': ImagePriorityQueueService().getStats(),
      'network': NetworkQualityService().currentQuality.name,
      'memory': MemoryPressureService().currentPressure.name,
    };
  }

  /// Dispose all services
  static void dispose() {
    _networkSubscription?.cancel();
    _memorySubscription?.cancel();
    _scrollSubscription?.cancel();
    NetworkQualityService().dispose();
    MemoryPressureService().dispose();
    ScrollPerformanceManager().dispose();
    _initialized = false;
  }
}
