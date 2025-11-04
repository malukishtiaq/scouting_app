import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:logger/logger.dart';

import 'socket_service_interface.dart';
import 'socket_events.dart' as events;
import 'socket_actions.dart' as actions;
import 'socket_constants.dart';
import 'socket_models.dart';
import '../../mainapis.dart';
import '../../app_settings.dart';
import '../services/notification_service.dart';

/// Socket service implementation using Socket.IO client
@Singleton(as: ISocketService)
class SocketService implements ISocketService {
  final Logger _logger;
  final NotificationService _notificationService;

  // Configuration from AppSettings (mirroring Xamarin)
  String get _defaultPort => AppSettings.socketPort;
  static const String _defaultPath = '/socket.io';
  static const bool _enableHeartbeat = true;
  static const Duration _heartbeatInterval = Duration(seconds: 25);
  static const bool _enableMessageQueue = true;
  static const int _maxQueuedMessages = 100;

  io.Socket? _socket;
  final StreamController<events.SocketEvent> _eventController =
      StreamController<events.SocketEvent>.broadcast();
  final StreamController<SocketConnectionState> _connectionStateController =
      StreamController<SocketConnectionState>.broadcast();

  SocketConnectionState _connectionState = SocketConnectionState.disconnected;
  String? _socketId;
  bool _isJoining = false;
  SocketConnectionStats _stats = SocketConnectionStats.initial();

  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  final List<actions.SocketAction> _messageQueue = [];
  final Map<String, Completer<SocketActionResult>> _pendingActions = {};

  SocketService(this._logger, this._notificationService);

  @override
  Stream<events.SocketEvent> get eventStream => _eventController.stream;

  @override
  Stream<SocketConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  @override
  SocketConnectionState get connectionState => _connectionState;

  @override
  bool get isConnected => _connectionState == SocketConnectionState.connected;

  @override
  String? get socketId => _socketId;

  @override
  bool get isJoining => _isJoining;

  @override
  SocketConnectionStats get connectionStats => _stats;

  @override
  Future<void> connect() async {
    if (_connectionState == SocketConnectionState.connected ||
        _connectionState == SocketConnectionState.connecting) {
      _logger.i('🔌 Socket already connected or connecting, skipping...');
      return;
    }

    _logger.i('🔌 Starting socket connection process...');
    _updateConnectionState(SocketConnectionState.connecting);
    _stats = _stats.copyWith(totalConnections: _stats.totalConnections + 1);

    try {
      // Build socket URL dynamically from MainAPIS.websiteUrl (like Xamarin)
      // Extract protocol and host from the dynamic server URL
      final uri = Uri.parse(MainAPIS.websiteUrl);
      String host = uri.host; // e.g., demo.wowonder.com

      _logger.i('🔌 Parsed website URL: ${MainAPIS.websiteUrl}');
      _logger.i('🔌 Extracted host: $host');

      // WORKAROUND: For talkkro.com, use IP address instead of domain
      // because DNS might not route port 449 correctly to Node.js server
      if (host == 'talkkro.com') {
        host = '109.199.105.235';
        _logger.i('🔄 Using IP address for socket connection: $host');
      }

      // Skip socket connection for demo server (no Node.js socket server)
      if (host == 'demo.wowonder.com') {
        _logger
            .w('⚠️ Demo server does not support socket connections - skipping');
        _updateConnectionState(SocketConnectionState.failed);
        return;
      }

      // Socket server uses HTTPS protocol on port 449 (SSL)
      // SSL certificates are now working on the server
      final socketUrl = 'https://$host:449';

      _logger.i('🔌 Connecting to socket server: $socketUrl$_defaultPath');
      _logger.i('🔌 Using transport: ${AppSettings.socketTransport}');
      _logger.i('🔌 Socket port: $_defaultPort');

      // Test HTTP connection first to verify server is reachable
      _logger.i('🔍 Testing HTTP connection before socket connection...');
      await _testHttpConnection(socketUrl);

      // Socket.IO v2.x configuration (compatible with Socket.IO v2.x server)
      _socket = io.io(
        socketUrl,
        io.OptionBuilder()
            .setTransports(
                ['polling', 'websocket']) // Prioritize polling for stability
            .enableAutoConnect() // Auto-connect for v2.x
            .enableReconnection() // Enable reconnection
            .setReconnectionAttempts(3) // Limit to 3 attempts
            .setReconnectionDelay(1000) // 1 second delay between attempts
            .setReconnectionDelayMax(5000) // Max 5 seconds delay
            .setTimeout(20000) // 20 second connection timeout
            .setExtraHeaders({'User-Agent': 'Flutter-SocketIO-Client'})
            .build(),
      );

      _setupEventListeners();

      // Add connection debugging
      _logger.i('🔌 Socket.IO v2.x client connecting to v2.x server...');
    } catch (e) {
      _logger.e('❌ Failed to connect to socket server: $e');
      _updateConnectionState(SocketConnectionState.failed);
      _stats = _stats.copyWith(
        failedConnections: _stats.failedConnections + 1,
        lastError: e.toString(),
      );
      _emitEvent(events.SocketError(
        error: e.toString(),
        errorType: SocketErrorType.connectionRefused,
        timestamp: DateTime.now(),
      ));
    }
  }

