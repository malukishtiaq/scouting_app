import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import '../../../../../core/params/base_params.dart';

class TwoFactorParam extends BaseParams {
  final String? serverKey; // Server key for API authentication
  final String? userId; // User ID for verification
  final String? code; // Verification code
  final String? androidNDeviceId; // Android device ID
  final String? androidMDeviceId; // Android device message ID
  final String? deviceType; // Device type (phone, web, etc.)

  TwoFactorParam({
    this.serverKey,
    this.userId,
    this.code,
    this.androidNDeviceId,
    this.androidMDeviceId,
    this.deviceType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (serverKey.isNotEmptyNorNull) 'server_key': serverKey,
        if (userId.isNotEmptyNorNull) 'user_id': userId,
        if (code.isNotEmptyNorNull) 'code': code,
        if (androidNDeviceId.isNotEmptyNorNull)
          'android_n_device_id': androidNDeviceId,
        if (androidMDeviceId.isNotEmptyNorNull)
          'android_m_device_id': androidMDeviceId,
        if (deviceType.isNotEmptyNorNull) 'device_type': deviceType,
      };
}
