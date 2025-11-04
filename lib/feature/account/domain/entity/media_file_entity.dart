// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';

import '../../../../core/common/type_validators.dart';

class MediaFileEntity extends BaseEntity {
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
  MediaFileEntity({
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

  @override
  List<Object?> get props => [
        id,
        full,
        avater,
        isPrivate,
        privateFileFull,
        privateFileAvater,
        isVideo,
        videoFile,
        isConfirmed,
        isApproved,
        urlFile,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': stringV(id),
      'full': stringV(full),
      'avater': stringV(avater),
      'isPrivate': stringV(isPrivate),
      'privateFileFull': stringV(privateFileFull),
      'privateFileAvater': stringV(privateFileAvater),
      'isVideo': stringV(isVideo),
      'videoFile': stringV(videoFile),
      'isConfirmed': stringV(isConfirmed),
      'isApproved': stringV(isApproved),
      'urlFile': stringV(urlFile),
    };
  }

  factory MediaFileEntity.fromMap(Map<String, dynamic> map) {
    return MediaFileEntity(
      id: stringV(map['id']),
      full: stringV(map['full']),
      avater: stringV(map['avater']),
      isPrivate: stringV(map['isPrivate']),
      privateFileFull: stringV(map['privateFileFull']),
      privateFileAvater: stringV(map['privateFileAvater']),
      isVideo: stringV(map['isVideo']),
      videoFile: stringV(map['videoFile']),
      isConfirmed: stringV(map['isConfirmed']),
      isApproved: stringV(map['isApproved']),
      urlFile: stringV(map['urlFile']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaFileEntity.fromJson(String source) =>
      MediaFileEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
