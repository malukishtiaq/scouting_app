import 'package:scouting_app/core/common/extensions/string_extensions.dart';

class ForgotPasswordParam {
  final String? email;

  ForgotPasswordParam({
    this.email,
  });

  Map<String, dynamic> toMap() => {
        if (email.isNotEmptyNorNull) 'email': email,
      };
}
