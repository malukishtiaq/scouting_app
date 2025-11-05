import '../../../../../core/params/base_params.dart';

/// Parameter for uploading player media
class UploadMediaParam extends BaseParams {
  final String playerId;
  final String mediaPath;
  final String mediaType; // "video" or "photo"
  final String? title;
  final String? description;

  UploadMediaParam({
    required this.playerId,
    required this.mediaPath,
    required this.mediaType,
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'player_id': playerId,
      'media_path': mediaPath,
      'media_type': mediaType,
    };

    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;

    return data;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'player_id': playerId,
      'media_path': mediaPath,
      'media_type': mediaType,
      'title': title,
      'description': description,
    };
  }
}
