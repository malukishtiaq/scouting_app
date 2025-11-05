import '../../../../core/entities/base_entity.dart';
import 'package:scouting_app/feature/account/domain/entity/member_response_entity.dart';

/// Authentication Response Entity (for Register and Login endpoints)
class AuthResponseEntity extends BaseEntity {
  final bool success;
  final String message;
  final AuthDataEntity data;

  AuthResponseEntity({
    required this.success,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [success, message, data];
}

/// Authentication Data Entity (contains user and token info)
class AuthDataEntity extends BaseEntity {
  final MemberDataEntity user;
  final String tokenType;
  final String token;

  AuthDataEntity({
    required this.user,
    required this.tokenType,
    required this.token,
  });

  @override
  List<Object?> get props => [user, tokenType, token];
}

