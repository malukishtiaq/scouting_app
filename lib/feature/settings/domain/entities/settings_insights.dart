/// Settings insight
class SettingsInsight {
  final String id;
  final String title;
  final String description;
  final InsightType type;
  final InsightSeverity severity;
  final String? recommendation;
  final DateTime createdAt;
  final bool isRead;

  const SettingsInsight({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.severity,
    this.recommendation,
    required this.createdAt,
    this.isRead = false,
  });
}

/// Insight types
enum InsightType {
  security,
  privacy,
  performance,
  usability,
  accessibility,
  notification,
}

/// Insight severity levels
enum InsightSeverity {
  low,
  medium,
  high,
  critical,
}

/// Settings usage statistics
class SettingsUsageStats {
  final int totalSettings;
  final int changedSettings;
  final int unusedSettings;
  final DateTime lastActivity;
  final Map<String, int> categoryUsage;
  final List<String> mostUsedFeatures;

  const SettingsUsageStats({
    required this.totalSettings,
    required this.changedSettings,
    required this.unusedSettings,
    required this.lastActivity,
    required this.categoryUsage,
    required this.mostUsedFeatures,
  });
}

/// User behavior patterns
class UserBehaviorPatterns {
  final List<String> frequentlyChangedSettings;
  final List<String> rarelyChangedSettings;
  final Map<String, DateTime> lastChangedDates;
  final List<String> preferredCategories;
  final bool prefersDarkMode;
  final bool prefersNotifications;

  const UserBehaviorPatterns({
    required this.frequentlyChangedSettings,
    required this.rarelyChangedSettings,
    required this.lastChangedDates,
    required this.preferredCategories,
    required this.prefersDarkMode,
    required this.prefersNotifications,
  });
}
