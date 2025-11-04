import '../../../../../core/models/base_model.dart';
import '../../../domain/entities/user_profile_entity.dart';
import 'user_profile_model.dart';

class GetUserDataResponseModel extends BaseModel<GetUserDataResponseEntity> {
  final int apiStatus;
  final UserProfileModel userData;
  final List<UserProfileFollowerModel> followers;
  final List<UserProfileFollowerModel> following;
  final List<UserProfilePageModel> likedPages;
  final List<UserProfileGroupModel> joinedGroups;
  final List<UserProfileFollowerModel> family;

  GetUserDataResponseModel({
    required this.apiStatus,
    required this.userData,
    required this.followers,
    required this.following,
    required this.likedPages,
    required this.joinedGroups,
    required this.family,
  });

  factory GetUserDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponseModel(
      apiStatus: json['api_status'] is String
          ? int.tryParse(json['api_status']) ?? 400
          : json['api_status'] ?? 400,
      userData: UserProfileModel.fromJson(json['user_data'] ?? {}),
      followers: (json['followers'] as List<dynamic>?)
              ?.map((follower) => UserProfileFollowerModel.fromJson(follower))
              .toList() ??
          [],
      following: (json['following'] as List<dynamic>?)
              ?.map((user) => UserProfileFollowerModel.fromJson(user))
              .toList() ??
          [],
      likedPages: (json['liked_pages'] is List
          ? (json['liked_pages'] as List<dynamic>)
              .map((page) => UserProfilePageModel.fromJson(page))
              .toList()
          : []),
      joinedGroups: (json['joined_groups'] is List
          ? (json['joined_groups'] as List<dynamic>)
              .map((group) => UserProfileGroupModel.fromJson(group))
              .toList()
          : []),
      family: (json['family'] as List<dynamic>?)
              ?.map((member) => UserProfileFollowerModel.fromJson(member))
              .toList() ??
          [],
    );
  }

  @override
  GetUserDataResponseEntity toEntity() {
    return GetUserDataResponseEntity(
      apiStatus: apiStatus,
      userData: userData.toEntity(),
      followers: followers.map((f) => f.toEntity()).toList(),
      following: following.map((f) => f.toEntity()).toList(),
      likedPages: likedPages.map((p) => p.toEntity()).toList(),
      joinedGroups: joinedGroups.map((g) => g.toEntity()).toList(),
      family: family.map((f) => f.toEntity()).toList(),
    );
  }
}
