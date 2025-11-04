import 'package:scouting_app/core/params/base_params.dart';

class IdParam extends BaseParams {
  final int id;

  IdParam(this.id);

  @override
  Map<String, dynamic> toMap() => {'id': id};
}
