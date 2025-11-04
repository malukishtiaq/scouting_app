import '../../../../../core/params/base_params.dart';

class UpdatePrivacySettingsParam extends BaseParams {
  final String? followPrivacy;
  final String? messagePrivacy;
  final String? friendPrivacy;
  final String? postPrivacy;
  final String? birthdayPrivacy;
  final String? confirmFollowRequests;
  final String? showMyActivities;
  final String? onlineUser;
  final String? shareMyLocation;

  UpdatePrivacySettingsParam({
    this.followPrivacy,
    this.messagePrivacy,
    this.friendPrivacy,
    this.postPrivacy,
    this.birthdayPrivacy,
    this.confirmFollowRequests,
    this.showMyActivities,
    this.onlineUser,
    this.shareMyLocation,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'server_key':
          'your_server_key', // This will be replaced with actual server key
    };

    if (followPrivacy != null) map['follow_privacy'] = followPrivacy;
    if (messagePrivacy != null) map['message_privacy'] = messagePrivacy;
    if (friendPrivacy != null) map['friend_privacy'] = friendPrivacy;
    if (postPrivacy != null) map['post_privacy'] = postPrivacy;
    if (birthdayPrivacy != null) map['birthday_privacy'] = birthdayPrivacy;
    if (confirmFollowRequests != null)
      map['confirm_follows'] = confirmFollowRequests;
    if (showMyActivities != null) map['show_activities'] = showMyActivities;
    if (onlineUser != null) map['online'] = onlineUser;
    if (shareMyLocation != null) map['share_my_location'] = shareMyLocation;

    return map;
  }
}
