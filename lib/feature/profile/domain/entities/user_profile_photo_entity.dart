import '../../../../core/entities/base_entity.dart';

class UserProfilePhotoEntity extends BaseEntity {
  final String? id;
  final String? userId;
  final String? image;
  final String? imageOrg;
  final String? postId;
  final String? parentId;
  final String? description;
  final String? createdAt;
  final String? fullImageUrl;
  final String? fullImageOrgUrl;

  UserProfilePhotoEntity({
    this.id,
    this.userId,
    this.image,
    this.imageOrg,
    this.postId,
    this.parentId,
    this.description,
    this.createdAt,
    this.fullImageUrl,
    this.fullImageOrgUrl,
  });

  // Backward compatibility getter
  String? get photoUrl => fullImageUrl;

  @override
  List<Object?> get props => [
        id,
        userId,
        image,
        imageOrg,
        postId,
        parentId,
        description,
        createdAt,
        fullImageUrl,
        fullImageOrgUrl,
      ];
}
