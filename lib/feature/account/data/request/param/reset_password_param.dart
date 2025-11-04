import 'package:scouting_app/core/common/extensions/string_extensions.dart';

import '../../../../../core/params/base_params.dart';

class ResetPasswordParam extends BaseParams {
  final String? currentPassword;
  final String? newPassword;
  final String? otp;
  final int? id;
  ResetPasswordParam({
    this.currentPassword,
    this.newPassword,
    this.otp,
    this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (newPassword != null && newPassword.isNotEmptyNorNull)
        "PasswordNew": newPassword,
      if (currentPassword != null && currentPassword.isNotEmptyNorNull)
        "PasswordCurrent": currentPassword,
      if (otp != null && otp.isNotEmptyNorNull) "Otp": otp,
      if (id != null) "Id": id,
    };
  }
}
