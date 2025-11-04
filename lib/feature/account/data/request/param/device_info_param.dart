import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class DeviceInfoParam extends BaseParams {
  final String? deviceId;
  final String? platform;
  final String? version;
  final String? build;

  DeviceInfoParam({
    this.deviceId,
    this.platform,
    this.version,
    this.build,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (deviceId.isNotEmptyNorNull) 'device_id': deviceId,
        if (platform.isNotEmptyNorNull) 'platform': platform,
        if (version.isNotEmptyNorNull) 'version': version,
        if (build.isNotEmptyNorNull) 'build': build,
      };
}
