import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_group_entity.dart';

class UserProfileGroupModel extends BaseModel<UserProfileGroupEntity> {
  final String? id;
  final String? name;
  final String? avatar;
  final String? category;
  final String? members;

  UserProfileGroupModel({
    this.id,
    this.name,
    this.avatar,
    this.category,
    this.members,
  });

  factory UserProfileGroupModel.fromJson(Map<String, dynamic> json) {
    return UserProfileGroupModel(
      id: stringV(json["id"]).isEmpty ? null : stringV(json["id"]),
      name: stringV(json["name"]).isEmpty ? null : stringV(json["name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      category: stringV(json["category"]).isEmpty ? null : stringV(json["category"]),
      members: stringV(json["members"]).isEmpty ? null : stringV(json["members"]),
    );
  }

  @override
  UserProfileGroupEntity toEntity() {
    return UserProfileGroupEntity(
      id: id,
      name: name,
      avatar: avatar,
      category: category,
      members: members,
    );
  }
}
