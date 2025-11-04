/// Constants for the Settings feature
class SettingsConstants {
  // API endpoints
  static const String baseUrl = 'https://api.wowonder.com';
  static const String settingsEndpoint = '/settings';
  static const String preferencesEndpoint = '/preferences';
  static const String syncEndpoint = '/sync';

  // Cache keys
  static const String userPreferencesKey = 'user_preferences';
  static const String settingsCacheKey = 'settings_cache';
  static const String preferencesLastSyncKey = 'preferences_last_sync';
  static const String searchHistoryKey = 'search_history';

  // Cache durations
  static const Duration settingsCacheDuration = Duration(minutes: 30);
  static const Duration preferencesCacheDuration = Duration(hours: 1);
  static const Duration searchHistoryCacheDuration = Duration(days: 7);

  // Versions
  static const int preferencesVersion = 1;
  static const int settingsVersion = 1;

  // Validation constants
  static const double minFontSize = 10.0;
  static const double maxFontSize = 24.0;
  static const int minSessionTimeout = 5;
  static const int maxSessionTimeout = 1440; // 24 hours

  // Theme constants
  static const List<String> availableThemes = ['light', 'dark', 'system'];
  static const List<String> availableTimeFormats = ['12h', '24h'];
  static const List<String> availableVisibilityOptions = [
    'public',
    'friends',
    'private'
  ];

  // Notification constants
  static const String defaultQuietHoursStart = '22:00';
  static const String defaultQuietHoursEnd = '08:00';

  // Default values
  static const Map<String, dynamic> defaultPreferences = {
    'notifications': {
      'enablePushNotifications': true,
      'enableEmailNotifications': true,
      'enableInAppNotifications': true,
      'notifyOnNewMessages': true,
      'notifyOnFriendRequests': true,
      'notifyOnLikes': true,
      'notifyOnComments': true,
      'notifyOnMentions': true,
      'notifyOnFollows': true,
      'notifyOnGroupPosts': true,
      'notifyOnEvents': true,
      'notifyOnBirthdays': true,
      'quietHoursEnabled': false,
      'quietHoursStart': '22:00',
      'quietHoursEnd': '08:00',
      'mutedKeywords': [],
      'notificationSound': 'default',
      'vibrationEnabled': true,
      'ledColorEnabled': true,
      'customRingtone': 'default',
    },
    'privacy': {
      'profileVisibility': 'friends',
      'showOnlineStatus': true,
      'allowMessagesFromStrangers': false,
      'showBirthday': true,
      'showLocation': false,
      'showEmail': false,
      'showPhoneNumber': false,
      'allowTagging': true,
      'requireApprovalForTags': true,
      'blockedUsers': [],
      'mutedUsers': [],
    },
    'appearance': {
      'theme': 'system',
      'fontSize': 16.0,
      'language': 'en',
      'timeFormat': '12h',
      'dateFormat': 'MM/dd/yyyy',
      'primaryColor': '#2196F3',
      'accentColor': '#FF9800',
      'enableAnimations': true,
      'enableHapticFeedback': true,
      'compactMode': false,
    },
    'security': {
      'twoFactorAuthEnabled': false,
      'requirePasswordForSensitiveActions': true,
      'sessionTimeoutMinutes': 30,
      'logOutOnDeviceChange': false,
      'notifyOnNewDeviceLogin': true,
      'trustedDevices': [],
      'allowRememberDevice': true,
      'backupCodesGenerated': '',
    },
    'social': {
      'showFriendsList': true,
      'showFollowersList': true,
      'autoAcceptFriendRequests': false,
      'defaultPostVisibility': 'friends',
      'allowSharing': true,
      'allowDownloads': true,
      'favoriteTopics': [],
    },
    'advanced': {
      'activeSessionsCount': 1,
      'autoLogoutOnInactivity': false,
      'rememberThisDevice': true,
      'allowAnalytics': true,
      'allowCrashReports': true,
      'allowPerformanceMonitoring': true,
      'allowPersonalizedContent': true,
      'smartNotifications': false,
      'batchNotifications': true,
      'keepNotificationHistory': false,
      'prioritySenders': false,
      'biometricAuth': false,
      'advancedEncryption': false,
      'securityAlerts': true,
      'autoLock': false,
      'backgroundSync': true,
      'autoOptimization': true,
      'autoInviteContacts': false,
      'enableLiveChat': true,
      'autoDataBackup': true,
      'dataSyncEnabled': true,
      'debugMode': false,
    },
  };

  // Error messages
  static const String networkError = 'Network connection error';
  static const String serverError = 'Server error occurred';
  static const String validationError = 'Validation failed';
  static const String unknownError = 'Unknown error occurred';
  static const String permissionError = 'Permission denied';

  // Success messages
  static const String settingsSaved = 'Settings saved successfully';
  static const String preferencesSynced = 'Preferences synced successfully';
  static const String exportSuccessful = 'Settings exported successfully';
  static const String importSuccessful = 'Settings imported successfully';

  // Search constants
  static const int maxSearchResults = 100;
  static const int maxSearchSuggestions = 10;
  static const Duration searchDebounceTime = Duration(milliseconds: 300);

  // Export constants
  static const List<String> supportedExportFormats = ['json', 'csv', 'xml'];
  static const int maxExportFileSize = 10 * 1024 * 1024; // 10MB

  // Analytics constants
  static const int maxAnalyticsDataPoints = 1000;
  static const Duration analyticsRetentionPeriod = Duration(days: 90);
}