  @override
  Future<void> disconnect() async {
    _logger.i('Disconnecting from socket server');

    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _clearMessageQueue();

    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }

    _updateConnectionState(SocketConnectionState.disconnected);
    _socketId = null;
    _isJoining = false;
  }

  @override
  Future<void> join(String username, String accessToken) async {
    if (!isConnected) {
      _logger.w('⚠️ Cannot join: socket not connected');
      return;
    }

    if (_isJoining) {
      _logger.w('⚠️ Already joining socket room');
      return;
    }

    _isJoining = true;
    _logger.i('🔌 Joining socket room with username: $username');

    try {
      // Match Xamarin format exactly
      _socket!.emit(SocketEventNames.join, {
        'username': username,
        'user_id': accessToken, // Xamarin uses 'user_id' not 'access_token'
      });

      // Wait for joined event
      final completer = Completer<void>();
      late StreamSubscription subscription;

      subscription = eventStream.listen((event) {
        if (event is events.SocketJoined) {
          subscription.cancel();
          completer.complete();
        }
      });

      // Timeout after 10 seconds
      Timer(const Duration(seconds: 10), () {
        if (!completer.isCompleted) {
          subscription.cancel();
          completer.completeError('Join timeout');
        }
      });

      await completer.future;
      _logger.i('✅ Successfully joined socket room');
    } catch (e) {
      _logger.e('❌ Failed to join socket room: $e');
      _isJoining = false;
      rethrow;
    }
  }

  @override
  Future<void> leave() async {
    if (!isConnected) {
      return;
    }

    _logger.i('Leaving socket room');
    _socket!.emit('leave');
    _isJoining = false;
  }

  @override
  Future<SocketActionResult> sendAction(actions.SocketAction action) async {
    if (!isConnected) {
      if (_enableMessageQueue) {
        _queueMessage(action);
        return SocketActionResult.success({'queued': true});
      }
      return SocketActionResult.error('Socket not connected');
    }

    try {
      switch (action.runtimeType) {
        case actions.SendMessageAction:
          return await sendMessage(action as actions.SendMessageAction);
        case actions.SendGroupMessageAction:
          return await sendGroupMessage(
              action as actions.SendGroupMessageAction);
        case actions.SendPageMessageAction:
          return await sendPageMessage(action as actions.SendPageMessageAction);
        case actions.SendMessageFileAction:
          return await sendMessageFile(action as actions.SendMessageFileAction);
        case actions.SendGroupMessageFileAction:
          return await sendGroupMessageFile(
              action as actions.SendGroupMessageFileAction);
        case actions.SendPageMessageFileAction:
          return await sendPageMessageFile(
              action as actions.SendPageMessageFileAction);
        case actions.SendTypingAction:
          return await sendTyping(action as actions.SendTypingAction);
        case actions.SendStopTypingAction:
          return await sendStopTyping(action as actions.SendStopTypingAction);
        case actions.SendRecordingAction:
          return await sendRecording(action as actions.SendRecordingAction);
        case actions.SendStopRecordingAction:
          return await sendStopRecording(
              action as actions.SendStopRecordingAction);
        case actions.MarkMessageSeenAction:
          return await markMessageSeen(action as actions.MarkMessageSeenAction);
        case actions.SendSeenMessagesAction:
          return await sendSeenMessages(
              action as actions.SendSeenMessagesAction);
        case actions.SendMessageReactionAction:
          return await sendMessageReaction(
              action as actions.SendMessageReactionAction);
        case actions.CreateCallAction:
          return await createCall(action as actions.CreateCallAction);
        case actions.PingLastSeenAction:
          return await pingLastSeen(action as actions.PingLastSeenAction);
        default:
          return SocketActionResult.error(
              'Unknown action type: ${action.runtimeType}');
      }
    } catch (e) {
      _logger.e('Failed to send action: $e');
      return SocketActionResult.error(e.toString());
    }
  }

  @override
  Future<SocketActionResult> sendMessage(
      actions.SendMessageAction action) async {
    _logger.d('Sending private message to: ${action.toId}');

    // Debug log the user data being sent
    _logger.d('🔍 [SOCKET] User data being sent:');
    _logger.d('🔍 [SOCKET] - userAvatar: "${action.userAvatar ?? 'NULL'}"');
    _logger.d('🔍 [SOCKET] - userName: "${action.userName ?? 'NULL'}"');
    _logger.d('🔍 [SOCKET] - userId: "${action.userId ?? 'NULL'}"');
    _logger.d('🔍 [SOCKET] - username: "${action.username}"');

    final messageData = {
      'to_id': action.toId,
      'from_id': action.fromId, // Required: sender's access token
      'username': action.username, // Required: sender's username
      'msg': action
          .message, // Server expects 'msg' field (line 20 in PrivateMessageController.js)
      'color': action.color,
      'message_reply_id': action.replyId,
      'story_id': action.storyId,
      'lat': action.latitude,
      'lng': action.longitude,
      'isSticker': 'false', // Required field (always false for text messages)
      // Try different user data formats that the server might expect
      'user_avatar': action.userAvatar ?? '', // User's avatar URL
      'user_name': action.userName ?? action.username, // User's display name
      'user_id': action.userId ?? '', // User's ID
      // Also try nested user object format
      'user': {
        'avatar': action.userAvatar ?? '',
        'name': action.userName ?? action.username,
        'id': action.userId ?? '',
        'username': action.username,
      },
      // Try messageUser format (like in HTTP response)
      'messageUser': {
        'user_id': action.userId ?? '',
        'username': action.username,
        'avatar': action.userAvatar ?? '',
        'first_name': '',
        'last_name': '',
      },
    };

    _logger.d('🔍 [SOCKET] Complete message data: $messageData');

    _socket!.emit(SocketEventNames.sendMessage, messageData);

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendGroupMessage(
      actions.SendGroupMessageAction action) async {
    _logger.d('Sending group message to: ${action.groupId}');

    _socket!.emit(SocketEventNames.sendGroupMessage, {
      'group_id': action.groupId,
      'from_id': action.fromId, // Required: sender's access token
      'username': action.username, // Required: sender's username
      'msg': action.message, // Server expects 'msg' field
      'message_reply_id': action.replyId,
      'isSticker': 'false', // Required field (always false for text messages)
      // Add user data to prevent null avatar error
      'user_avatar': action.userAvatar ?? '', // User's avatar URL
      'user_name': action.userName ?? action.username, // User's display name
      'user_id': action.userId ?? '', // User's ID
    });

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendPageMessage(
      actions.SendPageMessageAction action) async {
    _logger.d('Sending page message to: ${action.pageId}');

    _socket!.emit(SocketEventNames.sendPageMessage, {
      'page_id': action.pageId,
      'to_id': action.toId,
      'from_id': action.fromId, // Required: sender's access token
      'username': action.username, // Required: sender's username
      'msg': action.message, // Server expects 'msg' field
      'message_reply_id': action.replyId,
      'isSticker': 'false', // Required field (always false for text messages)
      // Add user data to prevent null avatar error
      'user_avatar': action.userAvatar ?? '', // User's avatar URL
      'user_name': action.userName ?? action.username, // User's display name
      'user_id': action.userId ?? '', // User's ID
    });

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendMessageFile(
      actions.SendMessageFileAction action) async {
    _logger.d('Sending file message to: ${action.toId}');

    _socket!.emit(SocketEventNames.sendMessageFile, {
      'to_id': action.toId,
      'message_id': action.messageId,
      'reply_id': action.replyId,
      'story_id': action.storyId,
    });

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendGroupMessageFile(
      actions.SendGroupMessageFileAction action) async {
    _logger.d('Sending group file message to: ${action.groupId}');

    _socket!.emit(SocketEventNames.sendGroupMessageFile, {
      'group_id': action.groupId,
      'message_id': action.messageId,
      'reply_id': action.replyId,
    });

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendPageMessageFile(
      actions.SendPageMessageFileAction action) async {
    _logger.d('Sending page file message to: ${action.pageId}');

    _socket!.emit(SocketEventNames.sendPageMessageFile, {
      'page_id': action.pageId,
      'to_id': action.toId,
      'message_id': action.messageId,
      'reply_id': action.replyId,
    });

    _stats = _stats.copyWith(totalMessagesSent: _stats.totalMessagesSent + 1);
    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendTyping(actions.SendTypingAction action) async {
    _logger.d('Sending typing indicator to: ${action.toId}');

    _socket!.emit(SocketEventNames.typing, {
      'to_id': action.toId,
      'is_typing': action.isTyping,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendStopTyping(
      actions.SendStopTypingAction action) async {
    _logger.d('Sending stop typing indicator to: ${action.toId}');

    _socket!.emit(SocketEventNames.stopTyping, {
      'to_id': action.toId,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendRecording(
      actions.SendRecordingAction action) async {
    _logger.d('Sending recording indicator to: ${action.toId}');

    _socket!.emit(SocketEventNames.recording, {
      'to_id': action.toId,
      'is_recording': action.isRecording,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendStopRecording(
      actions.SendStopRecordingAction action) async {
    _logger.d('Sending stop recording indicator to: ${action.toId}');

    _socket!.emit(SocketEventNames.stopRecording, {
      'to_id': action.toId,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> markMessageSeen(
      actions.MarkMessageSeenAction action) async {
    _logger.d('Marking message as seen: ${action.messageId}');

    _socket!.emit(SocketEventNames.messageSeen, {
      'message_id': action.messageId,
      'to_id': action.toId,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendSeenMessages(
      actions.SendSeenMessagesAction action) async {
    _logger.d('Sending seen messages to: ${action.toId}');

    _socket!.emit(SocketEventNames.sendSeenMessages, {
      'to_id': action.toId,
      'access_token': action.accessToken,
      'from_user_id': action.fromUserId,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> sendMessageReaction(
      actions.SendMessageReactionAction action) async {
    _logger.d('Sending message reaction: ${action.reaction}');

    _socket!.emit(SocketEventNames.sendMessageReaction, {
      'message_id': action.messageId,
      'reaction': action.reaction,
      'access_token': action.accessToken,
    });

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> createCall(actions.CreateCallAction action) async {
    _logger.d('Creating call to: ${action.recipientId}');

    // Match Xamarin format: emit "user_notification" with to_id and type
    _socket!.emit('user_notification', {
      'to_id': action.recipientId,
      'type':
          'create_video', // Xamarin always sends "create_video" even for audio calls
    });

    _logger
        .i('📲 Socket: Sent call notification to user ${action.recipientId}');

    return SocketActionResult.success();
  }

  @override
  Future<SocketActionResult> pingLastSeen(
      actions.PingLastSeenAction action) async {
    _logger.d('Pinging last seen');

    _socket!.emit(SocketEventNames.pingLastSeen, {
      'access_token': action.accessToken,
    });

    return SocketActionResult.success();
  }

  @override
  Future<void> reconnect() async {
    _logger.i('Reconnecting socket');
    await disconnect();
    await Future.delayed(const Duration(seconds: 1));
    await connect();
  }

  @override
  void clearMessageQueue() {
    _clearMessageQueue();
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _eventController.close();
    _connectionStateController.close();
    _clearMessageQueue();

    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
  }

  /// Setup socket event listeners
  void _setupEventListeners() {
    if (_socket == null) return;

    // Connection events
    _socket!.onConnect((_) {
      _logger.i('✅ Socket connected');
      _socketId = _socket!.id;
      _updateConnectionState(SocketConnectionState.connected);
      _stats = _stats.copyWith(
        successfulConnections: _stats.successfulConnections + 1,
        lastConnected: DateTime.now(),
      );
      _emitEvent(events.SocketConnected(
        socketId: _socketId!,
        timestamp: DateTime.now(),
      ));
      _startHeartbeat();
      _processMessageQueue();
    });

    _socket!.onDisconnect((_) {
      _logger.i('🔌 Socket disconnected');
      _updateConnectionState(SocketConnectionState.disconnected);
      _stats = _stats.copyWith(lastDisconnected: DateTime.now());
      _emitEvent(events.SocketDisconnected(
        reason: 'Disconnected',
        timestamp: DateTime.now(),
      ));
      _stopHeartbeat();
      _isJoining = false; // Reset join state on disconnect
    });

    _socket!.onError((error) {
      _logger.e('❌ Socket error: $error');
      _logger.e('❌ Socket error type: ${error.runtimeType}');
      _logger.e('❌ Socket error details: ${error.toString()}');
      _updateConnectionState(SocketConnectionState.failed);
      _stats = _stats.copyWith(
        totalErrors: _stats.totalErrors + 1,
        lastError: error.toString(),
      );
      _emitEvent(events.SocketError(
        error: error.toString(),
        errorType: SocketErrorType.unknown,
        timestamp: DateTime.now(),
      ));
    });

    // Add connect_error listener to capture handshake errors
    _socket!.onConnectError((error) {
      _logger.e('❌ Socket connect_error: $error');
      _logger.e('❌ Socket connect_error type: ${error.runtimeType}');
      _logger.e('❌ Socket connect_error details: ${error.toString()}');
    });

    // Reconnection events
    _socket!.onReconnect((_) {
      _logger.i('Socket reconnected');
      _socketId = _socket!.id;
      _updateConnectionState(SocketConnectionState.connected);
      _emitEvent(events.SocketReconnected(
        socketId: _socketId!,
        timestamp: DateTime.now(),
      ));
      _startHeartbeat();
      _processMessageQueue();
    });

    _socket!.onReconnectAttempt((attempt) {
      _logger.i('Socket reconnection attempt: $attempt');
      _updateConnectionState(SocketConnectionState.reconnecting);
      _emitEvent(events.SocketReconnecting(
        attempt: attempt,
        timestamp: DateTime.now(),
      ));
    });

    _socket!.onReconnectFailed((_) {
      _logger.e('Socket reconnection failed');
      _updateConnectionState(SocketConnectionState.failed);
      _emitEvent(events.SocketReconnectFailed(
        reason: 'Reconnection failed',
        timestamp: DateTime.now(),
      ));
    });

    // Authentication events
    _socket!.on(SocketEventNames.joined, (data) {
      _logger.i('Socket joined room');
      _isJoining = false;
      _emitEvent(events.SocketJoined(
        username: data['username'] ?? '',
        accessToken: data['access_token'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    // Chat events
    _socket!.on(SocketEventNames.privateMessage, (data) {
      _logger.d('🔔 [SOCKET] ===== PRIVATE MESSAGE RECEIVED =====');
      _logger.d('🔔 [SOCKET] Raw data: $data');
      _stats = _stats.copyWith(
          totalMessagesReceived: _stats.totalMessagesReceived + 1);

      final messageData = SocketMessageData.fromJson(data);
      _logger.d('🔔 [SOCKET] Parsed message: ${messageData.message}');
      _logger.d('🔔 [SOCKET] From user: ${messageData.fromUserId}');
      _logger.d('🔔 [SOCKET] To user: ${messageData.toUserId}');

      _emitEvent(events.PrivateMessageReceived(
        message: messageData,
        timestamp: DateTime.now(),
      ));

      // Show notification (matches Xamarin behavior)
      _logger.i(
          '🔔 [SOCKET] Triggering notification for private message from: ${messageData.fromUserId}');
      _notificationService.showChatNotification(
        type: 'user',
        conversationId: messageData.id,
        username: 'User',
        message: messageData.message,
        userId: messageData.fromUserId,
        chatId: messageData.toUserId,
      );
      _logger.d('🔔 [SOCKET] ======================================');
    });

    _socket!.on(SocketEventNames.groupMessage, (data) {
      _logger.d('Group message received');
      _stats = _stats.copyWith(
          totalMessagesReceived: _stats.totalMessagesReceived + 1);

      final messageData = SocketGroupMessageData.fromJson(data);

      _emitEvent(events.GroupMessageReceived(
        message: messageData,
        timestamp: DateTime.now(),
      ));

      // Show notification for group message
      _logger.i(
          '🔔 Triggering notification for group message from: ${messageData.fromUserId}');
      _notificationService.showChatNotification(
        type: 'group',
        conversationId: messageData.groupId,
        username: 'Group',
        message: messageData.message,
        userId: messageData.fromUserId,
        chatId: messageData.groupId,
      );
    });

    _socket!.on(SocketEventNames.pageMessage, (data) {
      _logger.d('Page message received');
      _stats = _stats.copyWith(
          totalMessagesReceived: _stats.totalMessagesReceived + 1);

      final messageData = SocketPageMessageData.fromJson(data);

      _emitEvent(events.PageMessageReceived(
        message: messageData,
        timestamp: DateTime.now(),
      ));

      // Show notification for page message
      _logger.i(
          '🔔 Triggering notification for page message from: ${messageData.fromUserId}');
      _notificationService.showChatNotification(
        type: 'page',
        conversationId: messageData.pageId,
        username: 'Page',
        message: messageData.message,
        userId: messageData.fromUserId,
        chatId: messageData.pageId,
      );
    });

    // Comment notification events (from WoWonder server)
    _socket!.on('comment_notification', (data) {
      _logger.d('🔔 [SOCKET] ===== COMMENT NOTIFICATION RECEIVED =====');
      _logger.d('🔔 [SOCKET] Raw comment notification data: $data');
      _logger.d('🔔 [SOCKET] ========================================');

      // Handle comment notifications
      if (data is Map<String, dynamic>) {
        final commentId = data['comment_id'] ?? '';
        final userId = data['user_id'] ?? '';
        final type = data['type'] ?? 'added';

        _logger.d('🔔 [SOCKET] Comment ID: $commentId');
        _logger.d('🔔 [SOCKET] User ID: $userId');
        _logger.d('🔔 [SOCKET] Type: $type');

        // This should trigger OneSignal notification
        // The server should be sending this to OneSignal, not directly to the socket
        _logger.w(
            '🔔 [SOCKET] ⚠️ Comment notification via socket - this should go through OneSignal instead');
      }
    });

    // Notification events (from Xamarin reference)
    _socket!.on('notification', (data) {
      _logger.d('🔔 [SOCKET] ===== NOTIFICATION EVENT RECEIVED =====');
      _logger.d('🔔 [SOCKET] Raw notification data: $data');
      _logger.d('🔔 [SOCKET] ======================================');

      // Handle different types of notifications
      if (data is Map<String, dynamic>) {
        final notificationType = data['type'] ?? 'unknown';
        final notificationTitle = data['title'] ?? 'Notification';
        final notificationBody = data['body'] ?? '';
        final notificationData = data['data'] ?? {};

        _logger.d('🔔 [SOCKET] Notification type: $notificationType');
        _logger.d('🔔 [SOCKET] Title: $notificationTitle');
        _logger.d('🔔 [SOCKET] Body: $notificationBody');
        _logger.d('🔔 [SOCKET] Data: $notificationData');

        // This is likely a server-side notification that should trigger OneSignal
        // The server should be sending this to OneSignal, not directly to the socket
        _logger.w(
            '🔔 [SOCKET] ⚠️ Server sent notification via socket - this should go through OneSignal instead');
      }
    });

    // Typing events
    _socket!.on(SocketEventNames.typingEvent, (data) {
      _logger.d('Typing event received');
      _emitEvent(events.TypingEventReceived(
        userId: data['user_id'] ?? '',
        chatId: data['chat_id'] ?? '',
        isTyping: data['is_typing'] ?? false,
        timestamp: DateTime.now(),
      ));
    });

    _socket!.on(SocketEventNames.stopTypingEvent, (data) {
      _logger.d('Stop typing event received');
      _emitEvent(events.TypingEventReceived(
        userId: data['user_id'] ?? '',
        chatId: data['chat_id'] ?? '',
        isTyping: false,
        timestamp: DateTime.now(),
      ));
    });

    // Recording events
    _socket!.on(SocketEventNames.recordingEvent, (data) {
      _logger.d('Recording event received');
      _emitEvent(events.RecordingEventReceived(
        userId: data['user_id'] ?? '',
        chatId: data['chat_id'] ?? '',
        isRecording: data['is_recording'] ?? false,
        timestamp: DateTime.now(),
      ));
    });

    _socket!.on(SocketEventNames.stopRecordingEvent, (data) {
      _logger.d('Stop recording event received');
      _emitEvent(events.RecordingEventReceived(
        userId: data['user_id'] ?? '',
        chatId: data['chat_id'] ?? '',
        isRecording: false,
        timestamp: DateTime.now(),
      ));
    });

    // Message status events
    _socket!.on(SocketEventNames.seenMessages, (data) {
      _logger.d('Message seen event received');
      _emitEvent(events.MessageSeenReceived(
        messageId: data['message_id'] ?? '',
        userId: data['user_id'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    // Message reaction events
    _socket!.on(SocketEventNames.messageReactionReceived, (data) {
      _logger.d('Message reaction received');
      _emitEvent(events.MessageReactionReceived(
        messageId: data['message_id'] ?? '',
        userId: data['user_id'] ?? '',
        reaction: data['reaction'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    // User status events
    _socket!.on(SocketEventNames.userStatusChange, (data) {
      _logger.d('User status changed');
      _emitEvent(events.UserStatusChanged(
        userId: data['user_id'] ?? '',
        isOnline: data['is_online'] ?? false,
        timestamp: DateTime.now(),
      ));
    });

    // Video call events
    _socket!.on(SocketEventNames.newVideoCall, (data) {
      _logger.d('New video call received');
      _emitEvent(events.VideoCallReceived(
        callerId: data['caller_id'] ?? '',
        callId: data['call_id'] ?? '',
        isVideo: data['is_video'] ?? true,
        timestamp: DateTime.now(),
      ));
    });

    // Login/Logout events
    _socket!.on(SocketEventNames.loggedIn, (data) {
      _logger.d('User logged in');
      _emitEvent(events.UserLoggedIn(
        userId: data['user_id'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    _socket!.on(SocketEventNames.loggedOut, (data) {
      _logger.d('User logged out');
      _emitEvent(events.UserLoggedOut(
        userId: data['user_id'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    // Notification events
    _socket!.on(SocketEventNames.messageNotification, (data) {
      _logger.d('Message notification received');
      _emitEvent(events.MessageNotificationReceived(
        messageId: data['message_id'] ?? '',
        fromUserId: data['from_user_id'] ?? '',
        message: data['message'] ?? '',
        timestamp: DateTime.now(),
      ));
    });

    // Ping/Pong events
    _socket!.on(SocketEventNames.ping, (data) {
      _logger.d('Ping received');
      _emitEvent(events.SocketPing(timestamp: DateTime.now()));
    });

    _socket!.on(SocketEventNames.pong, (data) {
      _logger.d('Pong received');
      // In Socket.IO v1.0.2, pong data is just an int (latency in ms)
      int latencyMs = 0;
      if (data is int) {
        latencyMs = data;
      } else if (data is Map && data.containsKey('latency')) {
        latencyMs = data['latency'] ?? 0;
      }
      _emitEvent(events.SocketPong(
        latency: Duration(milliseconds: latencyMs),
        timestamp: DateTime.now(),
      ));
    });
  }

  /// Update connection state and notify listeners
  void _updateConnectionState(SocketConnectionState newState) {
    if (_connectionState != newState) {
      _connectionState = newState;
      _connectionStateController.add(newState);
    }
  }

  /// Emit socket event
  void _emitEvent(events.SocketEvent event) {
    _eventController.add(event);
  }

  /// Start heartbeat timer
  void _startHeartbeat() {
    if (!_enableHeartbeat) return;

    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      if (isConnected) {
        _socket!.emit(SocketEventNames.ping);
      }
    });
  }

  /// Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Queue message for later sending
  void _queueMessage(actions.SocketAction action) {
    if (_messageQueue.length >= _maxQueuedMessages) {
      _messageQueue.removeAt(0); // Remove oldest message
    }
    _messageQueue.add(action);
    _logger.d('Message queued: ${action.runtimeType}');
  }

  /// Process queued messages
  void _processMessageQueue() {
    if (_messageQueue.isEmpty) return;

    _logger.d('Processing ${_messageQueue.length} queued messages');
    final messages = List<actions.SocketAction>.from(_messageQueue);
    _messageQueue.clear();

    for (final message in messages) {
      sendAction(message);
    }
  }

  /// Clear message queue
  void _clearMessageQueue() {
    _messageQueue.clear();
    _pendingActions.clear();
  }

  /// Test HTTP connection to socket server using simple HTTP request
  Future<void> _testHttpConnection(String socketUrl) async {
    try {
      _logger.i('🔍 Testing HTTP connection to socket server...');

      final uri = Uri.parse('$socketUrl$_defaultPath/?EIO=3&transport=polling');
      _logger.i('📍 Full URL: ${uri.toString()}');

      // Create HTTP client that accepts self-signed certificates
      final httpClient = HttpClient();
      httpClient.badCertificateCallback = (cert, host, port) {
        _logger.w('🔓 Accepting self-signed certificate for $host:$port');
        return true; // Accept all certificates (including self-signed)
      };

      final request = await httpClient.getUrl(uri);
      request.headers.set('Accept', '*/*');
      request.headers.set('User-Agent',
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36');
      request.headers.set('Accept-Language', 'en-US,en;q=0.9');

      final response =
          await request.close().timeout(const Duration(seconds: 10));
      final responseBody = await response.transform(utf8.decoder).join();

      _logger.i('📡 Response status: ${response.statusCode}');
      _logger.i('📄 Response body: $responseBody');

      if (response.statusCode == 200) {
        _logger.i('✅ HTTP connection test successful!');
      } else {
        _logger.w(
            '⚠️ HTTP connection test failed with status: ${response.statusCode}');
      }

      httpClient.close();
    } catch (e) {
      _logger.e('❌ HTTP connection test failed: $e');
      throw Exception('Socket server not reachable: $e');
    }
  }
}
