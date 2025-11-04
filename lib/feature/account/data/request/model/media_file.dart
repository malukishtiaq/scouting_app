import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/domain/entity/media_file_entity.dart';

class MediaFileModel extends BaseModel<MediaFileEntity> {
  final String id;
  final String full;
  final String avater;
  final String isPrivate;
  final String privateFileFull;
  final String privateFileAvater;
  final String isVideo;
  final String videoFile;
  final String isConfirmed;
  final String isApproved;
  final String urlFile;
  MediaFileModel({
    required this.id,
    required this.full,
    required this.avater,
    required this.isPrivate,
    required this.privateFileFull,
    required this.privateFileAvater,
    required this.isVideo,
    required this.videoFile,
    required this.isConfirmed,
    required this.isApproved,
    required this.urlFile,
  });
  factory MediaFileModel.fromMap(Map<String, dynamic> map) {
    return MediaFileModel(
      id: stringV(map['id']),
      full: stringV(map['full']),
      avater: stringV(map['avater']),
      isPrivate: stringV(map['is_private']),
      privateFileFull: stringV(map['private_file_full']),
      privateFileAvater: stringV(map['private_file_avater']),
      isVideo: stringV(map['is_video']),
      videoFile: stringV(map['VideoFile']),
      isConfirmed: stringV(map['is_confirmed']),
      isApproved: stringV(map['is_approved']),
      urlFile: stringV(map['url_file']),
    );
  }

  @override
  MediaFileEntity toEntity() {
    return MediaFileEntity(
      id: id,
      full: full,
      avater: avater,
      isPrivate: isPrivate,
      privateFileFull: privateFileFull,
      privateFileAvater: privateFileAvater,
      isVideo: isVideo,
      videoFile: videoFile,
      isConfirmed: isConfirmed,
      isApproved: isApproved,
      urlFile: urlFile,
    );
  }
}
