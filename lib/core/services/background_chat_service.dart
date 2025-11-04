import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:injectable/injectable.dart';
import '../../app_settings.dart';
import '../common/local_storage.dart';
import '../constants/website_constants.dart';
import '../background/generic_background_service.dart';
import '../../mainapis.dart';

const String chatPollingTask = 'chat_polling_task';

/// Background callback (must be top-level function)
@pragma('vm:entry-point')
void backgroundChatCallback() {
  Workmanager().executeTask((task, inputData) async {
    try {
      debugPrint('🔄 Background chat polling started');

      // Check if user is logged in
      final token = LocalStorage.authToken;
      final userId = LocalStorage.memberID;

      if (token == null || token.isEmpty || userId <= 0) {
        debugPrint('⚠️ No valid session, skipping poll');
        return Future.value(true);
      }

      // Only poll if NOT using socket connection
      if (AppSettings.connectionType == SocketConnectionType.socket) {
        debugPrint('⚠️ Socket mode active, skipping API poll');
        return Future.value(true);
      }

      // Poll chat API
      await _pollChatAPI(token, userId);

      return Future.value(true);
    } catch (e) {
      debugPrint('❌ Background polling error: $e');
      return Future.value(false);
    }
  });
}

Future<void> _pollChatAPI(String token, int userId) async {
  try {
    debugPrint('🔄 Polling chat API for user: $userId');

    // Use GenericBackgroundService for actual API polling
    final backgroundService = GenericBackgroundService();

    final result = await backgroundService.executeCustomApiCall(
      apiUrl: '${MainAPIS.websiteUrl}/api.php',
      taskName: 'BackgroundChatPolling',
      method: 'POST',
      bodyFields: {
        'server_key': WebsiteConstants.serverKey,
        'type': 'get_messages',
        'user_id': userId.toString(),
        'limit': '10',
      },
      accessToken: token,
      timeout: const Duration(seconds: 30),
    );

    if (result['success'] == true) {
      debugPrint('✅ Background chat polling successful');
      // Process new messages if any
      final data = result['data'];
      if (data != null && data['messages'] != null) {
        final messages = data['messages'] as List;
        if (messages.isNotEmpty) {
          debugPrint('📨 Found ${messages.length} new messages');
          // TODO: Show local notification for new messages
        }
      }
    } else {
      debugPrint('❌ Background chat polling failed: ${result['error']}');
    }
  } catch (e) {
    debugPrint('❌ Poll API error: $e');
  }
}

@singleton
class BackgroundChatService {
  bool _initialized = false;

  /// Initialize background service (matches Xamarin AppApiService)
  Future<void> initialize() async {
    if (_initialized) return;

    await Workmanager().initialize(
      backgroundChatCallback,
      isInDebugMode: kDebugMode,
    );

    _initialized = true;
    debugPrint('✅ Background chat service initialized');
  }

  /// Start background polling (every 6 seconds like Xamarin)
  Future<void> startPolling() async {
    if (!_initialized) await initialize();

    // Cancel existing task
    await Workmanager().cancelByUniqueName(chatPollingTask);

    // Register periodic task (minimum is 15 minutes on production)
    // For testing, use immediate task
    if (kDebugMode) {
      // In debug: run immediately and repeat
      await Workmanager().registerPeriodicTask(
        chatPollingTask,
        chatPollingTask,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    } else {
      // Production: 15 minute intervals
      await Workmanager().registerPeriodicTask(
        chatPollingTask,
        chatPollingTask,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    }

    debugPrint('🔄 Background polling started');
  }

  /// Stop background polling
  Future<void> stopPolling() async {
    await Workmanager().cancelByUniqueName(chatPollingTask);
    debugPrint('⏹️ Background polling stopped');
  }
}
