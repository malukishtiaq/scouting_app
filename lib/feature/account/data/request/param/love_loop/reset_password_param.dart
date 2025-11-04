import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class ResetPasswordParam extends BaseParams {
  final String? email;
  final String? code;
  final String? newPassword;

  ResetPasswordParam({
    this.email,
    this.code,
    this.newPassword,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (email.isNotEmptyNorNull) 'email': email,
        if (code.isNotEmptyNorNull) 'code': code,
        if (newPassword.isNotEmptyNorNull) 'new_password': newPassword,
      };
}
