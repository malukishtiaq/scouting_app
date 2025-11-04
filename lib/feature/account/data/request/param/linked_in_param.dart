import 'package:scouting_app/core/params/base_params.dart';

class LinkedInParam extends BaseParams {
  final String? accessToken;
  final String? email;

  LinkedInParam({
    this.accessToken,
    this.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (accessToken != null) 'access_token': accessToken,
        if (email != null) 'email': email,
      };
}
