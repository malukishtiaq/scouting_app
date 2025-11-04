import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class DeleteAccountParam extends BaseParams {
  final String? password;
  final String? reason;

  DeleteAccountParam({
    this.password,
    this.reason,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (password.isNotEmptyNorNull) 'password': password,
        if (reason.isNotEmptyNorNull) 'reason': reason,
      };
}
