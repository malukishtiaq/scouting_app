import 'package:dio/dio.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../request/model/player_model.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';
import 'iplayer_remote_datasource.dart';

/// Player Remote Datasource Implementation
class PlayerRemoteDatasource implements IPlayerRemoteDatasource {
  final ApiConsumer apiConsumer;

  const PlayerRemoteDatasource({required this.apiConsumer});

  @override
  Future<PlayerModel> getPlayer(GetPlayerParam param) async {
    final response = await apiConsumer.get(
      EndPoints.getPlayer, // TODO: Define this endpoint
      queryParameters: param.toJson(),
    );

    return PlayerModel.fromJson(response);
  }

  @override
  Future<PlayerModel> updatePlayer(UpdatePlayerParam param) async {
    final response = await apiConsumer.post(
      EndPoints.updatePlayer, // TODO: Define this endpoint
      body: param.toJson(),
    );

    return PlayerModel.fromJson(response);
  }

  @override
  Future<MediaModel> uploadMedia(UploadMediaParam param) async {
    // Create form data for file upload
    final formData = FormData.fromMap({
      'player_id': param.playerId,
      'media_type': param.mediaType,
      if (param.title != null) 'title': param.title,
      if (param.description != null) 'description': param.description,
      'media_file': await MultipartFile.fromFile(
        param.mediaPath,
        filename: param.mediaPath.split('/').last,
      ),
    });

    final response = await apiConsumer.post(
      EndPoints.uploadPlayerMedia, // TODO: Define this endpoint
      body: formData,
    );

    return MediaModel.fromJson(response);
  }

  @override
  Future<List<GameModel>> getUpcomingGames(GetPlayerParam param) async {
    final response = await apiConsumer.get(
      EndPoints.getUpcomingGames, // TODO: Define this endpoint
      queryParameters: param.toJson(),
    );

    return (response as List).map((game) => GameModel.fromJson(game)).toList();
  }

  @override
  Future<List<MediaModel>> getPlayerMedia(GetPlayerParam param) async {
    final response = await apiConsumer.get(
      EndPoints.getPlayerMedia, // TODO: Define this endpoint
      queryParameters: param.toJson(),
    );

    return (response as List)
        .map((media) => MediaModel.fromJson(media))
        .toList();
  }
}

