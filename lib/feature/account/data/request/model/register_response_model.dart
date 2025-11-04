import 'package:scouting_app/core/models/base_model.dart';

import '../../../domain/entity/register_user_data_entity.dart';
import 'user_info_model.dart';

class RegisterUserDataModel extends BaseModel<RegisterUserDataEntity> {
  int userId;
  UserInfoModel userInfo;
  String accessToken;

  RegisterUserDataModel({
    required this.userId,
    required this.userInfo,
    required this.accessToken,
  });

  factory RegisterUserDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserDataModel(
        userId: json["user_id"],
        userInfo: UserInfoModel.fromMap(json["user_info"]),
        accessToken: json["access_token"],
      );

  @override
  RegisterUserDataEntity toEntity() {
    return RegisterUserDataEntity(
      userId: userId,
      userInfo: userInfo.toEntity(),
      accessToken: accessToken,
    );
  }
}
