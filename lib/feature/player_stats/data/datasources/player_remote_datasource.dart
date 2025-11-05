part of 'iplayer_remote_datasource.dart';

@Injectable(as: IPlayerRemoteDatasource)
class PlayerRemoteDatasource extends IPlayerRemoteDatasource {
  @override
  Future<Either<AppErrors, PlayerModel>> getPlayer(GetPlayerParam param) async {
    // Use existing Member API - GET /api/members/{user_id}
    return await request<PlayerModel>(
      converter: (json) => PlayerModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiMemberShow,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
      params: param,
    );
  }

  @override
  Future<Either<AppErrors, PlayerModel>> updatePlayer(
      UpdatePlayerParam param) async {
    // Use existing Member API - POST /api/profile
    return await request<PlayerModel>(
      converter: (json) => PlayerModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiMemberUpdate, // api/profile
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true,
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, MediaModel>> uploadMedia(
      UploadMediaParam param) async {
    // TODO: This API endpoint needs to be implemented on the backend
    // Expected: POST /api/media/upload or POST /api/profile/media
    throw UnimplementedError('Upload media API not yet available. Please provide the API endpoint from your documentation.');
  }

  @override
  Future<Either<AppErrors, List<GameModel>>> getUpcomingGames(
      GetPlayerParam param) async {
    // TODO: This API endpoint needs to be implemented on the backend
    // Expected: GET /api/games or GET /api/schedule
    throw UnimplementedError('Get upcoming games API not yet available. Please provide the API endpoint from your documentation.');
  }

  @override
  Future<Either<AppErrors, List<MediaModel>>> getPlayerMedia(
      GetPlayerParam param) async {
    // TODO: This API endpoint needs to be implemented on the backend
    // Expected: GET /api/media or GET /api/profile/media
    throw UnimplementedError('Get player media API not yet available. Please provide the API endpoint from your documentation.');
  }
}
