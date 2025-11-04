import '../../../../../core/models/base_model.dart';
import '../../../../../core/entities/base_entity.dart';
import 'user_profile_model.dart';

class UserPostsResponseModel extends BaseModel<BaseEntity> {
  final int apiStatus;
  final List<UserProfilePostModel> data;

  UserPostsResponseModel({
    required this.apiStatus,
    required this.data,
  });

  factory UserPostsResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPostsResponseModel(
      apiStatus: json["api_status"] ?? 400,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => UserProfilePostModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  @override
  BaseEntity toEntity() {
    return UserPostsResponseEntity();
  }
}

class UserPostsResponseEntity extends BaseEntity {
  @override
  List<Object?> get props => [];
}
