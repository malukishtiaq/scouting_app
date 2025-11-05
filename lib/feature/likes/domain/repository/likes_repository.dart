import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/ilikes_remote.dart';
import '../../data/request/param/toggle_like_param.dart';
import '../../data/request/param/get_user_likes_param.dart';
import '../../data/request/param/get_post_likes_param.dart';
import '../entity/like_response_entity.dart';
import 'ilikes_repository.dart';

@Singleton(as: ILikesRepository)
class LikesRepository extends Repository implements ILikesRepository {
  final ILikesRemoteSource remoteDataSource;

  LikesRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, LikeResponseEntity>> toggleLike(
      ToggleLikeParam param) async {
    return execute(
      remoteResult: await remoteDataSource.toggleLike(param),
    );
  }

  @override
  Future<Result<AppErrors, LikesListEntity>> getUserLikes(
      GetUserLikesParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getUserLikes(param),
    );
  }

  @override
  Future<Result<AppErrors, LikesListEntity>> getPostLikes(
      GetPostLikesParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getPostLikes(param),
    );
  }
}

