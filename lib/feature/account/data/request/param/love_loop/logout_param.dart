import 'package:scouting_app/core/params/base_params.dart';

import '../../../../../../core/providers/session_data.dart';
import '../../../../../../di/service_locator.dart';

class LogoutParam extends BaseParams {
  @override
  Map<String, dynamic> toMap() => {
        'access_token': getIt<SessionData>().token,
      };
}
