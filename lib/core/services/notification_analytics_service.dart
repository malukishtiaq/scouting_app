import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Notification Analytics Service
/// Tracks notification engagement and performance - matches Xamarin implementation
@singleton
class NotificationAnalyticsService {
  static const String _keyAnalyticsData = 'notification_analytics_data';
  static const String _keyDailyStats = 'notification_daily_stats';
  static const String _keyWeeklyStats = 'notification_weekly_stats';
  static const String _keyMonthlyStats = 'notification_monthly_stats';

  late SharedPreferences _prefs;

  /// Initialize the service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===== NOTIFICATION DELIVERY TRACKING =====

  /// Track notification received
  Future<void> trackNotificationReceived({
    required String type,
    required String source, // 'onesignal', 'socket', 'background', 'local'
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_received',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: additionalData,
      );

      await _saveEvent(event);
      await _updateDailyStats('received', type);

      print(
          '📊 Analytics: Notification received - Type: $type, Source: $source');
    } catch (e) {
      print('❌ Error tracking notification received: $e');
    }
  }

  /// Track notification displayed
  Future<void> trackNotificationDisplayed({
    required String type,
    required String source,
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_displayed',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: additionalData,
      );

      await _saveEvent(event);
      await _updateDailyStats('displayed', type);

      print(
          '📊 Analytics: Notification displayed - Type: $type, Source: $source');
    } catch (e) {
      print('❌ Error tracking notification displayed: $e');
    }
  }

  /// Track notification tapped
  Future<void> trackNotificationTapped({
    required String type,
    required String source,
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_tapped',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: additionalData,
      );

      await _saveEvent(event);
      await _updateDailyStats('tapped', type);

      print('📊 Analytics: Notification tapped - Type: $type, Source: $source');
    } catch (e) {
      print('❌ Error tracking notification tapped: $e');
    }
  }

  /// Track notification dismissed
  Future<void> trackNotificationDismissed({
    required String type,
    required String source,
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_dismissed',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: additionalData,
      );

      await _saveEvent(event);
      await _updateDailyStats('dismissed', type);

      print(
          '📊 Analytics: Notification dismissed - Type: $type, Source: $source');
    } catch (e) {
      print('❌ Error tracking notification dismissed: $e');
    }
  }

  // ===== USER ACTION TRACKING =====

  /// Track user action on notification
  Future<void> trackNotificationAction({
    required String
        action, // 'accept', 'decline', 'follow', 'unfollow', 'like', 'comment', etc.
    required String notificationType,
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_action',
        notificationType: notificationType,
        source: 'user_action',
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: {
          'action': action,
          ...?additionalData,
        },
      );

      await _saveEvent(event);
      await _updateDailyStats('action_$action', notificationType);

      print(
          '📊 Analytics: Notification action - Action: $action, Type: $notificationType');
    } catch (e) {
      print('❌ Error tracking notification action: $e');
    }
  }

  /// Track notification marked as read
  Future<void> trackNotificationMarkedAsRead({
    required String notificationType,
    String? notificationId,
    bool isBulkAction = false,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_marked_read',
        notificationType: notificationType,
        source: 'user_action',
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: {
          'is_bulk_action': isBulkAction,
        },
      );

      await _saveEvent(event);
      await _updateDailyStats('marked_read', notificationType);

      print(
          '📊 Analytics: Notification marked as read - Type: $notificationType, Bulk: $isBulkAction');
    } catch (e) {
      print('❌ Error tracking notification marked as read: $e');
    }
  }

  /// Track notification deleted
  Future<void> trackNotificationDeleted({
    required String notificationType,
    String? notificationId,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_deleted',
        notificationType: notificationType,
        source: 'user_action',
        notificationId: notificationId,
        timestamp: DateTime.now(),
      );

      await _saveEvent(event);
      await _updateDailyStats('deleted', notificationType);

      print('📊 Analytics: Notification deleted - Type: $notificationType');
    } catch (e) {
      print('❌ Error tracking notification deleted: $e');
    }
  }

  // ===== PERFORMANCE TRACKING =====

  /// Track notification delivery time
  Future<void> trackDeliveryTime({
    required String type,
    required String source,
    required Duration deliveryTime,
    String? notificationId,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'delivery_time',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: {
          'delivery_time_ms': deliveryTime.inMilliseconds,
        },
      );

      await _saveEvent(event);

      print(
          '📊 Analytics: Delivery time - Type: $type, Time: ${deliveryTime.inMilliseconds}ms');
    } catch (e) {
      print('❌ Error tracking delivery time: $e');
    }
  }

  /// Track notification error
  Future<void> trackNotificationError({
    required String type,
    required String source,
    required String error,
    String? notificationId,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final event = NotificationEvent(
        type: 'notification_error',
        notificationType: type,
        source: source,
        notificationId: notificationId,
        timestamp: DateTime.now(),
        additionalData: {
          'error': error,
          ...?additionalData,
        },
      );

      await _saveEvent(event);
      await _updateDailyStats('error', type);

      print('📊 Analytics: Notification error - Type: $type, Error: $error');
    } catch (e) {
      print('❌ Error tracking notification error: $e');
    }
  }

  // ===== STATISTICS AND REPORTING =====

  /// Get daily statistics
  Map<String, dynamic> getDailyStats() {
    try {
      final jsonString = _prefs.getString(_keyDailyStats);
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
    } catch (e) {
      print('❌ Error getting daily stats: $e');
    }
    return {};
  }

  /// Get weekly statistics
  Map<String, dynamic> getWeeklyStats() {
    try {
      final jsonString = _prefs.getString(_keyWeeklyStats);
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
    } catch (e) {
      print('❌ Error getting weekly stats: $e');
    }
    return {};
  }

  /// Get monthly statistics
  Map<String, dynamic> getMonthlyStats() {
    try {
      final jsonString = _prefs.getString(_keyMonthlyStats);
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
    } catch (e) {
      print('❌ Error getting monthly stats: $e');
    }
    return {};
  }

  /// Get notification engagement rate
  double getEngagementRate() {
    try {
      final dailyStats = getDailyStats();
      final received = dailyStats['received'] ?? 0;
      final tapped = dailyStats['tapped'] ?? 0;

      if (received > 0) {
        return (tapped / received) * 100;
      }
    } catch (e) {
      print('❌ Error calculating engagement rate: $e');
    }
    return 0.0;
  }

  /// Get notification type performance
  Map<String, double> getNotificationTypePerformance() {
    try {
      final dailyStats = getDailyStats();
      final performance = <String, double>{};

      final types = [
        'following',
        'liked_post',
        'comment',
        'friend_request',
        'birthday'
      ];

      for (final type in types) {
        final received = dailyStats['${type}_received'] ?? 0;
        final tapped = dailyStats['${type}_tapped'] ?? 0;

        if (received > 0) {
          performance[type] = (tapped / received) * 100;
        } else {
          performance[type] = 0.0;
        }
      }

      return performance;
    } catch (e) {
      print('❌ Error getting notification type performance: $e');
      return {};
    }
  }

  /// Get all analytics data for debugging
  Map<String, dynamic> getAllAnalyticsData() {
    return {
      'daily_stats': getDailyStats(),
      'weekly_stats': getWeeklyStats(),
      'monthly_stats': getMonthlyStats(),
      'engagement_rate': getEngagementRate(),
      'type_performance': getNotificationTypePerformance(),
      'total_events': _getTotalEventsCount(),
    };
  }

  /// Clear all analytics data
  Future<void> clearAnalyticsData() async {
    await _prefs.remove(_keyAnalyticsData);
    await _prefs.remove(_keyDailyStats);
    await _prefs.remove(_keyWeeklyStats);
    await _prefs.remove(_keyMonthlyStats);
    print('📊 Analytics: All data cleared');
  }

  // ===== PRIVATE HELPER METHODS =====

  /// Save notification event
  Future<void> _saveEvent(NotificationEvent event) async {
    try {
      final events = _getEvents();
      events.add(event);

      // Keep only last 1000 events to prevent storage bloat
      if (events.length > 1000) {
        events.removeRange(0, events.length - 1000);
      }

      final jsonString = jsonEncode(events.map((e) => e.toJson()).toList());
      await _prefs.setString(_keyAnalyticsData, jsonString);
    } catch (e) {
      print('❌ Error saving event: $e');
    }
  }

  /// Get all events
  List<NotificationEvent> _getEvents() {
    try {
      final jsonString = _prefs.getString(_keyAnalyticsData);
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList
            .map((json) => NotificationEvent.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('❌ Error getting events: $e');
    }
    return [];
  }

  /// Update daily statistics
  Future<void> _updateDailyStats(String action, String notificationType) async {
    try {
      final stats = getDailyStats();
      final today = DateTime.now().toIso8601String().split('T')[0];

      if (stats['date'] != today) {
        // New day, reset stats
        stats.clear();
        stats['date'] = today;
      }

      // Update general stats
      stats[action] = (stats[action] ?? 0) + 1;

      // Update type-specific stats
      final typeKey = '${notificationType}_$action';
      stats[typeKey] = (stats[typeKey] ?? 0) + 1;

      final jsonString = jsonEncode(stats);
      await _prefs.setString(_keyDailyStats, jsonString);
    } catch (e) {
      print('❌ Error updating daily stats: $e');
    }
  }

  /// Get total events count
  int _getTotalEventsCount() {
    return _getEvents().length;
  }
}

/// Notification Event Model
class NotificationEvent {
  final String type;
  final String notificationType;
  final String source;
  final String? notificationId;
  final DateTime timestamp;
  final Map<String, dynamic>? additionalData;

  NotificationEvent({
    required this.type,
    required this.notificationType,
    required this.source,
    this.notificationId,
    required this.timestamp,
    this.additionalData,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'notificationType': notificationType,
      'source': source,
      'notificationId': notificationId,
      'timestamp': timestamp.toIso8601String(),
      'additionalData': additionalData,
    };
  }

  factory NotificationEvent.fromJson(Map<String, dynamic> json) {
    return NotificationEvent(
      type: json['type'],
      notificationType: json['notificationType'],
      source: json['source'],
      notificationId: json['notificationId'],
      timestamp: DateTime.parse(json['timestamp']),
      additionalData: json['additionalData'],
    );
  }
}
