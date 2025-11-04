import 'dart:async';
import 'package:flutter/material.dart';
import 'socket_service_interface.dart';
import 'socket_constants.dart' hide SocketConnectionType;
import '../../app_settings.dart';

/// Monitors socket connection and shows notifications
class SocketConnectionMonitor {
  final ISocketService _socketService;
  final GlobalKey<NavigatorState> _navigatorKey;
  StreamSubscription<SocketConnectionState>? _subscription;
  SocketConnectionState? _lastState;

  SocketConnectionMonitor({
    required ISocketService socketService,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _socketService = socketService,
        _navigatorKey = navigatorKey;

  /// Start monitoring socket connection
  void startMonitoring() {
    // Only monitor if socket mode is enabled
    if (AppSettings.connectionType != SocketConnectionType.socket) {
      _subscription?.cancel();
      _subscription = null;
      return;
    }

    _subscription
        ?.cancel(); // Ensure previous subscription is cancelled before starting a new one

    _subscription = _socketService.connectionStateStream.listen((state) {
      _handleConnectionStateChange(state);
    });

    print('🔍 Socket connection monitor started');
  }

  /// Stop monitoring
  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
    print('🔍 Socket connection monitor stopped');
  }

  /// Handle connection state changes
  void _handleConnectionStateChange(SocketConnectionState newState) {
    // Skip if same state
    if (_lastState == newState) return;

    final previousState = _lastState;
    _lastState = newState;

    // Show notification for important state changes
    switch (newState) {
      case SocketConnectionState.connected:
        _showSuccessNotification('Connected', 'Real-time messaging enabled');
        print('✅ Socket Status: CONNECTED (Real-time messaging active)');
        break;

      case SocketConnectionState.reconnecting:
        if (previousState == SocketConnectionState.connected ||
            previousState == SocketConnectionState.disconnected) {
          _showInfoNotification(
              'Reconnecting', 'Attempting to restore connection...');
          print('🔄 Socket Status: RECONNECTING');
        }
        break;

      case SocketConnectionState.failed:
        _showErrorNotification('Connection Failed', 'Using fallback mode');
        print('❌ Socket Status: FAILED (Falling back to REST API)');
        break;

      case SocketConnectionState.disconnected:
        if (previousState == SocketConnectionState.connected) {
          _showWarningNotification(
              'Disconnected', 'Messages will use REST API');
          print('⚠️ Socket Status: DISCONNECTED');
        }
        break;

      case SocketConnectionState.connecting:
        print('🔌 Socket Status: CONNECTING...');
        break;
    }
  }

  /// Show success notification (green)
  void _showSuccessNotification(String title, String message) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  /// Show error notification (red)
  void _showErrorNotification(String title, String message) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
    );
  }

  /// Show warning notification (orange)
  void _showWarningNotification(String title, String message) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange.shade600,
      icon: Icons.warning,
    );
  }

  /// Show info notification (blue)
  void _showInfoNotification(String title, String message) {
    _showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.blue.shade600,
      icon: Icons.info,
    );
  }

  /// Show snackbar notification
  void _showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final context = _navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Get current connection status as string
  String getStatusText() {
    final state = _socketService.connectionState;
    switch (state) {
      case SocketConnectionState.connected:
        return '✅ Connected (Socket ID: ${_socketService.socketId})';
      case SocketConnectionState.connecting:
        return '🔌 Connecting...';
      case SocketConnectionState.reconnecting:
        return '🔄 Reconnecting...';
      case SocketConnectionState.failed:
        return '❌ Failed';
      case SocketConnectionState.disconnected:
        return '⚫ Disconnected';
    }
  }

  /// Check if socket is ready for messaging
  bool get isReady => _socketService.isConnected;

  /// Get connection statistics
  String getConnectionStats() {
    final stats = _socketService.connectionStats;
    return '''
📊 Connection Statistics:
  Total Connections: ${stats.totalConnections}
  Successful: ${stats.successfulConnections}
  Failed: ${stats.failedConnections}
  Messages Sent: ${stats.totalMessagesSent}
  Messages Received: ${stats.totalMessagesReceived}
  Errors: ${stats.totalErrors}
  Last Connected: ${stats.lastConnected}
  Last Error: ${stats.lastError ?? 'None'}
''';
  }
}
