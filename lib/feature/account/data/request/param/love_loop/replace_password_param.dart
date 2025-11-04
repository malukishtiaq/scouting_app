import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class ReplacePasswordParam extends BaseParams {
  final String? currentPassword;
  final String? newPassword;

  ReplacePasswordParam({
    this.currentPassword,
    this.newPassword,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (currentPassword.isNotEmptyNorNull) 'current_password': currentPassword,
        if (newPassword.isNotEmptyNorNull) 'new_password': newPassword,
      };
}
