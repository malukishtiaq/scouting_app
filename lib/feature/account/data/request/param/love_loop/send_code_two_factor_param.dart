import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class SendCodeTwoFactorParam extends BaseParams {
  final String? email;

  SendCodeTwoFactorParam({
    this.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (email.isNotEmptyNorNull) 'email': email,
      };
}
