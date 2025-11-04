import '../../../../../core/params/base_params.dart';

class UpdateNotificationSettingsParam extends BaseParams {
  final String? eLiked;
  final String? eCommented;
  final String? eShared;
  final String? eFollowed;
  final String? eLikedPage;
  final String? eVisited;
  final String? eMentioned;
  final String? eJoinedGroup;
  final String? eAccepted;
  final String? eProfileWallPost;
  final String? eMemory;
  final String? notifications;
  final String? soundControl;

  UpdateNotificationSettingsParam({
    this.eLiked,
    this.eCommented,
    this.eShared,
    this.eFollowed,
    this.eLikedPage,
    this.eVisited,
    this.eMentioned,
    this.eJoinedGroup,
    this.eAccepted,
    this.eProfileWallPost,
    this.eMemory,
    this.notifications,
    this.soundControl,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'server_key':
          'your_server_key', // This will be replaced with actual server key
    };

    if (eLiked != null) map['e_liked'] = eLiked;
    if (eCommented != null) map['e_commented'] = eCommented;
    if (eShared != null) map['e_shared'] = eShared;
    if (eFollowed != null) map['e_followed'] = eFollowed;
    if (eLikedPage != null) map['e_liked_page'] = eLikedPage;
    if (eVisited != null) map['e_visited'] = eVisited;
    if (eMentioned != null) map['e_mentioned'] = eMentioned;
    if (eJoinedGroup != null) map['e_joined_group'] = eJoinedGroup;
    if (eAccepted != null) map['e_accepted'] = eAccepted;
    if (eProfileWallPost != null) map['e_profile_wall_post'] = eProfileWallPost;
    if (eMemory != null) map['e_memory'] = eMemory;
    if (notifications != null) map['notifications'] = notifications;
    if (soundControl != null) map['sound_control'] = soundControl;

    return map;
  }
}
