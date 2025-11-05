part of 'iscouting_posts_remote.dart';

import 'package:injectable/injectable.dart';
import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../mainapis.dart';

@Injectable(as: IScoutingPostsRemoteSource)
class ScoutingPostsRemoteSource extends IScoutingPostsRemoteSource {
  @override
  Future<Either<AppErrors, PostsListResponseModel>> getPosts(
      GetPostsParam param) async {
    return await request(
      converter: (json) => PostsListResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiPostsList,
      queryParameters: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }

  @override
  Future<Either<AppErrors, PostResponseModel>> getPostById(
      GetPostByIdParam param) async {
    return await request(
      converter: (json) => PostResponseModel.fromJson(json),
      method: HttpMethod.GET,
      url: '${MainAPIS.apiPostsShow}/${param.postId}',
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }
}

