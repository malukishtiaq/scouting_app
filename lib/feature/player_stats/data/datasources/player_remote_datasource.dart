part of 'iplayer_remote_datasource.dart';

@Injectable(as: IPlayerRemoteDatasource)
class PlayerRemoteDatasource extends IPlayerRemoteDatasource {
  @override
  Future<Either<AppErrors, PlayerModel>> getPlayer(GetPlayerParam param) async {
    return await request<PlayerModel>(
      converter: (json) => PlayerModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiGetPlayer, // TODO: Add to mainapis.dart
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
      params: param,
    );
  }

  @override
  Future<Either<AppErrors, PlayerModel>> updatePlayer(
      UpdatePlayerParam param) async {
    return await request<PlayerModel>(
      converter: (json) => PlayerModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiUpdatePlayer, // TODO: Add to mainapis.dart
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, MediaModel>> uploadMedia(
      UploadMediaParam param) async {
    return await requestUploadFile<MediaModel>(
      converter: (json) => MediaModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiUploadPlayerMedia, // TODO: Add to mainapis.dart
      file: param.mediaPath,
      fileKey: 'media_file',
      body: {
        'player_id': param.playerId,
        'media_type': param.mediaType,
        if (param.title != null) 'title': param.title,
        if (param.description != null) 'description': param.description,
      },
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, List<GameModel>>> getUpcomingGames(
      GetPlayerParam param) async {
    return await request<List<GameModel>>(
      converter: (json) => (json as List)
          .map((game) => GameModel.fromJson(game as Map<String, dynamic>))
          .toList(),
      method: HttpMethod.GET,
      url: MainAPIS.apiGetUpcomingGames, // TODO: Add to mainapis.dart
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
      params: param,
    );
  }

  @override
  Future<Either<AppErrors, List<MediaModel>>> getPlayerMedia(
      GetPlayerParam param) async {
    return await request<List<MediaModel>>(
      converter: (json) => (json as List)
          .map((media) => MediaModel.fromJson(media as Map<String, dynamic>))
          .toList(),
      method: HttpMethod.GET,
      url: MainAPIS.apiGetPlayerMedia, // TODO: Add to mainapis.dart
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
      params: param,
    );
  }
}
