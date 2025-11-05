import '../../../../core/entities/base_entity.dart';

/// Comment Response Entity - successful comment creation
class CommentResponseEntity extends BaseEntity {
  final bool success;
  final String message;
  final CommentDataEntity? data;

  CommentResponseEntity({
    required this.success,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}

/// Comment Data Entity
class CommentDataEntity extends BaseEntity {
  final int id;
  final int postId;
  final int userId;
  final String content;
  final int? commentId; // Parent comment ID (null = top-level)
  final String createdAt;
  final String updatedAt;
  final List<CommentDataEntity>? replies; // Nested replies

  CommentDataEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.commentId,
    required this.createdAt,
    required this.updatedAt,
    this.replies,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        userId,
        content,
        commentId,
        createdAt,
        updatedAt,
        replies,
      ];
}

/// Comments List Response Entity
class CommentsListEntity extends BaseEntity {
  final bool success;
  final String message;
  final List<CommentDataEntity> data;

  CommentsListEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}

