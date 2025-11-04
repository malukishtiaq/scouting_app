import '../../data/models/user_preferences_model.dart';
import '../../data/services/settings_export_service.dart';
import '../../core/search/settings_search_service.dart';
import '../../core/validation/settings_validator.dart';
import '../../domain/entities/settings_insights.dart';

/// Base settings state
abstract class SettingsState {
  const SettingsState();
}

/// Initial state
class SettingsInitial extends SettingsState {}

/// Loading settings
class SettingsLoading extends SettingsState {}

/// Settings loaded successfully
class SettingsLoaded extends SettingsState {
  final UserPreferencesModel preferences;
  final ValidationResult validationResult;
  final DateTime lastSyncTime;

  const SettingsLoaded({
    required this.preferences,
    required this.validationResult,
    required this.lastSyncTime,
  });
}

/// Settings being updated
class SettingsUpdating extends SettingsState {}

/// Settings updated successfully
class SettingsUpdated extends SettingsState {
  final UserPreferencesModel preferences;
  final ValidationResult validationResult;
  final DateTime lastSyncTime;

  const SettingsUpdated({
    required this.preferences,
    required this.validationResult,
    required this.lastSyncTime,
  });
}

/// Settings being synced
class SettingsSyncing extends SettingsState {
  final UserPreferencesModel preferences;
  final ValidationResult validationResult;
  final DateTime lastSyncTime;

  const SettingsSyncing({
    required this.preferences,
    required this.validationResult,
    required this.lastSyncTime,
  });
}

/// Settings search in progress
class SettingsSearching extends SettingsState {}

/// Settings search results
class SettingsSearchResults extends SettingsState {
  final String query;
  final List<SearchResultItem> results;
  final int totalResults;
  final SearchFilters filters;
  final SearchSortOption sortBy;

  const SettingsSearchResults({
    required this.query,
    required this.results,
    required this.totalResults,
    required this.filters,
    required this.sortBy,
  });
}

/// Settings being exported
class SettingsExporting extends SettingsState {}

/// Settings exported successfully
class SettingsExported extends SettingsState {
  final UserPreferencesModel preferences;
  final ValidationResult validationResult;
  final DateTime lastSyncTime;
  final ExportResult exportResult;

  const SettingsExported({
    required this.preferences,
    required this.validationResult,
    required this.lastSyncTime,
    required this.exportResult,
  });
}

/// Settings being imported
class SettingsImporting extends SettingsState {}

/// Generating insights
class SettingsGeneratingInsights extends SettingsState {}

/// Insights generated
class SettingsInsightsGenerated extends SettingsState {
  final List<SettingsInsight> insights;
  final SettingsUsageStats usageStats;
  final UserBehaviorPatterns behaviorPatterns;

  const SettingsInsightsGenerated({
    required this.insights,
    required this.usageStats,
    required this.behaviorPatterns,
  });
}

/// Export files loaded
class SettingsExportFilesLoaded extends SettingsState {
  final UserPreferencesModel preferences;
  final ValidationResult validationResult;
  final DateTime lastSyncTime;
  final List<ExportFileInfo> exportFiles;

  const SettingsExportFilesLoaded({
    required this.preferences,
    required this.validationResult,
    required this.lastSyncTime,
    required this.exportFiles,
  });
}

/// Settings error state
class SettingsError extends SettingsState {
  final String message;
  final String errorCode;
  final List<String>? validationErrors;

  const SettingsError({
    required this.message,
    required this.errorCode,
    this.validationErrors,
  });
}
