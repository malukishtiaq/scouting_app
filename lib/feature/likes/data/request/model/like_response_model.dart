import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/likes/domain/entity/like_response_entity.dart';

/// Like Response Model - successful like toggle
class LikeResponseModel extends BaseModel<LikeResponseEntity> {
  final bool success;
  final String message;
  final bool? isLiked;

  LikeResponseModel({
    required this.success,
    required this.message,
    this.isLiked,
  });

  factory LikeResponseModel.fromJson(Map<String, dynamic> json) {
    return LikeResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      isLiked: json['is_liked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (isLiked != null) 'is_liked': isLiked,
    };
  }

  @override
  LikeResponseEntity toEntity() {
    return LikeResponseEntity(
      success: success,
      message: message,
      isLiked: isLiked,
    );
  }
}

/// Like Data Model
class LikeDataModel extends BaseModel<LikeDataEntity> {
  final int id;
  final int postId;
  final int userId;
  final String userName;
  final String userAvatar;
  final String createdAt;

  LikeDataModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.createdAt,
  });

  factory LikeDataModel.fromJson(Map<String, dynamic> json) {
    return LikeDataModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      userAvatar: json['user_avatar'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'created_at': createdAt,
    };
  }

  @override
  LikeDataEntity toEntity() {
    return LikeDataEntity(
      id: id,
      postId: postId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      createdAt: createdAt,
    );
  }
}

/// Likes List Response Model
class LikesListModel extends BaseModel<LikesListEntity> {
  final bool success;
  final String message;
  final List<LikeDataModel> data;

  LikesListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LikesListModel.fromJson(Map<String, dynamic> json) {
    return LikesListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => LikeDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  @override
  LikesListEntity toEntity() {
    return LikesListEntity(
      success: success,
      message: message,
      data: data.map((e) => e.toEntity()).toList(),
    );
  }
}

