part of 'iexplore_remote.dart';

@Injectable(as: IExploreRemoteSource)
class ExploreRemoteSource extends IExploreRemoteSource {
  @override
  Future<Either<AppErrors, ExploreResponseModel>> getNearbyPlayers(
    GetNearbyPlayersParam param,
  ) async {
    return await request(
      converter: (json) => ExploreResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiGetNearbyUsers, // Using existing endpoint
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseModel>> searchPlayers(
    SearchPlayersParam param,
  ) async {
    return await request(
      converter: (json) => ExploreResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiSearch, // Using existing search endpoint
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseModel>> getRecommendedPlayers() async {
    return await request(
      converter: (json) => ExploreResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiFetchRecommended, // Using existing recommended endpoint
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseModel>> getTrendingPlayers() async {
    return await request(
      converter: (json) => ExploreResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiGetUserSuggestions, // Using user suggestions as trending
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      enableLogging: true,
    );
  }
}

