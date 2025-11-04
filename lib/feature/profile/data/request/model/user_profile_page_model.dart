import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_page_entity.dart';

class UserProfilePageModel extends BaseModel<UserProfilePageEntity> {
  final String? id;
  final String? name;
  final String? avatar;
  final String? category;
  final String? likes;

  UserProfilePageModel({
    this.id,
    this.name,
    this.avatar,
    this.category,
    this.likes,
  });

  factory UserProfilePageModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePageModel(
      id: stringV(json["id"]).isEmpty ? null : stringV(json["id"]),
      name: stringV(json["name"]).isEmpty ? null : stringV(json["name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      category: stringV(json["category"]).isEmpty ? null : stringV(json["category"]),
      likes: stringV(json["likes"]).isEmpty ? null : stringV(json["likes"]),
    );
  }

  @override
  UserProfilePageEntity toEntity() {
    return UserProfilePageEntity(
      id: id,
      name: name,
      avatar: avatar,
      category: category,
      likes: likes,
    );
  }
}
