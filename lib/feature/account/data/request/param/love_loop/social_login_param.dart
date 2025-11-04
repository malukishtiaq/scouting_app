import 'package:scouting_app/core/common/extensions/string_extensions.dart';

import '../../../../../../core/params/base_params.dart';

class SocialLoginParam extends BaseParams {
  final String? accessToken;
  final String? provider;
  final String? mobileDeviceId;

  SocialLoginParam({
    this.accessToken,
    this.provider,
    this.mobileDeviceId,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (accessToken.isNotEmptyNorNull) 'access_token': accessToken,
        if (provider.isNotEmptyNorNull) 'provider': provider,
        if (mobileDeviceId.isNotEmptyNorNull)
          'mobile_device_id': mobileDeviceId,
      };
}
