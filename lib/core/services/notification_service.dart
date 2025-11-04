import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@singleton
class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  int _notificationId = 21828; // Same as Xamarin

  Future<void> initialize() async {
    if (_initialized) {
      debugPrint('🔔 [NOTIFICATION] Already initialized, skipping...');
      return;
    }

    debugPrint('🔔 [NOTIFICATION] Initializing notification service...');

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _notifications.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      _initialized = true;
      debugPrint('✅ [NOTIFICATION] Service initialized successfully');
    } catch (e) {
      debugPrint('❌ [NOTIFICATION] Initialization failed: $e');
      rethrow;
    }
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - navigate to chat
    debugPrint('📱 Notification tapped: ${response.payload}');
  }

  /// Show user notification (matches Xamarin ShowUserNotification)
  Future<void> showChatNotification({
    required String type,
    required String conversationId,
    required String username,
    required String message,
    required String userId,
    required String chatId,
    String? avatar,
    int unreadCount = 1,
  }) async {
    debugPrint('🔔 [NOTIFICATION] Attempting to show notification...');
    debugPrint('🔔 [NOTIFICATION] Type: $type');
    debugPrint('🔔 [NOTIFICATION] Username: $username');
    debugPrint('🔔 [NOTIFICATION] Message: $message');
    debugPrint('🔔 [NOTIFICATION] UserID: $userId');
    debugPrint('🔔 [NOTIFICATION] ChatID: $chatId');

    if (!_initialized) {
      debugPrint(
          '🔔 [NOTIFICATION] Service not initialized, initializing now...');
      await initialize();
    }

    const androidDetails = AndroidNotificationDetails(
      'chat_channel',
      'Chat Messages',
      channelDescription: 'New chat messages',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _notifications.show(
        _notificationId,
        username,
        message,
        details,
        payload: '$type|$userId|$chatId',
      );
      debugPrint('✅ [NOTIFICATION] Successfully shown: $username - $message');
    } catch (e) {
      debugPrint('❌ [NOTIFICATION] Failed to show: $e');
    }
  }

  /// Cancel specific notification
  Future<void> cancelNotification(String tag) async {
    await _notifications.cancel(_notificationId);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Request notification permissions (iOS)
  Future<bool> requestPermissions() async {
    if (!_initialized) await initialize();

    final result = await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return result ?? true;
  }
}
