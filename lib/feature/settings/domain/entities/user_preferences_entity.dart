/// User preferences entity for the domain layer
class UserPreferencesEntity {
  final bool enablePushNotifications;
  final bool enableEmailNotifications;
  final bool enableInAppNotifications;
  final bool notifyOnNewMessages;
  final bool notifyOnFriendRequests;
  final bool notifyOnLikes;
  final bool notifyOnComments;
  final bool notifyOnMentions;
  final bool notifyOnFollows;
  final bool notifyOnGroupPosts;
  final bool notifyOnEvents;
  final bool notifyOnBirthdays;
  final bool quietHoursEnabled;
  final String quietHoursStart;
  final String quietHoursEnd;
  final List<String> mutedKeywords;
  final String notificationSound;
  final bool vibrationEnabled;
  final bool ledColorEnabled;
  final String customRingtone;
  final String profileVisibility;
  final bool showOnlineStatus;
  final bool allowMessagesFromStrangers;
  final bool showBirthday;
  final bool showLocation;
  final bool showEmail;
  final bool showPhoneNumber;
  final bool allowTagging;
  final bool requireApprovalForTags;
  final List<String> blockedUsers;
  final List<String> mutedUsers;
  final String theme;
  final double fontSize;
  final String language;
  final String timeFormat;
  final String dateFormat;
  final String primaryColor;
  final String accentColor;
  final bool enableAnimations;
  final bool enableHapticFeedback;
  final bool compactMode;
  final bool twoFactorAuthEnabled;
  final bool requirePasswordForSensitiveActions;
  final int sessionTimeoutMinutes;
  final bool logOutOnDeviceChange;
  final bool notifyOnNewDeviceLogin;
  final List<String> trustedDevices;
  final bool allowRememberDevice;
  final String backupCodesGenerated;
  final bool showFriendsList;
  final bool showFollowersList;
  final bool autoAcceptFriendRequests;
  final String defaultPostVisibility;
  final bool allowSharing;
  final bool allowDownloads;
  final List<String> favoriteTopics;
  // Advanced Features
  final int activeSessionsCount;
  final bool autoLogoutOnInactivity;
  final bool rememberThisDevice;
  final bool allowAnalytics;
  final bool allowCrashReports;
  final bool allowPerformanceMonitoring;
  final bool allowPersonalizedContent;
  final bool smartNotifications;
  final bool batchNotifications;
  final bool keepNotificationHistory;
  final bool prioritySenders;
  final bool biometricAuth;
  final bool advancedEncryption;
  final bool securityAlerts;
  final bool autoLock;
  final bool backgroundSync;
  final bool autoOptimization;
  final bool autoInviteContacts;
  final bool enableLiveChat;
  final bool autoDataBackup;
  final bool dataSyncEnabled;
  final bool debugMode;
  // Media Auto Download Settings
  final bool mediaAutoDownloadMobile;
  final bool mediaAutoDownloadWiFi;
  // Privacy Settings
  final String whoCanFollowMe;
  final String whoCanMessageMe;
  final String whoCanSeeMyFriends;
  final String whoCanPostOnMyTimeline;
  final String whoCanSeeMyBirthday;
  final bool confirmFollowRequests;
  final bool showMyActivities;
  final bool shareMyLocation;
  // Notification Settings
  final bool playSound;
  final bool chatHeads;
  final bool detailedNotifications;

