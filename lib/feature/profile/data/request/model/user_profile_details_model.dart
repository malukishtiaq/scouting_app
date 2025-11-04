import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_entity.dart';

class UserProfileDetailsModel extends BaseModel<UserProfileDetailsEntity> {
  final int? followersCount;
  final int? followingCount;
  final int? postCount;
  final int? likesCount;
  final int? groupsCount;

  UserProfileDetailsModel({
    this.followersCount,
    this.followingCount,
    this.postCount,
    this.likesCount,
    this.groupsCount,
  });

  factory UserProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDetailsModel(
      followersCount: numV<int>(json["followers_count"]),
      followingCount: numV<int>(json["following_count"]),
      postCount: numV<int>(json["post_count"]),
      likesCount: numV<int>(json["likes_count"]),
      groupsCount: numV<int>(json["groups_count"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "followers_count": followersCount,
      "following_count": followingCount,
      "post_count": postCount,
      "likes_count": likesCount,
      "groups_count": groupsCount,
    };
  }

  @override
  UserProfileDetailsEntity toEntity() {
    return UserProfileDetailsEntity(
      followersCount: followersCount,
      followingCount: followingCount,
      postCount: postCount,
      likesCount: likesCount,
      groupsCount: groupsCount,
    );
  }
}
