import '../../domain/entities/user_preferences_entity.dart';
import '../../core/settings_constants.dart';

/// Local data source for settings storage
abstract class SettingsLocalDataSource {
  /// Get cached settings
  Future<UserPreferencesEntity?> getCachedSettings();

  /// Cache settings
  Future<void> cacheSettings(UserPreferencesEntity preferences);

  /// Get stored settings from local storage
  Future<UserPreferencesEntity?> getStoredSettings();

  /// Save settings to local storage
  Future<void> saveSettings(UserPreferencesEntity preferences);

  /// Clear cache
  Future<void> clearCache();
}

/// Implementation of local data source
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Map<String, dynamic> _cache = {};
  final Map<String, dynamic> _storage = {};

  @override
  Future<UserPreferencesEntity?> getCachedSettings() async {
    if (_cache.containsKey(SettingsConstants.settingsCacheKey)) {
      final cached = _cache[SettingsConstants.settingsCacheKey];
      if (cached is UserPreferencesEntity) {
        return cached;
      }
    }
    return null;
  }

  @override
  Future<void> cacheSettings(UserPreferencesEntity preferences) async {
    _cache[SettingsConstants.settingsCacheKey] = preferences;
    _cache[SettingsConstants.preferencesLastSyncKey] = DateTime.now();
  }

  @override
  Future<UserPreferencesEntity?> getStoredSettings() async {
    if (_storage.containsKey(SettingsConstants.userPreferencesKey)) {
      final stored = _storage[SettingsConstants.userPreferencesKey];
      if (stored is UserPreferencesEntity) {
        return stored;
      }
    }
    return null;
  }

  @override
  Future<void> saveSettings(UserPreferencesEntity preferences) async {
    _storage[SettingsConstants.userPreferencesKey] = preferences;
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }
}
