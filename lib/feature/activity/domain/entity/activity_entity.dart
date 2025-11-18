import '../../../../core/entities/base_entity.dart';

/// Activity Entity
class ActivityEntity extends BaseEntity {
  final int id;
  final String type; // connection_request, post_liked, new_follower, game_notification
  final String title;
  final String? description;
  final String timestamp; // e.g., "1d", "2d", "3d"
  final String? avatarUrl;
  final String? iconName; // heart, settings, etc.
  final int? userId; // For connection requests
  final String? userName; // For connection requests
  final bool hasActions; // Whether to show Accept/Decline buttons
  final bool isRead;

  ActivityEntity({
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

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        timestamp,
        avatarUrl,
        iconName,
        userId,
        userName,
        hasActions,
        isRead,
      ];
}

/// Activity List Response Entity
class ActivityListEntity extends BaseEntity {
  final bool success;
  final String message;
  final List<ActivityEntity> activities;
  final int total;
  final int currentPage;
  final int lastPage;

  ActivityListEntity({
    required this.success,
    required this.message,
    required this.activities,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        activities,
        total,
        currentPage,
        lastPage,
      ];
}

