import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import '../../../../../core/params/base_params.dart';

class SavePasswordParam extends BaseParams {
  final int id;
  final String passwordCurrent;
  final String passwordNew;

  SavePasswordParam({
    required this.id,
    required this.passwordCurrent,
    required this.passwordNew,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Id": id,
        if (passwordCurrent.isNotEmptyNorNull)
          "PasswordCurrent": passwordCurrent,
        if (passwordNew.isNotEmptyNorNull) "PasswordNew": passwordNew,
      };
}
