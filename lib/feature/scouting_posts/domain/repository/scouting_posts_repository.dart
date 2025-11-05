import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/iscouting_posts_remote.dart';
import '../../data/request/param/get_posts_param.dart';
import '../../data/request/param/get_post_by_id_param.dart';
import '../entity/post_response_entity.dart';
import 'iscouting_posts_repository.dart';

@Singleton(as: IScoutingPostsRepository)
class ScoutingPostsRepository extends Repository
    implements IScoutingPostsRepository {
  final IScoutingPostsRemoteSource remoteDataSource;

  ScoutingPostsRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, PostsListResponseEntity>> getPosts(
      GetPostsParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getPosts(param),
    );
  }

  @override
  Future<Result<AppErrors, PostResponseEntity>> getPostById(
      GetPostByIdParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getPostById(param),
    );
  }
}

