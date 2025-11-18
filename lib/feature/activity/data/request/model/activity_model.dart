import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';

/// Activity Model
class ActivityModel extends BaseModel<ActivityEntity> {
  final int id;
  final String type;
  final String title;
  final String? description;
  final String timestamp;
  final String? avatarUrl;
  final String? iconName;
  final int? userId;
  final String? userName;
  final bool hasActions;
  final bool isRead;

  ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    required this.timestamp,
    this.avatarUrl,
    this.iconName,
    this.userId,
    this.userName,
    this.hasActions = false,
    this.isRead = false,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      timestamp: json['timestamp'] ?? '',
      avatarUrl: json['avatar_url'],
      iconName: json['icon_name'],
      userId: json['user_id'],
      userName: json['user_name'],
      hasActions: json['has_actions'] ?? false,
      isRead: json['is_read'] ?? false,
    );
  }

  @override
  ActivityEntity toEntity() {
    return ActivityEntity(
      id: id,
      type: type,
      title: title,
      description: description,
      timestamp: timestamp,
      avatarUrl: avatarUrl,
      iconName: iconName,
      userId: userId,
      userName: userName,
      hasActions: hasActions,
      isRead: isRead,
    );
  }
}

/// Activity List Response Model
class ActivityListModel extends BaseModel<ActivityListEntity> {
  final bool success;
  final String message;
  final List<ActivityModel> activities;
  final int total;
  final int currentPage;
  final int lastPage;

  ActivityListModel({
    required this.success,
    required this.message,
    required this.activities,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory ActivityListModel.fromJson(Map<String, dynamic> json) {
    return ActivityListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      activities: (json['data'] as List<dynamic>?)
              ?.map((activity) => ActivityModel.fromJson(activity))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }

  @override
  ActivityListEntity toEntity() {
    return ActivityListEntity(
      success: success,
      message: message,
      activities: activities.map((model) => model.toEntity()).toList(),
      total: total,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }
}

