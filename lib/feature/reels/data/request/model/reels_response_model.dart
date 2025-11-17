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
  final String publisherName;
  final String publisherUsername;
  final String publisherAvatar;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  PostDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.audio,
    required this.videoThumbnail,
    required this.audioThumbnail,
    required this.publisherName,
    required this.publisherUsername,
    required this.publisherAvatar,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
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
      publisherName: publisherName,
      publisherUsername: publisherUsername,
      publisherAvatar: publisherAvatar,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
    );
  }

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    final publisherMap = json['publisher'] is Map<String, dynamic>
        ? json['publisher'] as Map<String, dynamic>
        : null;
    final userDataMap = json['user_data'] is Map<String, dynamic>
        ? json['user_data'] as Map<String, dynamic>
        : null;

    final publisherName = _resolveDisplayName(
      primary: publisherMap,
      secondary: userDataMap,
      fallback: json['user'],
    );

    final publisherUsername =
        _resolveUsername(primary: publisherMap, secondary: userDataMap) ??
            (json['user'] is String ? json['user'] as String : '');

    final publisherAvatar = _resolveAvatar(
      primary: publisherMap,
      secondary: userDataMap,
    );

    final likeCount = _parseCount(json['post_likes'] ?? json['likes']);
    final commentCount =
        _parseCount(json['post_comments'] ?? json['comments']);
    final shareCount = _parseCount(json['post_shares'] ?? json['shares']);

    return PostDataModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      audio: json['audio'] ?? '',
      videoThumbnail: json['video_thumbnail'] ?? '',
      audioThumbnail: json['audio_thumbnail'] ?? '',
      publisherName: publisherName,
      publisherUsername: publisherUsername ?? '',
      publisherAvatar: publisherAvatar,
      likeCount: likeCount,
      commentCount: commentCount,
      shareCount: shareCount,
    );
  }

  static int _parseCount(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final numericOnly = value.replaceAll(RegExp(r'[^0-9.]'), '');
      if (numericOnly.isEmpty) {
        return 0;
      }
      return int.tryParse(numericOnly) ??
          double.tryParse(numericOnly)?.toInt() ??
          0;
    }
    return 0;
  }

  static String _resolveDisplayName({
    Map<String, dynamic>? primary,
    Map<String, dynamic>? secondary,
    dynamic fallback,
  }) {
    String? candidate = _combineNames(primary);
    if (candidate != null && candidate.isNotEmpty) {
      return candidate;
    }

    candidate = _combineNames(secondary);
    if (candidate != null && candidate.isNotEmpty) {
      return candidate;
    }

    if (primary != null) {
      candidate = _stringValue(primary['name']) ??
          _stringValue(primary['full_name']) ??
          _stringValue(primary['username']);
      if (candidate != null && candidate.isNotEmpty) {
        return candidate;
      }
    }

    if (secondary != null) {
      candidate = _stringValue(secondary['name']) ??
          _stringValue(secondary['full_name']) ??
          _stringValue(secondary['username']);
      if (candidate != null && candidate.isNotEmpty) {
        return candidate;
      }
    }

    if (fallback is String && fallback.isNotEmpty) {
      return fallback;
    }

    return '';
  }

  static String? _resolveUsername({
    Map<String, dynamic>? primary,
    Map<String, dynamic>? secondary,
  }) {
    final primaryUsername = _stringValue(primary?['username']);
    if (primaryUsername != null && primaryUsername.isNotEmpty) {
      return primaryUsername;
    }

    final secondaryUsername = _stringValue(secondary?['username']);
    if (secondaryUsername != null && secondaryUsername.isNotEmpty) {
      return secondaryUsername;
    }

    return null;
  }

  static String _resolveAvatar({
    Map<String, dynamic>? primary,
    Map<String, dynamic>? secondary,
  }) {
    final candidates = [
      _stringValue(primary?['avatar']),
      _stringValue(primary?['avatar_original']),
      _stringValue(secondary?['avatar']),
      _stringValue(secondary?['avatar_original']),
    ];

    for (final candidate in candidates) {
      if (candidate != null && candidate.isNotEmpty) {
        return candidate;
      }
    }
    return '';
  }

  static String? _stringValue(dynamic value) {
    if (value is String) {
      return value;
    }
    return null;
  }

  static String? _combineNames(Map<String, dynamic>? data) {
    if (data == null) return null;
    final firstName = _stringValue(data['first_name']);
    final lastName = _stringValue(data['last_name']);

    final buffer = <String>[];
    if (firstName != null && firstName.isNotEmpty) {
      buffer.add(firstName);
    }
    if (lastName != null && lastName.isNotEmpty) {
      buffer.add(lastName);
    }

    if (buffer.isNotEmpty) {
      return buffer.join(' ');
    }
    return null;
  }
}
