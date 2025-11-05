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
  final String content;
  final int? commentId; // Parent comment ID (null = top-level)
  final String createdAt;
  final String updatedAt;
  final List<CommentDataModel>? replies; // Nested replies

  CommentDataModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.commentId,
    required this.createdAt,
    required this.updatedAt,
    this.replies,
  });

  factory CommentDataModel.fromJson(Map<String, dynamic> json) {
    return CommentDataModel(
      id: json['id'] ?? 0,
      postId: json['post_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      content: json['content'] ?? '',
      commentId: json['comment_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => CommentDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'content': content,
      if (commentId != null) 'comment_id': commentId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      if (replies != null) 'replies': replies!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  CommentDataEntity toEntity() {
    return CommentDataEntity(
      id: id,
      postId: postId,
      userId: userId,
      content: content,
      commentId: commentId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      replies: replies?.map((e) => e.toEntity()).toList(),
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

