import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class SetProParam extends BaseParams {
  final String? pro;

  SetProParam({
    this.pro,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (pro.isNotEmptyNorNull) 'pro': pro,
      };
}
