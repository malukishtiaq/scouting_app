import '../../../../core/entities/base_entity.dart';

/// Like Response Entity - successful like toggle
class LikeResponseEntity extends BaseEntity {
  final bool success;
  final String message;
  final bool? isLiked; // Indicates if the post is now liked (true) or unliked (false)

  LikeResponseEntity({
    required this.success,
    required this.message,
    this.isLiked,
  });

  @override
  List<Object?> get props => [success, message, isLiked];
}

/// Like Data Entity
class LikeDataEntity extends BaseEntity {
  final int id;
  final int postId;
  final int userId;
  final String userName;
  final String userAvatar;
  final String createdAt;

  LikeDataEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        userId,
        userName,
        userAvatar,
        createdAt,
      ];
}

/// Likes List Response Entity
class LikesListEntity extends BaseEntity {
  final bool success;
  final String message;
  final List<LikeDataEntity> data;

  LikesListEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}

