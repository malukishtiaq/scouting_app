import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/likes/domain/entity/like_response_entity.dart';
import 'package:scouting_app/feature/account/data/request/model/member_response_model.dart';

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

/// Likes List Response Model
/// Returns list of members who liked a post
class LikesListModel extends BaseModel<LikesListEntity> {
  final bool success;
  final String message;
  final List<MemberDataModel> data; // Members who liked the post

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
              ?.map((e) => MemberDataModel.fromJson(e as Map<String, dynamic>))
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

