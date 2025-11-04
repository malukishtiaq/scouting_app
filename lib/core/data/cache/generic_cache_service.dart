import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import '../db/db_provider.dart';
import '../../../app_settings.dart';

/// Generic cache service that works with any data type
/// Provides automatic caching for API responses based on AppSettings configuration
@singleton
class GenericCacheService {
  final DbProvider _dbProvider;

  // Memory cache for ultra-fast access
  final Map<String, Map<String, dynamic>> _memoryCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};

  GenericCacheService(this._dbProvider);

  /// Get cached single item for a feature
  /// Returns cached data if valid, null otherwise
  Future<T?> get<T>({
    required String feature,
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
    Duration? ttl,
  }) async {
    // Check if caching is enabled for this feature
    if (!AppSettings.isCacheEnabled(feature)) {
      return null;
    }

    try {
      final cacheKey = '${feature}_$key';

      // 1. Check memory cache first (fastest)
      if (_isMemoryCacheValid(cacheKey,
          ttl ?? Duration(minutes: AppSettings.getCacheTTL(feature)))) {
        print('⚡ Memory cache HIT for $cacheKey');
        return fromJson(_memoryCache[cacheKey]!);
      }

      // 2. Check database cache
      final dbData = await _getFromDatabase(feature, key);
      if (dbData != null) {
        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          dbData['cached_at'] as int,
        );

        // Check if cache is still valid
        final cacheTTL =
            ttl ?? Duration(minutes: AppSettings.getCacheTTL(feature));
        if (_isCacheValid(timestamp, cacheTTL)) {
          print('✅ Database cache HIT for $cacheKey');
          final jsonData = jsonDecode(dbData['json'] as String);

          // Update memory cache
          _updateMemoryCache(cacheKey, jsonData);

          return fromJson(jsonData);
        } else {
          print('⏰ Cache STALE for $cacheKey (expired)');
        }
      }

      print('❌ Cache MISS for $cacheKey');
      return null;
    } catch (e) {
      print('❌ Error getting cached data: $e');
      return null;
    }
  }

  /// Get cached list for a feature
  Future<List<T>?> getList<T>({
    required String feature,
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
    int limit = 100,
    Duration? ttl,
  }) async {
    if (!AppSettings.isCacheEnabled(feature)) {
      return null;
    }

    try {
      final cacheKey = '${feature}_$key';

      // Check memory cache
      if (_isMemoryCacheValid(cacheKey,
          ttl ?? Duration(minutes: AppSettings.getCacheTTL(feature)))) {
        final cached = _memoryCache[cacheKey]!['items'] as List?;
        if (cached != null) {
          print(
              '⚡ Memory list cache HIT for $cacheKey (${cached.length} items)');
          return cached
              .map((item) => fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }

      // Check database
      final dbData = await _getListFromDatabase(feature, key, limit);
      if (dbData.isNotEmpty) {
        final firstItem = dbData.first;
        final timestamp = DateTime.fromMillisecondsSinceEpoch(
          firstItem['cached_at'] as int,
        );

        final cacheTTL =
            ttl ?? Duration(minutes: AppSettings.getCacheTTL(feature));
        if (_isCacheValid(timestamp, cacheTTL)) {
          print('✅ List cache HIT for $cacheKey (${dbData.length} items)');

          final items = dbData.map((row) {
            final jsonData = jsonDecode(row['json'] as String);
            return fromJson(jsonData);
          }).toList();

          // Update memory cache with list
          _memoryCache[cacheKey] = {
            'items': items.map((item) {
              // Convert each item to JSON for storage
              if (item is Map<String, dynamic>) {
                return item;
              }
              // If item has toJson method, call it
              try {
                return (item as dynamic).toJson() as Map<String, dynamic>;
              } catch (e) {
                return <String, dynamic>{};
              }
            }).toList()
          };
          _cacheTimestamps[cacheKey] = DateTime.now();

          return items;
        } else {
          print('⏰ List cache STALE for $cacheKey (expired)');
        }
      }

      print('❌ List cache MISS for $cacheKey');
      return null;
    } catch (e) {
      print('❌ Error getting cached list: $e');
      return null;
    }
  }

  /// Save single item to cache
  Future<void> put({
    required String feature,
    required String key,
    required Map<String, dynamic> data,
  }) async {
    if (!AppSettings.isCacheEnabled(feature)) {
      return;
    }

    try {
      final cacheKey = '${feature}_$key';

      // Update memory cache
      _updateMemoryCache(cacheKey, data);

      // Save to database
      await _saveToDatabase(feature, key, data);

      print('💾 Cached: $cacheKey');
    } catch (e) {
      print('❌ Error saving to cache: $e');
    }
  }

  /// Save list to cache
  Future<void> putList({
    required String feature,
    required String key,
    required List<Map<String, dynamic>> items,
  }) async {
    if (!AppSettings.isCacheEnabled(feature)) {
      return;
    }

    try {
      final db = await _dbProvider.database;
      final now = DateTime.now().millisecondsSinceEpoch;

      await db.transaction((txn) async {
        // Delete old entries
        await txn.delete(
          'generic_cache',
          where: 'feature = ? AND cache_key = ?',
          whereArgs: [feature, key],
        );

        // Insert new entries
        final batch = txn.batch();
        for (int i = 0; i < items.length; i++) {
          batch.insert('generic_cache', {
            'feature': feature,
            'cache_key': key,
            'item_id': i.toString(),
            'json': jsonEncode(items[i]),
            'cached_at': now,
          });
        }
        await batch.commit(noResult: true);
      });

      // Update memory cache
      final cacheKey = '${feature}_$key';
      _memoryCache[cacheKey] = {'items': items};
      _cacheTimestamps[cacheKey] = DateTime.now();

      print('💾 Cached list: ${feature}_$key (${items.length} items)');
    } catch (e) {
      print('❌ Error saving list to cache: $e');
    }
  }

  /// Clear cache for a feature
  Future<void> clear(String feature, [String? key]) async {
    try {
      final db = await _dbProvider.database;

      if (key != null) {
        await db.delete(
          'generic_cache',
          where: 'feature = ? AND cache_key = ?',
          whereArgs: [feature, key],
        );
        _memoryCache.remove('${feature}_$key');
        _cacheTimestamps.remove('${feature}_$key');
        print('🗑️ Cleared cache for ${feature}_$key');
      } else {
        await db.delete(
          'generic_cache',
          where: 'feature = ?',
          whereArgs: [feature],
        );
        // Clear memory cache for this feature
        _memoryCache.removeWhere((k, v) => k.startsWith('${feature}_'));
        _cacheTimestamps.removeWhere((k, v) => k.startsWith('${feature}_'));
        print('🗑️ Cleared all cache for feature: $feature (memory + disk)');
      }
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  /// Clear all cache
  Future<void> clearAll() async {
    try {
      final db = await _dbProvider.database;
      await db.delete('generic_cache');
      _memoryCache.clear();
      _cacheTimestamps.clear();
      print('🗑️ Cleared all cache');
    } catch (e) {
      print('❌ Error clearing all cache: $e');
    }
  }

  // ========== PRIVATE HELPER METHODS ==========

  bool _isMemoryCacheValid(String cacheKey, Duration ttl) {
    final timestamp = _cacheTimestamps[cacheKey];
    if (timestamp == null) return false;
    if (_memoryCache[cacheKey] == null) return false;
    return _isCacheValid(timestamp, ttl);
  }

  bool _isCacheValid(DateTime timestamp, Duration ttl) {
    return DateTime.now().difference(timestamp) < ttl;
  }

  void _updateMemoryCache(String cacheKey, Map<String, dynamic> data) {
    _memoryCache[cacheKey] = data;
    _cacheTimestamps[cacheKey] = DateTime.now();
  }

  Future<Map<String, dynamic>?> _getFromDatabase(
    String feature,
    String key,
  ) async {
    try {
      final db = await _dbProvider.database;
      final results = await db.query(
        'generic_cache',
        where: 'feature = ? AND cache_key = ?',
        whereArgs: [feature, key],
        limit: 1,
      );

      return results.isNotEmpty ? results.first : null;
    } catch (e) {
      print('❌ Error getting from database: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> _getListFromDatabase(
    String feature,
    String key,
    int limit,
  ) async {
    try {
      final db = await _dbProvider.database;
      return await db.query(
        'generic_cache',
        where: 'feature = ? AND cache_key = ?',
        whereArgs: [feature, key],
        orderBy: 'cached_at DESC',
        limit: limit,
      );
    } catch (e) {
      print('❌ Error getting list from database: $e');
      return [];
    }
  }

  Future<void> _saveToDatabase(
    String feature,
    String key,
    Map<String, dynamic> data,
  ) async {
    try {
      final db = await _dbProvider.database;
      await db.insert(
        'generic_cache',
        {
          'feature': feature,
          'cache_key': key,
          'item_id': key,
          'json': jsonEncode(data),
          'cached_at': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('❌ Error saving to database: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _memoryCache.clear();
    _cacheTimestamps.clear();
  }
}
