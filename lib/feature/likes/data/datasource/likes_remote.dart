part of 'ilikes_remote.dart';

@Injectable(as: ILikesRemoteSource)
class LikesRemoteSource extends ILikesRemoteSource {
  @override
  Future<Either<AppErrors, LikeResponseModel>> toggleLike(
      ToggleLikeParam param) async {
    return await request(
      converter: (json) => LikeResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: '${MainAPIS.apiToggleLike}/${param.postId}',
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Like toggle requires authentication
      enableLogging: true,
      params: param, // Pass params for cache invalidation
    );
  }

  @override
  Future<Either<AppErrors, LikesListModel>> getUserLikes(
      GetUserLikesParam param) async {
    return await request(
      converter: (json) => LikesListModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiUserLikes,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }

  @override
  Future<Either<AppErrors, LikesListModel>> getPostLikes(
      GetPostLikesParam param) async {
    return await request(
      converter: (json) => LikesListModel.fromJson(json),
      method: HttpMethod.GET,
      url: '${MainAPIS.apiPostLikes}/${param.postId}/likes',
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }
}

