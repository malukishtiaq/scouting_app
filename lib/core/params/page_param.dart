import 'package:scouting_app/core/params/base_params.dart';

import '../../di/service_locator.dart';
import '../providers/session_data.dart';

class PageParam extends BaseParams {
  final String? limit;
  final String? offset;
  final String? mobileDeviceId;

  PageParam({
    this.limit,
    this.offset,
    this.mobileDeviceId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (mobileDeviceId != null)
        'mobile_device_id':
            "be12c3e3-36fe-4bce-82d0-75688cdff18f", //mobileDeviceId,
      'access_token': getIt<SessionData>().token ?? '',
    };
  }
}
