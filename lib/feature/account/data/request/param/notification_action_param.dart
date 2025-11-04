import 'package:scouting_app/core/params/base_params.dart';

class MarkReadNotificationParam extends BaseParams {
  final List<int> notificationIds;
  final bool allRead;
  MarkReadNotificationParam({
    required this.notificationIds,
    required this.allRead,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      "NotificationIds": notificationIds,
      "AllRead": allRead,
    };
  }
}

class DeleteNotificationParam extends BaseParams {
  final List<int> notificationIds;
  final bool allDelete;
  DeleteNotificationParam({
    required this.notificationIds,
    required this.allDelete,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      "NotificationIds": notificationIds,
      "AllDelete": allDelete,
    };
  }
}
