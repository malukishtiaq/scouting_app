import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class ActivateAccountParam extends BaseParams {
  final String? email;
  final String? code;

  ActivateAccountParam({
    this.email,
    this.code,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (email.isNotEmptyNorNull) 'email': email,
        if (code.isNotEmptyNorNull) 'code': code,
      };
}
