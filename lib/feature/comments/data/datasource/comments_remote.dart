part of 'icomments_remote.dart';

@Injectable(as: ICommentsRemoteSource)
class CommentsRemoteSource extends ICommentsRemoteSource {
  @override
  Future<Either<AppErrors, CommentResponseModel>> createComment(
      CreateCommentParam param) async {
    return await request(
      converter: (json) => CommentResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: '${MainAPIS.apiCreateComment}/${param.postId}',
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Comment creation requires authentication
      enableLogging: true,
      params: param, // Pass params for cache invalidation
    );
  }

  @override
  Future<Either<AppErrors, CommentsListModel>> getUserComments(
      GetUserCommentsParam param) async {
    return await request(
      converter: (json) => CommentsListModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiUserComments,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }

  @override
  Future<Either<AppErrors, CommentsListModel>> getPostComments(
      GetPostCommentsParam param) async {
    return await request(
      converter: (json) => CommentsListModel.fromJson(json),
      method: HttpMethod.GET,
      url: '${MainAPIS.apiPostComments}/${param.postId}/comments',
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }
}
