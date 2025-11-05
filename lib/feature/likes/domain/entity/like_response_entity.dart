import '../../../../core/entities/base_entity.dart';
import '../../../account/domain/entity/member_response_entity.dart';

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

/// Likes List Response Entity
/// Returns list of members who liked a post
class LikesListEntity extends BaseEntity {
  final bool success;
  final String message;
  final List<MemberDataEntity> data; // Members who liked the post

  LikesListEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}
