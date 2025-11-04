import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_entity.dart';

class UserProfilePublisherModel extends BaseModel<UserProfilePublisherEntity> {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? verified;

  UserProfilePublisherModel({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.verified,
  });

  factory UserProfilePublisherModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePublisherModel(
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      username:
          stringV(json["username"]).isEmpty ? null : stringV(json["username"]),
      firstName: stringV(json["first_name"]).isEmpty
          ? null
          : stringV(json["first_name"]),
      lastName: stringV(json["last_name"]).isEmpty
          ? null
          : stringV(json["last_name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      verified:
          stringV(json["verified"]).isEmpty ? null : stringV(json["verified"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
      "verified": verified,
    };
  }

  @override
  UserProfilePublisherEntity toEntity() {
    return UserProfilePublisherEntity(
      userId: userId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      verified: verified,
    );
  }
}
