import 'package:scouting_app/core/common/extensions/string_extensions.dart';

import '../../../../../core/params/base_params.dart';

class LoginParam extends BaseParams {
  final String? serverKey; // Server key for API authentication
  final String? timezone; // User's timezone
  final String? username; // Username for login
  final String? password; // User's password
  final String? androidNDeviceId; // Android device ID for notifications
  final String? androidMDeviceId; // Android device ID for messages
  final String? deviceType; // Device type (phone, web, etc.)

  LoginParam({
    this.serverKey,
    this.timezone,
    this.username,
    this.password,
    this.androidNDeviceId,
    this.androidMDeviceId,
    this.deviceType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (serverKey.isNotEmptyNorNull) 'server_key': serverKey,
        if (timezone.isNotEmptyNorNull) 'timezone': timezone,
        if (username.isNotEmptyNorNull) 'username': username,
        if (password.isNotEmptyNorNull) 'password': password,
        if (androidNDeviceId.isNotEmptyNorNull)
          'android_n_device_id': androidNDeviceId,
        if (androidMDeviceId.isNotEmptyNorNull)
          'android_m_device_id': androidMDeviceId,
        if (deviceType.isNotEmptyNorNull) 'device_type': deviceType,
      };
}
