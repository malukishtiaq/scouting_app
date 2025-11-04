import '../../../../core/entities/base_entity.dart';
import 'user_profile_entity.dart';
import 'user_profile_follower_entity.dart' as follower_entity;
import 'user_profile_page_entity.dart' as page_entity;
import 'user_profile_group_entity.dart' as group_entity;

class GetUserDataResponseEntity extends BaseEntity {
  final int apiStatus;
  final UserProfileEntity userData;
  final List<follower_entity.UserProfileFollowerEntity> followers;
  final List<follower_entity.UserProfileFollowerEntity> following;
  final List<page_entity.UserProfilePageEntity> likedPages;
  final List<group_entity.UserProfileGroupEntity> joinedGroups;
  final List<follower_entity.UserProfileFollowerEntity> family;

  GetUserDataResponseEntity({
    required this.apiStatus,
    required this.userData,
    required this.followers,
    required this.following,
    required this.likedPages,
    required this.joinedGroups,
    required this.family,
  });

  @override
  List<Object?> get props => [
        apiStatus,
        userData,
        followers,
        following,
        likedPages,
        joinedGroups,
        family,
      ];

  bool get isSuccess => apiStatus == 200;
  bool get isError => apiStatus != 200;
}
