import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/ilikes_remote.dart';
import '../../data/request/param/toggle_like_param.dart';
import '../../data/request/param/get_user_likes_param.dart';
import '../../data/request/param/get_post_likes_param.dart';
import '../entity/like_response_entity.dart';
import 'ilikes_repository.dart';

@Singleton(as: ILikesRepository)
class LikesRepository extends ILikesRepository {
  final ILikesRemoteSource _remoteSource;

  LikesRepository(this._remoteSource);

  @override
  Future<Result<AppErrors, LikeResponseEntity>> toggleLike(
      ToggleLikeParam param) async {
    final result = await _remoteSource.toggleLike(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, LikesListEntity>> getUserLikes(
      GetUserLikesParam param) async {
    final result = await _remoteSource.getUserLikes(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, LikesListEntity>> getPostLikes(
      GetPostLikesParam param) async {
    final result = await _remoteSource.getPostLikes(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }
}

