import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_follower_entity.dart';

class UserProfileFollowerModel extends BaseModel<UserProfileFollowerEntity> {
  final String? id;
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? followTime;

  UserProfileFollowerModel({
    this.id,
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.followTime,
  });

  factory UserProfileFollowerModel.fromJson(Map<String, dynamic> json) {
    return UserProfileFollowerModel(
      id: stringV(json["id"]).isEmpty ? null : stringV(json["id"]),
      userId: stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      username: stringV(json["username"]).isEmpty ? null : stringV(json["username"]),
      firstName: stringV(json["first_name"]).isEmpty ? null : stringV(json["first_name"]),
      lastName: stringV(json["last_name"]).isEmpty ? null : stringV(json["last_name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      followTime: stringV(json["follow_time"]).isEmpty ? null : stringV(json["follow_time"]),
    );
  }

  @override
  UserProfileFollowerEntity toEntity() {
    return UserProfileFollowerEntity(
      id: id,
      userId: userId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      followTime: followTime,
    );
  }
}
