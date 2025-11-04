import 'package:equatable/equatable.dart';
import 'socket_models.dart';

/// Base class for all socket actions
abstract class SocketAction extends Equatable {
  const SocketAction();

  @override
  List<Object?> get props => [];
}

/// Authentication actions
class JoinSocketAction extends SocketAction {
  final String username;
  final String accessToken;

  const JoinSocketAction({
    required this.username,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [username, accessToken];
}

/// Message sending actions
class SendMessageAction extends SocketAction {
  final String toId;
  final String fromId; // Required: sender's access token
  final String username; // Required: sender's username
  final String message;
  final String? replyId;
  final String? color;
  final String? messageHashId;
  final String? storyId;
  final String? latitude;
  final String? longitude;
  // Additional user data to prevent server errors
  final String? userAvatar; // User's avatar URL
  final String? userName; // User's display name
  final String? userId; // User's ID

  const SendMessageAction({
    required this.toId,
    required this.fromId,
    required this.username,
    required this.message,
    this.replyId,
    this.color,
    this.messageHashId,
    this.storyId,
    this.latitude,
    this.longitude,
    this.userAvatar,
    this.userName,
    this.userId,
  });

  @override
  List<Object?> get props => [
        toId,
        fromId,
        username,
        message,
        replyId,
        color,
        messageHashId,
        storyId,
        latitude,
        longitude,
        userAvatar,
        userName,
        userId,
      ];
}

class SendGroupMessageAction extends SocketAction {
  final String groupId;
  final String fromId; // Required: sender's access token
  final String username; // Required: sender's username
  final String message;
  final String? replyId;
  final String? messageHashId;
  // Additional user data to prevent server errors
  final String? userAvatar; // User's avatar URL
  final String? userName; // User's display name
  final String? userId; // User's ID

  const SendGroupMessageAction({
    required this.groupId,
    required this.fromId,
    required this.username,
    required this.message,
    this.replyId,
    this.messageHashId,
    this.userAvatar,
    this.userName,
    this.userId,
  });

  @override
  List<Object?> get props => [
        groupId,
        fromId,
        username,
        message,
        replyId,
        messageHashId,
        userAvatar,
        userName,
        userId,
      ];
}

class SendPageMessageAction extends SocketAction {
  final String pageId;
  final String toId;
  final String fromId; // Required: sender's access token
  final String username; // Required: sender's username
  final String message;
  final String? replyId;
  final String? messageHashId;
  // Additional user data to prevent server errors
  final String? userAvatar; // User's avatar URL
  final String? userName; // User's display name
  final String? userId; // User's ID

  const SendPageMessageAction({
    required this.pageId,
    required this.toId,
    required this.fromId,
    required this.username,
    required this.message,
    this.replyId,
    this.messageHashId,
    this.userAvatar,
    this.userName,
    this.userId,
  });

  @override
  List<Object?> get props => [
        pageId,
        toId,
        fromId,
        username,
        message,
        replyId,
        messageHashId,
        userAvatar,
        userName,
        userId,
      ];
}

/// File message actions
class SendMessageFileAction extends SocketAction {
  final String toId;
  final String messageId;
  final String? replyId;
  final String? storyId;

  const SendMessageFileAction({
    required this.toId,
    required this.messageId,
    this.replyId,
    this.storyId,
  });

  @override
  List<Object?> get props => [toId, messageId, replyId, storyId];
}

class SendGroupMessageFileAction extends SocketAction {
  final String groupId;
  final String messageId;
  final String? replyId;

  const SendGroupMessageFileAction({
    required this.groupId,
    required this.messageId,
    this.replyId,
  });

  @override
  List<Object?> get props => [groupId, messageId, replyId];
}

class SendPageMessageFileAction extends SocketAction {
  final String pageId;
  final String toId;
  final String messageId;
  final String? replyId;

  const SendPageMessageFileAction({
    required this.pageId,
    required this.toId,
    required this.messageId,
    this.replyId,
  });

  @override
  List<Object?> get props => [pageId, toId, messageId, replyId];
}

/// Typing actions
class SendTypingAction extends SocketAction {
  final String toId;
  final bool isTyping;

  const SendTypingAction({
    required this.toId,
    required this.isTyping,
  });

  @override
  List<Object?> get props => [toId, isTyping];
}

class SendStopTypingAction extends SocketAction {
  final String toId;

  const SendStopTypingAction({
    required this.toId,
  });

  @override
  List<Object?> get props => [toId];
}

/// Recording actions
class SendRecordingAction extends SocketAction {
  final String toId;
  final bool isRecording;

  const SendRecordingAction({
    required this.toId,
    required this.isRecording,
  });

  @override
  List<Object?> get props => [toId, isRecording];
}

class SendStopRecordingAction extends SocketAction {
  final String toId;

  const SendStopRecordingAction({
    required this.toId,
  });

  @override
  List<Object?> get props => [toId];
}

/// Message status actions
class MarkMessageSeenAction extends SocketAction {
  final String messageId;
  final String toId;

  const MarkMessageSeenAction({
    required this.messageId,
    required this.toId,
  });

  @override
  List<Object?> get props => [messageId, toId];
}

class SendSeenMessagesAction extends SocketAction {
  final String toId;
  final String accessToken;
  final String fromUserId;

  const SendSeenMessagesAction({
    required this.toId,
    required this.accessToken,
    required this.fromUserId,
  });

  @override
  List<Object?> get props => [toId, accessToken, fromUserId];
}

/// Message reaction actions
class SendMessageReactionAction extends SocketAction {
  final String messageId;
  final String reaction;
  final String accessToken;

  const SendMessageReactionAction({
    required this.messageId,
    required this.reaction,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [messageId, reaction, accessToken];
}

/// Video call actions
class CreateCallAction extends SocketAction {
  final String recipientId;
  final bool isVideo;

  const CreateCallAction({
    required this.recipientId,
    required this.isVideo,
  });

  @override
  List<Object?> get props => [recipientId, isVideo];
}

/// Last seen actions
class PingLastSeenAction extends SocketAction {
  final String accessToken;

  const PingLastSeenAction({
    required this.accessToken,
  });

  @override
  List<Object?> get props => [accessToken];
}

/// Connection actions
class ConnectSocketAction extends SocketAction {
  const ConnectSocketAction();
}

class DisconnectSocketAction extends SocketAction {
  const DisconnectSocketAction();
}

class ReconnectSocketAction extends SocketAction {
  const ReconnectSocketAction();
}

// SocketActionResult is defined in socket_models.dart

/// Socket action handler interface
abstract class ISocketActionHandler {
  Future<SocketActionResult> handleAction(SocketAction action);
}

/// Socket action handler for different action types
class SocketActionHandler implements ISocketActionHandler {
  final Map<Type, Future<SocketActionResult> Function(SocketAction)> _handlers;

  SocketActionHandler(this._handlers);

  @override
  Future<SocketActionResult> handleAction(SocketAction action) async {
    final handler = _handlers[action.runtimeType];
    if (handler != null) {
      return await handler(action);
    }
    return SocketActionResult.error(
        'No handler found for action type: ${action.runtimeType}');
  }

  /// Register a handler for a specific action type
  void registerHandler<T extends SocketAction>(
    Future<SocketActionResult> Function(T) handler,
  ) {
    _handlers[T] = (action) => handler(action as T);
  }
}
