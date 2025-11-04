// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/entities/base_entity.dart';

/// Reels API Success Response - represents successful reels fetch
class ReelsResponseEntity extends BaseEntity {
  final int apiStatus; // API status (200)
  final List<PostDataEntity>? data; // List of reel videos (posts with videos)

  ReelsResponseEntity({
    required this.apiStatus,
    this.data,
  });

  @override
  List<Object?> get props => [apiStatus, data];
}

class PostDataEntity extends BaseEntity {
  final String id;
  final String title;
  final String description;
  final String image;
  final String video;
  final String audio;
  final String videoThumbnail;
  final String audioThumbnail;
  PostDataEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.audio,
    required this.videoThumbnail,
    required this.audioThumbnail,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        video,
        audio,
        videoThumbnail,
        audioThumbnail,
      ];
}
