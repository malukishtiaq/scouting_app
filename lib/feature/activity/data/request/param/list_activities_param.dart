import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for listing activities
class ListActivitiesParam extends BaseParams {
  final int page;
  final int perPage;
  final String? type; // connection_request, post_liked, new_follower, game_notification
  final bool? unreadOnly;

  ListActivitiesParam({
    this.page = 1,
    this.perPage = 20,
    this.type,
    this.unreadOnly,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'per_page': perPage,
      if (type != null) 'type': type,
      if (unreadOnly != null) 'unread_only': unreadOnly,
    };
  }
}

