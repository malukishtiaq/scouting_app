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
  final String userName;
  final String userAvatar;
  final String comment;
  final String createdAt;
  final int? parentCommentId;

  CommentDataEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.comment,
    required this.createdAt,
    this.parentCommentId,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        userId,
        userName,
        userAvatar,
        comment,
        createdAt,
        parentCommentId,
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

