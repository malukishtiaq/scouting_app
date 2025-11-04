import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class ResendEmailParam extends BaseParams {
  final String? email;

  ResendEmailParam({
    this.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (email.isNotEmptyNorNull) 'email': email,
      };
}
