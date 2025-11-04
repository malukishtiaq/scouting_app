import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_entity.dart';

class UserProfileReactionModel extends BaseModel<UserProfileReactionEntity> {
  final String? reaction;
  final String? count;

  UserProfileReactionModel({
    this.reaction,
    this.count,
  });

  factory UserProfileReactionModel.fromJson(Map<String, dynamic> json) {
    return UserProfileReactionModel(
      reaction:
          stringV(json["reaction"]).isEmpty ? null : stringV(json["reaction"]),
      count: stringV(json["count"]).isEmpty ? null : stringV(json["count"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reaction": reaction,
      "count": count,
    };
  }

  @override
  UserProfileReactionEntity toEntity() {
    return UserProfileReactionEntity(
      reaction: reaction,
      count: count,
    );
  }
}
