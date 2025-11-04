// Socket connection states and error types are defined in socket_constants.dart
// SocketEvent and SocketAction are defined in socket_events.dart and socket_actions.dart respectively

/// Socket connection statistics
class SocketConnectionStats {
  final int totalConnections;
  final int successfulConnections;
  final int failedConnections;
  final int totalMessagesSent;
  final int totalMessagesReceived;
  final int totalErrors;
  final DateTime? lastConnected;
  final DateTime? lastDisconnected;
  final String? lastError;

  const SocketConnectionStats({
    required this.totalConnections,
    required this.successfulConnections,
    required this.failedConnections,
    required this.totalMessagesSent,
    required this.totalMessagesReceived,
    required this.totalErrors,
    this.lastConnected,
    this.lastDisconnected,
    this.lastError,
  });

  /// Create initial stats
  factory SocketConnectionStats.initial() {
    return const SocketConnectionStats(
      totalConnections: 0,
      successfulConnections: 0,
      failedConnections: 0,
      totalMessagesSent: 0,
      totalMessagesReceived: 0,
      totalErrors: 0,
    );
  }

  /// Copy with new values
  SocketConnectionStats copyWith({
    int? totalConnections,
    int? successfulConnections,
    int? failedConnections,
    int? totalMessagesSent,
    int? totalMessagesReceived,
    int? totalErrors,
    DateTime? lastConnected,
    DateTime? lastDisconnected,
    String? lastError,
  }) {
    return SocketConnectionStats(
      totalConnections: totalConnections ?? this.totalConnections,
      successfulConnections:
          successfulConnections ?? this.successfulConnections,
      failedConnections: failedConnections ?? this.failedConnections,
      totalMessagesSent: totalMessagesSent ?? this.totalMessagesSent,
      totalMessagesReceived:
          totalMessagesReceived ?? this.totalMessagesReceived,
      totalErrors: totalErrors ?? this.totalErrors,
      lastConnected: lastConnected ?? this.lastConnected,
      lastDisconnected: lastDisconnected ?? this.lastDisconnected,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  String toString() {
    return 'SocketConnectionStats(totalConnections: $totalConnections, '
        'successfulConnections: $successfulConnections, failedConnections: $failedConnections, '
        'totalMessagesSent: $totalMessagesSent, totalMessagesReceived: $totalMessagesReceived, '
        'totalErrors: $totalErrors, lastConnected: $lastConnected, '
        'lastDisconnected: $lastDisconnected, lastError: $lastError)';
  }
}

/// Socket action result
class SocketActionResult {
  final bool success;
  final String? error;
  final Map<String, dynamic>? data;

  const SocketActionResult({
    required this.success,
    this.error,
    this.data,
  });

  /// Create success result
  factory SocketActionResult.success([Map<String, dynamic>? data]) {
    return SocketActionResult(
      success: true,
      data: data,
    );
  }

  /// Create error result
  factory SocketActionResult.error(String error) {
    return SocketActionResult(
      success: false,
      error: error,
    );
  }

  @override
  String toString() {
    return 'SocketActionResult(success: $success, error: $error, data: $data)';
  }
}

/// Socket message data
class SocketMessageData {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String message;
  final String? replyId;
  final String? color;
  final String? messageHashId;
  final String? storyId;
  final double? latitude;
  final double? longitude;
  final DateTime timestamp;
  final bool isSeen;
  final String? reaction;

  const SocketMessageData({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.message,
    this.replyId,
    this.color,
    this.messageHashId,
    this.storyId,
    this.latitude,
    this.longitude,
    required this.timestamp,
    required this.isSeen,
    this.reaction,
  });

  /// Create from JSON
  factory SocketMessageData.fromJson(Map<String, dynamic> json) {
    return SocketMessageData(
      id: json['id']?.toString() ?? '',
      fromUserId: json['from_user_id']?.toString() ?? '',
      toUserId: json['to_user_id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      replyId: json['reply_id']?.toString(),
      color: json['color']?.toString(),
      messageHashId: json['message_hash_id']?.toString(),
      storyId: json['story_id']?.toString(),
      latitude: _parseDouble(json['lat']),
      longitude: _parseDouble(json['lng']),
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      isSeen: json['is_seen'] == true,
      reaction: json['reaction']?.toString(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
      'message': message,
      'reply_id': replyId,
      'color': color,
      'message_hash_id': messageHashId,
      'story_id': storyId,
      'lat': latitude,
      'lng': longitude,
      'timestamp': timestamp.toIso8601String(),
      'is_seen': isSeen,
      'reaction': reaction,
    };
  }

  @override
  String toString() {
    return 'SocketMessageData(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, '
        'message: $message, replyId: $replyId, color: $color, messageHashId: $messageHashId, '
        'storyId: $storyId, latitude: $latitude, longitude: $longitude, '
        'timestamp: $timestamp, isSeen: $isSeen, reaction: $reaction)';
  }

  /// Helper method to safely parse double values from JSON
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      if (value.isEmpty) return null;
      return double.tryParse(value);
    }
    return null;
  }
}

/// Socket group message data
class SocketGroupMessageData {
  final String id;
  final String groupId;
  final String fromUserId;
  final String message;
  final String? replyId;
  final String? messageHashId;
  final DateTime timestamp;
  final bool isSeen;
  final String? reaction;

  const SocketGroupMessageData({
    required this.id,
    required this.groupId,
    required this.fromUserId,
    required this.message,
    this.replyId,
    this.messageHashId,
    required this.timestamp,
    required this.isSeen,
    this.reaction,
  });

  /// Create from JSON
  factory SocketGroupMessageData.fromJson(Map<String, dynamic> json) {
    return SocketGroupMessageData(
      id: json['id']?.toString() ?? '',
      groupId: json['group_id']?.toString() ?? '',
      fromUserId: json['from_user_id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      replyId: json['reply_id']?.toString(),
      messageHashId: json['message_hash_id']?.toString(),
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      isSeen: json['is_seen'] == true,
      reaction: json['reaction']?.toString(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'from_user_id': fromUserId,
      'message': message,
      'reply_id': replyId,
      'message_hash_id': messageHashId,
      'timestamp': timestamp.toIso8601String(),
      'is_seen': isSeen,
      'reaction': reaction,
    };
  }

  @override
  String toString() {
    return 'SocketGroupMessageData(id: $id, groupId: $groupId, fromUserId: $fromUserId, '
        'message: $message, replyId: $replyId, messageHashId: $messageHashId, '
        'timestamp: $timestamp, isSeen: $isSeen, reaction: $reaction)';
  }
}

/// Socket page message data
class SocketPageMessageData {
  final String id;
  final String pageId;
  final String toUserId;
  final String fromUserId;
  final String message;
  final String? replyId;
  final String? messageHashId;
  final DateTime timestamp;
  final bool isSeen;
  final String? reaction;

  const SocketPageMessageData({
    required this.id,
    required this.pageId,
    required this.toUserId,
    required this.fromUserId,
    required this.message,
    this.replyId,
    this.messageHashId,
    required this.timestamp,
    required this.isSeen,
    this.reaction,
  });

  /// Create from JSON
  factory SocketPageMessageData.fromJson(Map<String, dynamic> json) {
    return SocketPageMessageData(
      id: json['id']?.toString() ?? '',
      pageId: json['page_id']?.toString() ?? '',
      toUserId: json['to_user_id']?.toString() ?? '',
      fromUserId: json['from_user_id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      replyId: json['reply_id']?.toString(),
      messageHashId: json['message_hash_id']?.toString(),
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      isSeen: json['is_seen'] == true,
      reaction: json['reaction']?.toString(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page_id': pageId,
      'to_user_id': toUserId,
      'from_user_id': fromUserId,
      'message': message,
      'reply_id': replyId,
      'message_hash_id': messageHashId,
      'timestamp': timestamp.toIso8601String(),
      'is_seen': isSeen,
      'reaction': reaction,
    };
  }

  @override
  String toString() {
    return 'SocketPageMessageData(id: $id, pageId: $pageId, toUserId: $toUserId, '
        'fromUserId: $fromUserId, message: $message, replyId: $replyId, '
        'messageHashId: $messageHashId, timestamp: $timestamp, isSeen: $isSeen, '
        'reaction: $reaction)';
  }
}

// Socket Events and Actions are defined in socket_events.dart and socket_actions.dart respectively