  const UserPreferencesEntity({
    required this.enablePushNotifications,
    required this.enableEmailNotifications,
    required this.enableInAppNotifications,
    required this.notifyOnNewMessages,
    required this.notifyOnFriendRequests,
    required this.notifyOnLikes,
    required this.notifyOnComments,
    required this.notifyOnMentions,
    required this.notifyOnFollows,
    required this.notifyOnGroupPosts,
    required this.notifyOnEvents,
    required this.notifyOnBirthdays,
    required this.quietHoursEnabled,
    required this.quietHoursStart,
    required this.quietHoursEnd,
    required this.mutedKeywords,
    required this.notificationSound,
    required this.vibrationEnabled,
    required this.ledColorEnabled,
    required this.customRingtone,
    required this.profileVisibility,
    required this.showOnlineStatus,
    required this.allowMessagesFromStrangers,
    required this.showBirthday,
    required this.showLocation,
    required this.showEmail,
    required this.showPhoneNumber,
    required this.allowTagging,
    required this.requireApprovalForTags,
    required this.blockedUsers,
    required this.mutedUsers,
    required this.theme,
    required this.fontSize,
    required this.language,
    required this.timeFormat,
    required this.dateFormat,
    required this.primaryColor,
    required this.accentColor,
    required this.enableAnimations,
    required this.enableHapticFeedback,
    required this.compactMode,
    required this.twoFactorAuthEnabled,
    required this.requirePasswordForSensitiveActions,
    required this.sessionTimeoutMinutes,
    required this.logOutOnDeviceChange,
    required this.notifyOnNewDeviceLogin,
    required this.trustedDevices,
    required this.allowRememberDevice,
    required this.backupCodesGenerated,
    required this.showFriendsList,
    required this.showFollowersList,
    required this.autoAcceptFriendRequests,
    required this.defaultPostVisibility,
    required this.allowSharing,
    required this.allowDownloads,
    required this.favoriteTopics,
    // Advanced Features
    required this.activeSessionsCount,
    required this.autoLogoutOnInactivity,
    required this.rememberThisDevice,
    required this.allowAnalytics,
    required this.allowCrashReports,
    required this.allowPerformanceMonitoring,
    required this.allowPersonalizedContent,
    required this.smartNotifications,
    required this.batchNotifications,
    required this.keepNotificationHistory,
    required this.prioritySenders,
    required this.biometricAuth,
    required this.advancedEncryption,
    required this.securityAlerts,
    required this.autoLock,
    required this.backgroundSync,
    required this.autoOptimization,
    required this.autoInviteContacts,
    required this.enableLiveChat,
    required this.autoDataBackup,
    required this.dataSyncEnabled,
    required this.debugMode,
    // Media Auto Download Settings
    required this.mediaAutoDownloadMobile,
    required this.mediaAutoDownloadWiFi,
    // Privacy Settings
    required this.whoCanFollowMe,
    required this.whoCanMessageMe,
    required this.whoCanSeeMyFriends,
    required this.whoCanPostOnMyTimeline,
    required this.whoCanSeeMyBirthday,
    required this.confirmFollowRequests,
    required this.showMyActivities,
    required this.shareMyLocation,
    // Notification Settings
    required this.playSound,
    required this.chatHeads,
    required this.detailedNotifications,
  });

