import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/domain/entity/auth_response_entity.dart';
import 'package:scouting_app/feature/account/data/request/model/member_response_model.dart';

/// Authentication Response Model (for Register and Login endpoints)
class AuthResponseModel extends BaseModel<AuthResponseEntity> {
  final bool success;
  final String message;
  final AuthDataModel data;

  AuthResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AuthDataModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }

  @override
  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      success: success,
      message: message,
      data: data.toEntity(),
    );
  }
}

/// Authentication Data Model (contains user and token info)
class AuthDataModel extends BaseModel<AuthDataEntity> {
  final MemberDataModel user;
  final String tokenType;
  final String token;

  AuthDataModel({
    required this.user,
    required this.tokenType,
    required this.token,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      user: MemberDataModel.fromJson(json['user'] ?? {}),
      tokenType: json['token_type'] ?? 'Bearer',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token_type': tokenType,
      'token': token,
    };
  }

  @override
  AuthDataEntity toEntity() {
    return AuthDataEntity(
      user: user.toEntity(),
      tokenType: tokenType,
      token: token,
    );
  }
}

