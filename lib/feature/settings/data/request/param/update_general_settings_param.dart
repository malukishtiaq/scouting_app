import '../../../../../core/params/base_params.dart';

class UpdateGeneralSettingsParam extends BaseParams {
  final String? nightMode;
  final String? language;
  final String? storageConnectedMobile;
  final String? storageConnectedWiFi;
  final String? twoFactor;
  final String? chatHeads;

  UpdateGeneralSettingsParam({
    this.nightMode,
    this.language,
    this.storageConnectedMobile,
    this.storageConnectedWiFi,
    this.twoFactor,
    this.chatHeads,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'server_key':
          'your_server_key', // This will be replaced with actual server key
    };

    if (nightMode != null) map['night_mode'] = nightMode;
    if (language != null) map['language'] = language;
    if (storageConnectedMobile != null)
      map['storage_connected_mobile'] = storageConnectedMobile;
    if (storageConnectedWiFi != null)
      map['storage_connected_wifi'] = storageConnectedWiFi;
    if (twoFactor != null) map['two_factor'] = twoFactor;
    if (chatHeads != null) map['chat_heads'] = chatHeads;

    return map;
  }
}
