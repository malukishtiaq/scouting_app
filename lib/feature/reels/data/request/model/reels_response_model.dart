import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/reels/domain/entity/reels_response_entity.dart';

/// Reels API Success Response - represents successful reels fetch
class ReelsResponseModel extends BaseModel<ReelsResponseEntity> {
  final int apiStatus; // API status (200)
  final List<PostDataModel>? data; // List of reel videos (posts with videos)

  ReelsResponseModel({
    required this.apiStatus,
    this.data,
  });

  factory ReelsResponseModel.fromJson(Map<String, dynamic> json) {
    return ReelsResponseModel(
      apiStatus: json["api_status"] ?? 400,
      data: json["data"] != null
          ? List<PostDataModel>.from(
              json["data"].map((x) => PostDataModel.fromJson(x)))
          : null,
    );
  }

  @override
  ReelsResponseEntity toEntity() {
    return ReelsResponseEntity(
      apiStatus: apiStatus,
      data: data?.map((x) => x.toEntity()).toList(),
    );
  }
}

class PostDataModel extends BaseModel<PostDataEntity> {
  final String id;
  final String title;
  final String description;
  final String image;
  final String video;
  final String audio;
  final String videoThumbnail;
  final String audioThumbnail;
  PostDataModel({
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
  PostDataEntity toEntity() {
    return PostDataEntity(
      id: id,
      title: title,
      description: description,
      image: image,
      video: video,
      audio: audio,
      videoThumbnail: videoThumbnail,
      audioThumbnail: audioThumbnail,
    );
  }

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    return PostDataModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      audio: json['audio'] ?? '',
      videoThumbnail: json['video_thumbnail'] ?? '',
      audioThumbnail: json['audio_thumbnail'] ?? '',
    );
  }
}
