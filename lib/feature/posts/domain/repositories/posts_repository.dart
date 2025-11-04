import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/repositories/repository.dart';
import '../../data/datasources/iposts_remote_datasource.dart';
import '../../data/request/param/get_posts_param.dart';
import '../entity/posts_response_entity.dart';
import 'iposts_repository.dart';

@Injectable(as: IPostsRepository)
class PostsRepository extends Repository implements IPostsRepository {
  final IPostsRemoteSource _remoteSource;

  PostsRepository(this._remoteSource);

  @override
  Future<Result<AppErrors, PostsResponseEntity>> getPosts(
      GetPostsParam param) async {
    try {
      final remoteResult = await _remoteSource.getPosts(param);
      return execute(remoteResult: remoteResult);
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, PostEntity>> getPostById(
      GetPostByIdParam param) async {
    try {
      final remoteResult = await _remoteSource.getPostById(param);
      return execute(remoteResult: remoteResult);
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }
}
