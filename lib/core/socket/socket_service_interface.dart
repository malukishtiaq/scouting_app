import 'dart:async';
import 'socket_events.dart' as events;
import 'socket_actions.dart' as actions;
import 'socket_constants.dart';
import 'socket_models.dart';

/// Socket service interface for real-time communication
abstract class ISocketService {
  /// Stream of socket events
  Stream<events.SocketEvent> get eventStream;

  /// Stream of connection state changes
  Stream<SocketConnectionState> get connectionStateStream;

  /// Current connection state
  SocketConnectionState get connectionState;

  /// Whether socket is currently connected
  bool get isConnected;

  /// Current socket ID
  String? get socketId;

  /// Whether socket is currently joining
  bool get isJoining;

  /// Connect to socket server
  Future<void> connect();

  /// Disconnect from socket server
  Future<void> disconnect();

  /// Join socket room with authentication
  Future<void> join(String username, String accessToken);

  /// Leave socket room
  Future<void> leave();

  /// Send a socket action
  Future<SocketActionResult> sendAction(actions.SocketAction action);

  /// Send private message
  Future<SocketActionResult> sendMessage(actions.SendMessageAction action);

  /// Send group message
  Future<SocketActionResult> sendGroupMessage(
      actions.SendGroupMessageAction action);

  /// Send page message
  Future<SocketActionResult> sendPageMessage(
      actions.SendPageMessageAction action);

  /// Send file message
  Future<SocketActionResult> sendMessageFile(
      actions.SendMessageFileAction action);

  /// Send group file message
  Future<SocketActionResult> sendGroupMessageFile(
      actions.SendGroupMessageFileAction action);

  /// Send page file message
  Future<SocketActionResult> sendPageMessageFile(
      actions.SendPageMessageFileAction action);

  /// Send typing indicator
  Future<SocketActionResult> sendTyping(actions.SendTypingAction action);

  /// Send stop typing indicator
  Future<SocketActionResult> sendStopTyping(
      actions.SendStopTypingAction action);

  /// Send recording indicator
  Future<SocketActionResult> sendRecording(actions.SendRecordingAction action);

  /// Send stop recording indicator
  Future<SocketActionResult> sendStopRecording(
      actions.SendStopRecordingAction action);

  /// Mark message as seen
  Future<SocketActionResult> markMessageSeen(
      actions.MarkMessageSeenAction action);

  /// Send seen messages
  Future<SocketActionResult> sendSeenMessages(
      actions.SendSeenMessagesAction action);

  /// Send message reaction
  Future<SocketActionResult> sendMessageReaction(
      actions.SendMessageReactionAction action);

  /// Create video call
  Future<SocketActionResult> createCall(actions.CreateCallAction action);

  /// Ping for last seen
  Future<SocketActionResult> pingLastSeen(actions.PingLastSeenAction action);

  /// Reconnect socket
  Future<void> reconnect();

  /// Get connection statistics
  SocketConnectionStats get connectionStats;

  /// Clear message queue
  void clearMessageQueue();

  /// Dispose resources
  void dispose();
}
