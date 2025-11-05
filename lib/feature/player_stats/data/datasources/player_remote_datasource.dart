part of 'iplayer_remote_datasource.dart';

@Injectable(as: IPlayerRemoteDatasource)
class PlayerRemoteDatasource extends IPlayerRemoteDatasource {
  @override
  Future<Either<AppErrors, PlayerModel>> getPlayer(GetPlayerParam param) async {
    // Use existing Member API - GET /api/members/{user_id}
    return await request<PlayerModel>(
      converter: (json) => PlayerModel.fromJson(json),
      method: HttpMethod.GET,
      url: '${MainAPIS.apiMemberShow}/${param.playerId}',
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
}
