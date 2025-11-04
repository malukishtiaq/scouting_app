import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class TwoFactorParam extends BaseParams {
  final String? userId;
  final String? code;
  final String? androidNDeviceId; // Android device ID for notifications
  final String? androidMDeviceId; // Android device ID for messages
  final String? deviceType; // Device type

  TwoFactorParam({
    this.userId,
    this.code,
    this.androidNDeviceId,
    this.androidMDeviceId,
    this.deviceType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (userId.isNotEmptyNorNull) 'user_id': userId,
        if (code.isNotEmptyNorNull) 'code': code,
        if (androidNDeviceId.isNotEmptyNorNull)
          'android_n_device_id': androidNDeviceId,
        if (androidMDeviceId.isNotEmptyNorNull)
          'android_m_device_id': androidMDeviceId,
        if (deviceType.isNotEmptyNorNull) 'device_type': deviceType,
      };
}
