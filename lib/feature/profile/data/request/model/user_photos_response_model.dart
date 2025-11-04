import '../../../../../core/models/base_model.dart';
import '../../../../../core/entities/base_entity.dart';
import '../../../../../core/common/type_validators.dart';
import 'user_profile_photo_model.dart';

class UserPhotosResponseModel extends BaseModel<BaseEntity> {
  final int apiStatus;
  final List<UserProfilePhotoModel> data;

  UserPhotosResponseModel({
    required this.apiStatus,
    required this.data,
  });

  factory UserPhotosResponseModel.fromJson(Map<String, dynamic> json) {
    print('🔍 UserPhotosResponseModel.fromJson: Raw JSON keys: ${json.keys}');
    final List<dynamic> rawData = json['data'] as List<dynamic>? ?? [];
    print(
        '🔍 UserPhotosResponseModel.fromJson: Raw data length: ${rawData.length}');
    final List<UserProfilePhotoModel> photos = [];

    for (int i = 0; i < rawData.length; i++) {
      final item = rawData[i];
      final Map<String, dynamic> postData = item as Map<String, dynamic>;
      print(
          '🔍 Processing item $i: postFile_full=${postData['postFile_full']}, photo_album=${postData['photo_album']}');

      // Check if this post has a single photo
      if (postData['postFile_full'] != null &&
          stringV(postData['postFile_full']).isNotEmpty) {
        // Single photo post
        print('🔍 Adding single photo from post $i');
        photos.add(UserProfilePhotoModel.fromPostJson(postData));
      }

      // Check if this post has multiple photos in photo_album
      if (postData['photo_album'] is List) {
        final List<dynamic> albumPhotos =
            postData['photo_album'] as List<dynamic>;
        print('🔍 Found album with ${albumPhotos.length} photos in post $i');
        for (final albumPhoto in albumPhotos) {
          if (albumPhoto is Map<String, dynamic>) {
            print('🔍 Adding album photo from post $i');
            photos
                .add(UserProfilePhotoModel.fromAlbumJson(albumPhoto, postData));
          }
        }
      }
    }

    print(
        '🔍 UserPhotosResponseModel.fromJson: Total photos parsed: ${photos.length}');
    return UserPhotosResponseModel(
      apiStatus: numV<int>(json["api_status"]) ?? 400,
      data: photos,
    );
  }

  @override
  BaseEntity toEntity() {
    return UserPhotosResponseEntity();
  }
}

class UserPhotosResponseEntity extends BaseEntity {
  @override
  List<Object?> get props => [];
}
