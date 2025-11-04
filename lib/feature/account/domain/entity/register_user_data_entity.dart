import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

class RegisterUserDataEntity extends BaseEntity {
  int userId;
  UserInfoEntity userInfo;
  String accessToken;

  RegisterUserDataEntity({
    required this.userId,
    required this.userInfo,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, userInfo, accessToken];
}
