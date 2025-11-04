import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class SetCreditParam extends BaseParams {
  final String? credit;

  SetCreditParam({
    this.credit,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (credit.isNotEmptyNorNull) 'credit': credit,
      };
}