  UserPreferencesEntity copyWith({
    bool? enablePushNotifications,
    bool? enableEmailNotifications,
    bool? enableInAppNotifications,
    bool? notifyOnNewMessages,
    bool? notifyOnFriendRequests,
    bool? notifyOnLikes,
    bool? notifyOnComments,
    bool? notifyOnMentions,
    bool? notifyOnFollows,
    bool? notifyOnGroupPosts,
    bool? notifyOnEvents,
    bool? notifyOnBirthdays,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
    List<String>? mutedKeywords,
    String? notificationSound,
    bool? vibrationEnabled,
    bool? ledColorEnabled,
    String? customRingtone,
    String? profileVisibility,
    bool? showOnlineStatus,
    bool? allowMessagesFromStrangers,
    bool? showBirthday,
    bool? showLocation,
    bool? showEmail,
    bool? showPhoneNumber,
    bool? allowTagging,
    bool? requireApprovalForTags,
    List<String>? blockedUsers,
    List<String>? mutedUsers,
    String? theme,
    double? fontSize,
    String? language,
    String? timeFormat,
    String? dateFormat,
    String? primaryColor,
    String? accentColor,
    bool? enableAnimations,
    bool? enableHapticFeedback,
    bool? compactMode,
    bool? twoFactorAuthEnabled,
    bool? requirePasswordForSensitiveActions,
    int? sessionTimeoutMinutes,
    bool? logOutOnDeviceChange,
    bool? notifyOnNewDeviceLogin,
    List<String>? trustedDevices,
    bool? allowRememberDevice,
    String? backupCodesGenerated,
    bool? showFriendsList,
    bool? showFollowersList,
    bool? autoAcceptFriendRequests,
    String? defaultPostVisibility,
    bool? allowSharing,
    bool? allowDownloads,
    List<String>? favoriteTopics,
    // Advanced Features
    int? activeSessionsCount,
    bool? autoLogoutOnInactivity,
    bool? rememberThisDevice,
    bool? allowAnalytics,
    bool? allowCrashReports,
    bool? allowPerformanceMonitoring,
    bool? allowPersonalizedContent,
    bool? smartNotifications,
    bool? batchNotifications,
    bool? keepNotificationHistory,
    bool? prioritySenders,
    bool? biometricAuth,
    bool? advancedEncryption,
    bool? securityAlerts,
    bool? autoLock,
    bool? backgroundSync,
    bool? autoOptimization,
    bool? autoInviteContacts,
    bool? enableLiveChat,
    bool? autoDataBackup,
    bool? dataSyncEnabled,
    bool? debugMode,
    // Media Auto Download Settings
    bool? mediaAutoDownloadMobile,
    bool? mediaAutoDownloadWiFi,
    // Privacy Settings
    String? whoCanFollowMe,
    String? whoCanMessageMe,
    String? whoCanSeeMyFriends,
    String? whoCanPostOnMyTimeline,
    String? whoCanSeeMyBirthday,
    bool? confirmFollowRequests,
    bool? showMyActivities,
    bool? shareMyLocation,
    // Notification Settings
    bool? playSound,
    bool? chatHeads,
    bool? detailedNotifications,
  }) {
    return UserPreferencesEntity(
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableEmailNotifications:
          enableEmailNotifications ?? this.enableEmailNotifications,
      enableInAppNotifications:
          enableInAppNotifications ?? this.enableInAppNotifications,
      notifyOnNewMessages: notifyOnNewMessages ?? this.notifyOnNewMessages,
      notifyOnFriendRequests:
          notifyOnFriendRequests ?? this.notifyOnFriendRequests,
      notifyOnLikes: notifyOnLikes ?? this.notifyOnLikes,
      notifyOnComments: notifyOnComments ?? this.notifyOnComments,
      notifyOnMentions: notifyOnMentions ?? this.notifyOnMentions,
      notifyOnFollows: notifyOnFollows ?? this.notifyOnFollows,
      notifyOnGroupPosts: notifyOnGroupPosts ?? this.notifyOnGroupPosts,
      notifyOnEvents: notifyOnEvents ?? this.notifyOnEvents,
      notifyOnBirthdays: notifyOnBirthdays ?? this.notifyOnBirthdays,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      mutedKeywords: mutedKeywords ?? this.mutedKeywords,
      notificationSound: notificationSound ?? this.notificationSound,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      ledColorEnabled: ledColorEnabled ?? this.ledColorEnabled,
      customRingtone: customRingtone ?? this.customRingtone,
      profileVisibility: profileVisibility ?? this.profileVisibility,
      showOnlineStatus: showOnlineStatus ?? this.showOnlineStatus,
      allowMessagesFromStrangers:
          allowMessagesFromStrangers ?? this.allowMessagesFromStrangers,
      showBirthday: showBirthday ?? this.showBirthday,
      showLocation: showLocation ?? this.showLocation,
      showEmail: showEmail ?? this.showEmail,
      showPhoneNumber: showPhoneNumber ?? this.showPhoneNumber,
      allowTagging: allowTagging ?? this.allowTagging,
      requireApprovalForTags:
          requireApprovalForTags ?? this.requireApprovalForTags,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      mutedUsers: mutedUsers ?? this.mutedUsers,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
      timeFormat: timeFormat ?? this.timeFormat,
      dateFormat: dateFormat ?? this.dateFormat,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      compactMode: compactMode ?? this.compactMode,
      twoFactorAuthEnabled: twoFactorAuthEnabled ?? this.twoFactorAuthEnabled,
      requirePasswordForSensitiveActions: requirePasswordForSensitiveActions ??
          this.requirePasswordForSensitiveActions,
      sessionTimeoutMinutes:
          sessionTimeoutMinutes ?? this.sessionTimeoutMinutes,
      logOutOnDeviceChange: logOutOnDeviceChange ?? this.logOutOnDeviceChange,
      notifyOnNewDeviceLogin:
          notifyOnNewDeviceLogin ?? this.notifyOnNewDeviceLogin,
      trustedDevices: trustedDevices ?? this.trustedDevices,
      allowRememberDevice: allowRememberDevice ?? this.allowRememberDevice,
      backupCodesGenerated: backupCodesGenerated ?? this.backupCodesGenerated,
      showFriendsList: showFriendsList ?? this.showFriendsList,
      showFollowersList: showFollowersList ?? this.showFollowersList,
      autoAcceptFriendRequests:
          autoAcceptFriendRequests ?? this.autoAcceptFriendRequests,
      defaultPostVisibility:
          defaultPostVisibility ?? this.defaultPostVisibility,
      allowSharing: allowSharing ?? this.allowSharing,
      allowDownloads: allowDownloads ?? this.allowDownloads,
      favoriteTopics: favoriteTopics ?? this.favoriteTopics,
      // Advanced Features
      activeSessionsCount: activeSessionsCount ?? this.activeSessionsCount,
      autoLogoutOnInactivity:
          autoLogoutOnInactivity ?? this.autoLogoutOnInactivity,
      rememberThisDevice: rememberThisDevice ?? this.rememberThisDevice,
      allowAnalytics: allowAnalytics ?? this.allowAnalytics,
      allowCrashReports: allowCrashReports ?? this.allowCrashReports,
      allowPerformanceMonitoring:
          allowPerformanceMonitoring ?? this.allowPerformanceMonitoring,
      allowPersonalizedContent:
          allowPersonalizedContent ?? this.allowPersonalizedContent,
      smartNotifications: smartNotifications ?? this.smartNotifications,
      batchNotifications: batchNotifications ?? this.batchNotifications,
      keepNotificationHistory:
          keepNotificationHistory ?? this.keepNotificationHistory,
      prioritySenders: prioritySenders ?? this.prioritySenders,
      biometricAuth: biometricAuth ?? this.biometricAuth,
      advancedEncryption: advancedEncryption ?? this.advancedEncryption,
      securityAlerts: securityAlerts ?? this.securityAlerts,
      autoLock: autoLock ?? this.autoLock,
      backgroundSync: backgroundSync ?? this.backgroundSync,
      autoOptimization: autoOptimization ?? this.autoOptimization,
      autoInviteContacts: autoInviteContacts ?? this.autoInviteContacts,
      enableLiveChat: enableLiveChat ?? this.enableLiveChat,
      autoDataBackup: autoDataBackup ?? this.autoDataBackup,
      dataSyncEnabled: dataSyncEnabled ?? this.dataSyncEnabled,
      debugMode: debugMode ?? this.debugMode,
      // Media Auto Download Settings
      mediaAutoDownloadMobile:
          mediaAutoDownloadMobile ?? this.mediaAutoDownloadMobile,
      mediaAutoDownloadWiFi:
          mediaAutoDownloadWiFi ?? this.mediaAutoDownloadWiFi,
      // Privacy Settings
      whoCanFollowMe: whoCanFollowMe ?? this.whoCanFollowMe,
      whoCanMessageMe: whoCanMessageMe ?? this.whoCanMessageMe,
      whoCanSeeMyFriends: whoCanSeeMyFriends ?? this.whoCanSeeMyFriends,
      whoCanPostOnMyTimeline:
          whoCanPostOnMyTimeline ?? this.whoCanPostOnMyTimeline,
      whoCanSeeMyBirthday: whoCanSeeMyBirthday ?? this.whoCanSeeMyBirthday,
      confirmFollowRequests:
          confirmFollowRequests ?? this.confirmFollowRequests,
      showMyActivities: showMyActivities ?? this.showMyActivities,
      shareMyLocation: shareMyLocation ?? this.shareMyLocation,
      // Notification Settings
      playSound: playSound ?? this.playSound,
      chatHeads: chatHeads ?? this.chatHeads,
      detailedNotifications:
          detailedNotifications ?? this.detailedNotifications,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesEntity &&
          runtimeType == other.runtimeType &&
          enablePushNotifications == other.enablePushNotifications &&
          enableEmailNotifications == other.enableEmailNotifications &&
          enableInAppNotifications == other.enableInAppNotifications &&
          notifyOnNewMessages == other.notifyOnNewMessages &&
          notifyOnFriendRequests == other.notifyOnFriendRequests &&
          notifyOnLikes == other.notifyOnLikes &&
          notifyOnComments == other.notifyOnComments &&
          notifyOnMentions == other.notifyOnMentions &&
          notifyOnFollows == other.notifyOnFollows &&
          notifyOnGroupPosts == other.notifyOnGroupPosts &&
          notifyOnEvents == other.notifyOnEvents &&
          notifyOnBirthdays == other.notifyOnBirthdays &&
          quietHoursEnabled == other.quietHoursEnabled &&
          quietHoursStart == other.quietHoursStart &&
          quietHoursEnd == other.quietHoursEnd &&
          mutedKeywords == other.mutedKeywords &&
          notificationSound == other.notificationSound &&
          vibrationEnabled == other.vibrationEnabled &&
          ledColorEnabled == other.ledColorEnabled &&
          customRingtone == other.customRingtone &&
          profileVisibility == other.profileVisibility &&
          showOnlineStatus == other.showOnlineStatus &&
          allowMessagesFromStrangers == other.allowMessagesFromStrangers &&
          showBirthday == other.showBirthday &&
          showLocation == other.showLocation &&
          showEmail == other.showEmail &&
          showPhoneNumber == other.showPhoneNumber &&
          allowTagging == other.allowTagging &&
          requireApprovalForTags == other.requireApprovalForTags &&
          blockedUsers == other.blockedUsers &&
          mutedUsers == other.mutedUsers &&
          theme == other.theme &&
          fontSize == other.fontSize &&
          language == other.language &&
          timeFormat == other.timeFormat &&
          dateFormat == other.dateFormat &&
          primaryColor == other.primaryColor &&
          accentColor == other.accentColor &&
          enableAnimations == other.enableAnimations &&
          enableHapticFeedback == other.enableHapticFeedback &&
          compactMode == other.compactMode &&
          twoFactorAuthEnabled == other.twoFactorAuthEnabled &&
          requirePasswordForSensitiveActions ==
              other.requirePasswordForSensitiveActions &&
          sessionTimeoutMinutes == other.sessionTimeoutMinutes &&
          logOutOnDeviceChange == other.logOutOnDeviceChange &&
          notifyOnNewDeviceLogin == other.notifyOnNewDeviceLogin &&
          trustedDevices == other.trustedDevices &&
          allowRememberDevice == other.allowRememberDevice &&
          backupCodesGenerated == other.backupCodesGenerated &&
          showFriendsList == other.showFriendsList &&
          showFollowersList == other.showFollowersList &&
          autoAcceptFriendRequests == other.autoAcceptFriendRequests &&
          defaultPostVisibility == other.defaultPostVisibility &&
          allowSharing == other.allowSharing &&
          allowDownloads == other.allowDownloads &&
          favoriteTopics == other.favoriteTopics &&
          // Media Auto Download Settings
          mediaAutoDownloadMobile == other.mediaAutoDownloadMobile &&
          mediaAutoDownloadWiFi == other.mediaAutoDownloadWiFi &&
          // Privacy Settings
          whoCanFollowMe == other.whoCanFollowMe &&
          whoCanMessageMe == other.whoCanMessageMe &&
          whoCanSeeMyFriends == other.whoCanSeeMyFriends &&
          whoCanPostOnMyTimeline == other.whoCanPostOnMyTimeline &&
          whoCanSeeMyBirthday == other.whoCanSeeMyBirthday &&
          confirmFollowRequests == other.confirmFollowRequests &&
          showMyActivities == other.showMyActivities &&
          shareMyLocation == other.shareMyLocation &&
          // Notification Settings
          playSound == other.playSound &&
          chatHeads == other.chatHeads &&
          detailedNotifications == other.detailedNotifications;

  @override
  int get hashCode =>
      enablePushNotifications.hashCode ^
      enableEmailNotifications.hashCode ^
      enableInAppNotifications.hashCode ^
      notifyOnNewMessages.hashCode ^
      notifyOnFriendRequests.hashCode ^
      notifyOnLikes.hashCode ^
      notifyOnComments.hashCode ^
      notifyOnMentions.hashCode ^
      notifyOnFollows.hashCode ^
      notifyOnGroupPosts.hashCode ^
      notifyOnEvents.hashCode ^
      notifyOnBirthdays.hashCode ^
      quietHoursEnabled.hashCode ^
      quietHoursStart.hashCode ^
      quietHoursEnd.hashCode ^
      mutedKeywords.hashCode ^
      notificationSound.hashCode ^
      vibrationEnabled.hashCode ^
      ledColorEnabled.hashCode ^
      customRingtone.hashCode ^
      profileVisibility.hashCode ^
      showOnlineStatus.hashCode ^
      allowMessagesFromStrangers.hashCode ^
      showBirthday.hashCode ^
      showLocation.hashCode ^
      showEmail.hashCode ^
      showPhoneNumber.hashCode ^
      allowTagging.hashCode ^
      requireApprovalForTags.hashCode ^
      blockedUsers.hashCode ^
      mutedUsers.hashCode ^
      theme.hashCode ^
      fontSize.hashCode ^
      language.hashCode ^
      timeFormat.hashCode ^
      dateFormat.hashCode ^
      primaryColor.hashCode ^
      accentColor.hashCode ^
      enableAnimations.hashCode ^
      enableHapticFeedback.hashCode ^
      compactMode.hashCode ^
      twoFactorAuthEnabled.hashCode ^
      requirePasswordForSensitiveActions.hashCode ^
      sessionTimeoutMinutes.hashCode ^
      logOutOnDeviceChange.hashCode ^
      notifyOnNewDeviceLogin.hashCode ^
      trustedDevices.hashCode ^
      allowRememberDevice.hashCode ^
      backupCodesGenerated.hashCode ^
      showFriendsList.hashCode ^
      showFollowersList.hashCode ^
      autoAcceptFriendRequests.hashCode ^
      defaultPostVisibility.hashCode ^
      allowSharing.hashCode ^
      allowDownloads.hashCode ^
      favoriteTopics.hashCode ^
      // Media Auto Download Settings
      mediaAutoDownloadMobile.hashCode ^
      mediaAutoDownloadWiFi.hashCode ^
      // Privacy Settings
      whoCanFollowMe.hashCode ^
      whoCanMessageMe.hashCode ^
      whoCanSeeMyFriends.hashCode ^
      whoCanPostOnMyTimeline.hashCode ^
      whoCanSeeMyBirthday.hashCode ^
      confirmFollowRequests.hashCode ^
      showMyActivities.hashCode ^
      shareMyLocation.hashCode ^
      // Notification Settings
      playSound.hashCode ^
      chatHeads.hashCode ^
      detailedNotifications.hashCode;
}
