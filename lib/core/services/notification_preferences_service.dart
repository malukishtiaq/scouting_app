import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Notification Preferences Service
/// Manages user notification preferences - matches Xamarin implementation
@singleton
class NotificationPreferencesService {
  static const String _keyEnablePushNotifications = 'enable_push_notifications';
  static const String _keyEnableEmailNotifications =
      'enable_email_notifications';
  static const String _keyEnableSMSNotifications = 'enable_sms_notifications';
  static const String _keyEnableSound = 'enable_notification_sound';
  static const String _keyEnableVibration = 'enable_notification_vibration';
  static const String _keyEnableLED = 'enable_notification_led';
  static const String _keyQuietHoursEnabled = 'quiet_hours_enabled';
  static const String _keyQuietHoursStart = 'quiet_hours_start';
  static const String _keyQuietHoursEnd = 'quiet_hours_end';
  static const String _keyNotificationTypes = 'notification_types';

  late SharedPreferences _prefs;

  /// Initialize the service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===== PUSH NOTIFICATION SETTINGS =====

  /// Enable or disable push notifications
  Future<void> setPushNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnablePushNotifications, enabled);
  }

  /// Check if push notifications are enabled
  bool get pushNotificationsEnabled {
    return _prefs.getBool(_keyEnablePushNotifications) ?? true;
  }

  /// Enable or disable email notifications
  Future<void> setEmailNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnableEmailNotifications, enabled);
  }

  /// Check if email notifications are enabled
  bool get emailNotificationsEnabled {
    return _prefs.getBool(_keyEnableEmailNotifications) ?? false;
  }

  /// Enable or disable SMS notifications
  Future<void> setSMSNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnableSMSNotifications, enabled);
  }

  /// Check if SMS notifications are enabled
  bool get smsNotificationsEnabled {
    return _prefs.getBool(_keyEnableSMSNotifications) ?? false;
  }

  // ===== NOTIFICATION BEHAVIOR SETTINGS =====

  /// Enable or disable notification sound
  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnableSound, enabled);
  }

  /// Check if notification sound is enabled
  bool get soundEnabled {
    return _prefs.getBool(_keyEnableSound) ?? true;
  }

  /// Enable or disable notification vibration
  Future<void> setVibrationEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnableVibration, enabled);
  }

  /// Check if notification vibration is enabled
  bool get vibrationEnabled {
    return _prefs.getBool(_keyEnableVibration) ?? true;
  }

  /// Enable or disable notification LED
  Future<void> setLEDEnabled(bool enabled) async {
    await _prefs.setBool(_keyEnableLED, enabled);
  }

  /// Check if notification LED is enabled
  bool get ledEnabled {
    return _prefs.getBool(_keyEnableLED) ?? true;
  }

  // ===== QUIET HOURS SETTINGS =====

  /// Enable or disable quiet hours
  Future<void> setQuietHoursEnabled(bool enabled) async {
    await _prefs.setBool(_keyQuietHoursEnabled, enabled);
  }

  /// Check if quiet hours are enabled
  bool get quietHoursEnabled {
    return _prefs.getBool(_keyQuietHoursEnabled) ?? false;
  }

  /// Set quiet hours start time (24-hour format: "22:00")
  Future<void> setQuietHoursStart(String startTime) async {
    await _prefs.setString(_keyQuietHoursStart, startTime);
  }

  /// Get quiet hours start time
  String get quietHoursStart {
    return _prefs.getString(_keyQuietHoursStart) ?? "22:00";
  }

  /// Set quiet hours end time (24-hour format: "08:00")
  Future<void> setQuietHoursEnd(String endTime) async {
    await _prefs.setString(_keyQuietHoursEnd, endTime);
  }

  /// Get quiet hours end time
  String get quietHoursEnd {
    return _prefs.getString(_keyQuietHoursEnd) ?? "08:00";
  }

  // ===== NOTIFICATION TYPE SETTINGS =====

  /// Set notification type preferences
  Future<void> setNotificationTypes(Map<String, bool> types) async {
    final jsonString = _mapToJson(types);
    await _prefs.setString(_keyNotificationTypes, jsonString);
  }

  /// Get notification type preferences
  Map<String, bool> get notificationTypes {
    final jsonString = _prefs.getString(_keyNotificationTypes);
    if (jsonString != null) {
      return _jsonToMap(jsonString);
    }

    // Default notification types (all enabled)
    return {
      'following': true,
      'liked_post': true,
      'comment': true,
      'shared_your_post': true,
      'friend_request': true,
      'accepted_request': true,
      'visited_profile': true,
      'joined_group': true,
      'accepted_join_request': true,
      'liked_page': true,
      'event_invite': true,
      'story_view': true,
      'story_like': true,
      'live_stream': true,
      'birthday': true,
      'new_message': true,
      'chat_message': true,
      'call': true,
      'announcement': true,
    };
  }

  /// Enable or disable a specific notification type
  Future<void> setNotificationTypeEnabled(String type, bool enabled) async {
    final types = notificationTypes;
    types[type] = enabled;
    await setNotificationTypes(types);
  }

  /// Check if a specific notification type is enabled
  bool isNotificationTypeEnabled(String type) {
    return notificationTypes[type] ?? true;
  }

  // ===== UTILITY METHODS =====

  /// Check if notifications should be sent based on quiet hours
  bool shouldSendNotification() {
    if (!quietHoursEnabled) return true;

    final now = DateTime.now();
    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final startTime = quietHoursStart;
    final endTime = quietHoursEnd;

    // Handle case where quiet hours cross midnight (e.g., 22:00 to 08:00)
    if (startTime.compareTo(endTime) > 0) {
      // Quiet hours cross midnight
      return currentTime.compareTo(endTime) >= 0 &&
          currentTime.compareTo(startTime) < 0;
    } else {
      // Quiet hours within same day
      return currentTime.compareTo(startTime) < 0 ||
          currentTime.compareTo(endTime) >= 0;
    }
  }

  /// Reset all preferences to default values
  Future<void> resetToDefaults() async {
    await _prefs.clear();
    // Set default values
    await setPushNotificationsEnabled(true);
    await setEmailNotificationsEnabled(false);
    await setSMSNotificationsEnabled(false);
    await setSoundEnabled(true);
    await setVibrationEnabled(true);
    await setLEDEnabled(true);
    await setQuietHoursEnabled(false);
    await setQuietHoursStart("22:00");
    await setQuietHoursEnd("08:00");
    await setNotificationTypes({
      'following': true,
      'liked_post': true,
      'comment': true,
      'shared_your_post': true,
      'friend_request': true,
      'accepted_request': true,
      'visited_profile': true,
      'joined_group': true,
      'accepted_join_request': true,
      'liked_page': true,
      'event_invite': true,
      'story_view': true,
      'story_like': true,
      'live_stream': true,
      'birthday': true,
      'new_message': true,
      'chat_message': true,
      'call': true,
      'announcement': true,
    });
  }

  /// Get all preferences as a map for debugging
  Map<String, dynamic> getAllPreferences() {
    return {
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
      'smsNotificationsEnabled': smsNotificationsEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'ledEnabled': ledEnabled,
      'quietHoursEnabled': quietHoursEnabled,
      'quietHoursStart': quietHoursStart,
      'quietHoursEnd': quietHoursEnd,
      'notificationTypes': notificationTypes,
      'shouldSendNotification': shouldSendNotification(),
    };
  }

  // ===== PRIVATE HELPER METHODS =====

  /// Convert map to JSON string
  String _mapToJson(Map<String, bool> map) {
    final entries = map.entries.map((e) => '"${e.key}":${e.value}').join(',');
    return '{$entries}';
  }

  /// Convert JSON string to map
  Map<String, bool> _jsonToMap(String jsonString) {
    try {
      final map = <String, bool>{};
      final cleanJson = jsonString.replaceAll('{', '').replaceAll('}', '');
      final pairs = cleanJson.split(',');

      for (final pair in pairs) {
        final keyValue = pair.split(':');
        if (keyValue.length == 2) {
          final key = keyValue[0].replaceAll('"', '').trim();
          final value = keyValue[1].trim() == 'true';
          map[key] = value;
        }
      }

      return map;
    } catch (e) {
      print('❌ Error parsing notification types JSON: $e');
      return {};
    }
  }
}
