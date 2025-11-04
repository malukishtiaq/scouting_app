import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_entity.dart';

class UserProfileBlogModel extends BaseModel<UserProfileBlogEntity> {
  final String? blogId;
  final String? blogTitle;
  final String? blogDescription;
  final String? blogThumbnail;
  final String? blogTime;

  UserProfileBlogModel({
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogThumbnail,
    this.blogTime,
  });

  factory UserProfileBlogModel.fromJson(Map<String, dynamic> json) {
    return UserProfileBlogModel(
      blogId:
          stringV(json["blog_id"]).isEmpty ? null : stringV(json["blog_id"]),
      blogTitle: stringV(json["blog_title"]).isEmpty
          ? null
          : stringV(json["blog_title"]),
      blogDescription: stringV(json["blog_description"]).isEmpty
          ? null
          : stringV(json["blog_description"]),
      blogThumbnail: stringV(json["blog_thumbnail"]).isEmpty
          ? null
          : stringV(json["blog_thumbnail"]),
      blogTime: stringV(json["blog_time"]).isEmpty
          ? null
          : stringV(json["blog_time"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "blog_id": blogId,
      "blog_title": blogTitle,
      "blog_description": blogDescription,
      "blog_thumbnail": blogThumbnail,
      "blog_time": blogTime,
    };
  }

  @override
  UserProfileBlogEntity toEntity() {
    return UserProfileBlogEntity(
      blogId: blogId,
      blogTitle: blogTitle,
      blogDescription: blogDescription,
      blogThumbnail: blogThumbnail,
      blogTime: blogTime,
    );
  }
}
