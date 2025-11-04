import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_photo_entity.dart';

class UserProfilePhotoModel extends BaseModel<UserProfilePhotoEntity> {
  final String? id;
  final String? userId;
  final String? image;
  final String? imageOrg;
  final String? postId;
  final String? parentId;
  final String? description;
  final String? createdAt;

  UserProfilePhotoModel({
    this.id,
    this.userId,
    this.image,
    this.imageOrg,
    this.postId,
    this.parentId,
    this.description,
    this.createdAt,
  });

  factory UserProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePhotoModel(
      id: stringV(json["id"]).isEmpty ? null : stringV(json["id"]),
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      // Use postFile_full for the main image URL (it's already a full URL)
      image: stringV(json["postFile_full"]).isEmpty
          ? null
          : stringV(json["postFile_full"]),
      // Use postFile for the original image path
      imageOrg:
          stringV(json["postFile"]).isEmpty ? null : stringV(json["postFile"]),
      postId:
          stringV(json["post_id"]).isEmpty ? null : stringV(json["post_id"]),
      parentId: stringV(json["parent_id"]).isEmpty
          ? null
          : stringV(json["parent_id"]),
      description:
          stringV(json["postText"]).isEmpty ? null : stringV(json["postText"]),
      createdAt: stringV(json["time"]).isEmpty ? null : stringV(json["time"]),
    );
  }

  // Factory method for single photo posts
  factory UserProfilePhotoModel.fromPostJson(Map<String, dynamic> postData) {
    final imageUrl = stringV(postData["postFile_full"]).isEmpty
        ? null
        : stringV(postData["postFile_full"]);
    print('🔍 fromPostJson: Creating photo with image URL: $imageUrl');

    return UserProfilePhotoModel(
      id: stringV(postData["post_id"]).isEmpty
          ? null
          : stringV(postData["post_id"]),
      userId: stringV(postData["user_id"]).isEmpty
          ? null
          : stringV(postData["user_id"]),
      // Use postFile_full for the main image URL (it's already a full URL)
      image: imageUrl,
      // Use postFile for the original image path
      imageOrg: stringV(postData["postFile"]).isEmpty
          ? null
          : stringV(postData["postFile"]),
      postId: stringV(postData["post_id"]).isEmpty
          ? null
          : stringV(postData["post_id"]),
      parentId: stringV(postData["parent_id"]).isEmpty
          ? null
          : stringV(postData["parent_id"]),
      description: stringV(postData["postText"]).isEmpty
          ? null
          : stringV(postData["postText"]),
      createdAt:
          stringV(postData["time"]).isEmpty ? null : stringV(postData["time"]),
    );
  }

  // Factory method for album photos
  factory UserProfilePhotoModel.fromAlbumJson(
    Map<String, dynamic> albumPhotoData,
    Map<String, dynamic> postData,
  ) {
    final imageUrl = stringV(albumPhotoData["image"]).isEmpty
        ? null
        : stringV(albumPhotoData["image"]);
    print('🔍 fromAlbumJson: Creating album photo with image URL: $imageUrl');

    return UserProfilePhotoModel(
      id: stringV(albumPhotoData["id"]).isEmpty
          ? null
          : stringV(albumPhotoData["id"]),
      userId: stringV(postData["user_id"]).isEmpty
          ? null
          : stringV(postData["user_id"]),
      // Use the album photo's image URL
      image: imageUrl,
      // Use the album photo's original image path
      imageOrg: stringV(albumPhotoData["image_org"]).isEmpty
          ? null
          : stringV(albumPhotoData["image_org"]),
      postId: stringV(postData["post_id"]).isEmpty
          ? null
          : stringV(postData["post_id"]),
      parentId: stringV(albumPhotoData["parent_id"]).isEmpty
          ? null
          : stringV(albumPhotoData["parent_id"]),
      description: stringV(postData["postText"]).isEmpty
          ? null
          : stringV(postData["postText"]),
      createdAt:
          stringV(postData["time"]).isEmpty ? null : stringV(postData["time"]),
    );
  }

  // Generate full URL from image path
  String? get fullImageUrl {
    if (image == null || image!.isEmpty) return null;
    // postFile_full is already a full URL, so return it directly
    return image;
  }

  // Generate full URL from original image path
  String? get fullImageOrgUrl {
    if (imageOrg == null || imageOrg!.isEmpty) return null;
    return _getFinalLink(imageOrg!);
  }

  // Helper method to generate full URL (similar to Xamarin's GetTheFinalLink)
  String _getFinalLink(String media) {
    if (media.contains("http")) {
      return media;
    }

    // Support for multiple cloud storage providers like Xamarin
    return _getCloudStorageUrl(media);
  }

  String _getCloudStorageUrl(String media) {
    // Check for different cloud storage patterns
    if (media.startsWith('s3://') || media.startsWith('amazonaws.com')) {
      // AWS S3 support
      return _buildS3Url(media);
    } else if (media.startsWith('spaces://') ||
        media.contains('digitaloceanspaces.com')) {
      // DigitalOcean Spaces support
      return _buildSpacesUrl(media);
    } else if (media.startsWith('ftp://') || media.startsWith('ftps://')) {
      // FTP support
      return _buildFtpUrl(media);
    } else if (media.startsWith('cloud://') ||
        media.contains('cloudinary.com')) {
      // Cloudinary support
      return _buildCloudinaryUrl(media);
    } else if (media.startsWith('azure://') ||
        media.contains('blob.core.windows.net')) {
      // Azure Blob Storage support
      return _buildAzureUrl(media);
    } else if (media.startsWith('gcs://') ||
        media.contains('storage.googleapis.com')) {
      // Google Cloud Storage support
      return _buildGcsUrl(media);
    } else {
      // Default to base URL
      return "https://handshakes4u.com/$media";
    }
  }

  String _buildS3Url(String media) {
    // AWS S3 URL construction
    if (media.startsWith('s3://')) {
      final bucket = media.substring(5).split('/').first;
      final key = media.substring(5 + bucket.length + 1);
      return "https://$bucket.s3.amazonaws.com/$key";
    }
    return media;
  }

  String _buildSpacesUrl(String media) {
    // DigitalOcean Spaces URL construction
    if (media.startsWith('spaces://')) {
      final parts = media.substring(9).split('/');
      if (parts.length >= 2) {
        final region = parts[0];
        final bucket = parts[1];
        final key = parts.sublist(2).join('/');
        return "https://$bucket.$region.digitaloceanspaces.com/$key";
      }
    }
    return media;
  }

  String _buildFtpUrl(String media) {
    // FTP URLs (convert to HTTP if possible)
    if (media.startsWith('ftp://')) {
      return media.replaceFirst('ftp://', 'https://');
    } else if (media.startsWith('ftps://')) {
      return media.replaceFirst('ftps://', 'https://');
    }
    return media;
  }

  String _buildCloudinaryUrl(String media) {
    // Cloudinary URL construction
    if (media.startsWith('cloud://')) {
      final parts = media.substring(8).split('/');
      if (parts.length >= 3) {
        final cloudName = parts[0];
        final transformation = parts[1];
        final publicId = parts.sublist(2).join('/');
        return "https://res.cloudinary.com/$cloudName/image/upload/$transformation/$publicId";
      }
    }
    return media;
  }

  String _buildAzureUrl(String media) {
    // Azure Blob Storage URL construction
    if (media.startsWith('azure://')) {
      final parts = media.substring(8).split('/');
      if (parts.length >= 2) {
        final accountName = parts[0];
        final containerName = parts[1];
        final blobName = parts.sublist(2).join('/');
        return "https://$accountName.blob.core.windows.net/$containerName/$blobName";
      }
    }
    return media;
  }

  String _buildGcsUrl(String media) {
    // Google Cloud Storage URL construction
    if (media.startsWith('gcs://')) {
      final parts = media.substring(6).split('/');
      if (parts.length >= 2) {
        final bucketName = parts[0];
        final objectName = parts.sublist(1).join('/');
        return "https://storage.googleapis.com/$bucketName/$objectName";
      }
    }
    return media;
  }

  @override
  UserProfilePhotoEntity toEntity() {
    return UserProfilePhotoEntity(
      id: id,
      userId: userId,
      image: image,
      imageOrg: imageOrg,
      postId: postId,
      parentId: parentId,
      description: description,
      createdAt: createdAt,
      fullImageUrl: fullImageUrl,
      fullImageOrgUrl: fullImageOrgUrl,
    );
  }
}
