import 'package:equatable/equatable.dart';
import 'socket_constants.dart';
import 'socket_models.dart';

/// Base class for all socket events
abstract class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object?> get props => [];
}

/// Connection-related events
class SocketConnected extends SocketEvent {
  final String socketId;
  final DateTime timestamp;

  const SocketConnected({
    required this.socketId,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [socketId, timestamp];
}

class SocketDisconnected extends SocketEvent {
  final String reason;
  final DateTime timestamp;

  const SocketDisconnected({
    required this.reason,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [reason, timestamp];
}

class SocketError extends SocketEvent {
  final String error;
  final SocketErrorType errorType;
  final DateTime timestamp;

  const SocketError({
    required this.error,
    required this.errorType,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [error, errorType, timestamp];
}

class SocketReconnecting extends SocketEvent {
  final int attempt;
  final DateTime timestamp;

  const SocketReconnecting({
    required this.attempt,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [attempt, timestamp];
}

class SocketReconnected extends SocketEvent {
  final String socketId;
  final DateTime timestamp;

  const SocketReconnected({
    required this.socketId,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [socketId, timestamp];
}

class SocketReconnectFailed extends SocketEvent {
  final String reason;
  final DateTime timestamp;

  const SocketReconnectFailed({
    required this.reason,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [reason, timestamp];
}

/// Authentication events
class SocketJoined extends SocketEvent {
  final String username;
  final String accessToken;
  final DateTime timestamp;

  const SocketJoined({
    required this.username,
    required this.accessToken,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [username, accessToken, timestamp];
}

/// Chat message events
class PrivateMessageReceived extends SocketEvent {
  final SocketMessageData message;
  final DateTime timestamp;

  const PrivateMessageReceived({
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [message, timestamp];
}

class GroupMessageReceived extends SocketEvent {
  final SocketGroupMessageData message;
  final DateTime timestamp;

  const GroupMessageReceived({
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [message, timestamp];
}

class PageMessageReceived extends SocketEvent {
  final SocketPageMessageData message;
  final DateTime timestamp;

  const PageMessageReceived({
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [message, timestamp];
}

/// Typing events
class TypingEventReceived extends SocketEvent {
  final String userId;
  final String chatId;
  final bool isTyping;
  final DateTime timestamp;

  const TypingEventReceived({
    required this.userId,
    required this.chatId,
    required this.isTyping,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, chatId, isTyping, timestamp];
}

/// Recording events
class RecordingEventReceived extends SocketEvent {
  final String userId;
  final String chatId;
  final bool isRecording;
  final DateTime timestamp;

  const RecordingEventReceived({
    required this.userId,
    required this.chatId,
    required this.isRecording,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, chatId, isRecording, timestamp];
}

/// Message status events
class MessageSeenReceived extends SocketEvent {
  final String messageId;
  final String userId;
  final DateTime timestamp;

  const MessageSeenReceived({
    required this.messageId,
    required this.userId,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [messageId, userId, timestamp];
}

/// Message reaction events
class MessageReactionReceived extends SocketEvent {
  final String messageId;
  final String userId;
  final String reaction;
  final DateTime timestamp;

  const MessageReactionReceived({
    required this.messageId,
    required this.userId,
    required this.reaction,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [messageId, userId, reaction, timestamp];
}

/// User status events
class UserStatusChanged extends SocketEvent {
  final String userId;
  final bool isOnline;
  final DateTime timestamp;

  const UserStatusChanged({
    required this.userId,
    required this.isOnline,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, isOnline, timestamp];
}

/// Video call events
class VideoCallReceived extends SocketEvent {
  final String callerId;
  final String callId;
  final bool isVideo;
  final DateTime timestamp;

  const VideoCallReceived({
    required this.callerId,
    required this.callId,
    required this.isVideo,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [callerId, callId, isVideo, timestamp];
}

/// Login/Logout events
class UserLoggedIn extends SocketEvent {
  final String userId;
  final DateTime timestamp;

  const UserLoggedIn({
    required this.userId,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, timestamp];
}

class UserLoggedOut extends SocketEvent {
  final String userId;
  final DateTime timestamp;

  const UserLoggedOut({
    required this.userId,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [userId, timestamp];
}

/// Notification events
class MessageNotificationReceived extends SocketEvent {
  final String messageId;
  final String fromUserId;
  final String message;
  final DateTime timestamp;

  const MessageNotificationReceived({
    required this.messageId,
    required this.fromUserId,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [messageId, fromUserId, message, timestamp];
}

/// Ping/Pong events
class SocketPing extends SocketEvent {
  final DateTime timestamp;

  const SocketPing({
    required this.timestamp,
  });

  @override
  List<Object?> get props => [timestamp];
}

class SocketPong extends SocketEvent {
  final Duration latency;
  final DateTime timestamp;

  const SocketPong({
    required this.latency,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [latency, timestamp];
}

// Socket message data models are defined in socket_models.dart
