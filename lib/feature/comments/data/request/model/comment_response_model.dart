import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/comments/domain/entity/comment_response_entity.dart';

/// Comment Response Model - successful comment creation
class CommentResponseModel extends BaseModel<CommentResponseEntity> {
  final bool success;
  final String message;
  final CommentDataModel? data;

  CommentResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CommentDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  @override
  CommentResponseEntity toEntity() {
    return CommentResponseEntity(
      success: success,
      message: message,
      data: data?.toEntity(),
    );
  }
}

/// Comment Data Model
class CommentDataModel extends BaseModel<CommentDataEntity> {
  final int id;
  final int postId;
  final int userId;
  final String userName;
  final String userAvatar;
  final String comment;
  final String createdAt;
  final int? parentCommentId;

  CommentDataModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.comment,
    required this.createdAt,
    this.parentCommentId,
  });

  factory CommentDataModel.fromJson(Map<String, dynamic> json) {
    return CommentDataModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      userAvatar: json['user_avatar'] ?? '',
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      parentCommentId: json['parent_comment_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'comment': comment,
      'created_at': createdAt,
      if (parentCommentId != null) 'parent_comment_id': parentCommentId,
    };
  }

  @override
  CommentDataEntity toEntity() {
    return CommentDataEntity(
      id: id,
      postId: postId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      comment: comment,
      createdAt: createdAt,
      parentCommentId: parentCommentId,
    );
  }
}

/// Comments List Response Model
class CommentsListModel extends BaseModel<CommentsListEntity> {
  final bool success;
  final String message;
  final List<CommentDataModel> data;

  CommentsListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CommentsListModel.fromJson(Map<String, dynamic> json) {
    return CommentsListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CommentDataModel.fromJson(e as Map<String, dynamic>))
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
  CommentsListEntity toEntity() {
    return CommentsListEntity(
      success: success,
      message: message,
      data: data.map((e) => e.toEntity()).toList(),
    );
  }
}

