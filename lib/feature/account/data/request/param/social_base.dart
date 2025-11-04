import 'package:scouting_app/core/params/base_params.dart';

abstract class SocialBase extends BaseParams {
  final String email;
  SocialBase({required this.email, super.cancelToken});

  @override
  Map<String, dynamic> toMap();
}
