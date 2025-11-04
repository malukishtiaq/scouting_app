import 'dart:convert';

/// User preferences model for settings
class UserPreferencesModel {
  final String userId;
  final Map<String, dynamic> notifications;
  final Map<String, dynamic> privacy;
  final Map<String, dynamic> appearance;
  final Map<String, dynamic> security;
  final Map<String, dynamic> social;
  final DateTime lastUpdated;
  final int version;

  const UserPreferencesModel({
    required this.userId,
    required this.notifications,
    required this.privacy,
    required this.appearance,
    required this.security,
    required this.social,
    required this.lastUpdated,
    required this.version,
  });

  /// Create default preferences for a user
  factory UserPreferencesModel.defaultPreferences(String userId) {
    return UserPreferencesModel(
      userId: userId,
      notifications: {
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
      privacy: {
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
      appearance: {
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
      security: {
        'twoFactorAuthEnabled': false,
        'requirePasswordForSensitiveActions': true,
        'sessionTimeoutMinutes': 30,
        'logOutOnDeviceChange': false,
        'notifyOnNewDeviceLogin': true,
        'trustedDevices': [],
        'allowRememberDevice': true,
        'backupCodesGenerated': '',
      },
      social: {
        'showFriendsList': true,
        'showFollowersList': true,
        'autoAcceptFriendRequests': false,
        'defaultPostVisibility': 'friends',
        'allowSharing': true,
        'allowDownloads': true,
        'favoriteTopics': [],
      },
      lastUpdated: DateTime.now(),
      version: 1,
    );
  }

  /// Create from JSON
  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      userId: json['userId'] ?? '',
      notifications: Map<String, dynamic>.from(json['notifications'] ?? {}),
      privacy: Map<String, dynamic>.from(json['privacy'] ?? {}),
      appearance: Map<String, dynamic>.from(json['appearance'] ?? {}),
      security: Map<String, dynamic>.from(json['security'] ?? {}),
      social: Map<String, dynamic>.from(json['social'] ?? {}),
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
      version: json['version'] ?? 1,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'notifications': notifications,
      'privacy': privacy,
      'appearance': appearance,
      'security': security,
      'social': social,
      'lastUpdated': lastUpdated.toIso8601String(),
      'version': version,
    };
  }

  /// Create a copy with updated values
  UserPreferencesModel copyWith({
    String? userId,
    Map<String, dynamic>? notifications,
    Map<String, dynamic>? privacy,
    Map<String, dynamic>? appearance,
    Map<String, dynamic>? security,
    Map<String, dynamic>? social,
    DateTime? lastUpdated,
    int? version,
  }) {
    return UserPreferencesModel(
      userId: userId ?? this.userId,
      notifications: notifications ?? this.notifications,
      privacy: privacy ?? this.privacy,
      appearance: appearance ?? this.appearance,
      security: security ?? this.security,
      social: social ?? this.social,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      version: version ?? this.version,
    );
  }

  /// Update a specific preference category
  UserPreferencesModel updateCategory(String category, Map<String, dynamic> newValues) {
    switch (category.toLowerCase()) {
      case 'notifications':
        return copyWith(
          notifications: {...notifications, ...newValues},
          lastUpdated: DateTime.now(),
        );
      case 'privacy':
        return copyWith(
          privacy: {...privacy, ...newValues},
          lastUpdated: DateTime.now(),
        );
      case 'appearance':
        return copyWith(
          appearance: {...appearance, ...newValues},
          lastUpdated: DateTime.now(),
        );
      case 'security':
        return copyWith(
          security: {...security, ...newValues},
          lastUpdated: DateTime.now(),
        );
      case 'social':
        return copyWith(
          social: {...social, ...newValues},
          lastUpdated: DateTime.now(),
        );
      default:
        return this;
    }
  }

  /// Get a specific preference value
  dynamic getPreference(String category, String key) {
    switch (category.toLowerCase()) {
      case 'notifications':
        return notifications[key];
      case 'privacy':
        return privacy[key];
      case 'appearance':
        return appearance[key];
      case 'security':
        return security[key];
      case 'social':
        return social[key];
      default:
        return null;
    }
  }

  /// Set a specific preference value
  UserPreferencesModel setPreference(String category, String key, dynamic value) {
    final newValues = {key: value};
    return updateCategory(category, newValues);
  }

  @override
  String toString() {
    return 'UserPreferencesModel(userId: $userId, version: $version, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserPreferencesModel &&
        other.userId == userId &&
        other.version == version &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ version.hashCode ^ lastUpdated.hashCode;
  }
}
