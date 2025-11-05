import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/iscouting_posts_remote.dart';
import '../../data/request/param/get_posts_param.dart';
import '../../data/request/param/get_post_by_id_param.dart';
import '../entity/post_response_entity.dart';
import 'iscouting_posts_repository.dart';

@Singleton(as: IScoutingPostsRepository)
class ScoutingPostsRepository extends IScoutingPostsRepository {
  final IScoutingPostsRemoteSource _remoteSource;

  ScoutingPostsRepository(this._remoteSource);

  @override
  Future<Result<AppErrors, PostsListResponseEntity>> getPosts(
      GetPostsParam param) async {
    final result = await _remoteSource.getPosts(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, PostResponseEntity>> getPostById(
      GetPostByIdParam param) async {
    final result = await _remoteSource.getPostById(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }
}

