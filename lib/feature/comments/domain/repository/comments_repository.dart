import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/icomments_remote.dart';
import '../../data/request/param/create_comment_param.dart';
import '../../data/request/param/get_user_comments_param.dart';
import '../../data/request/param/get_post_comments_param.dart';
import '../entity/comment_response_entity.dart';
import 'icomments_repository.dart';

@Singleton(as: ICommentsRepository)
class CommentsRepository extends ICommentsRepository {
  final ICommentsRemoteSource _remoteSource;

  CommentsRepository(this._remoteSource);

  @override
  Future<Result<AppErrors, CommentResponseEntity>> createComment(
      CreateCommentParam param) async {
    final result = await _remoteSource.createComment(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, CommentsListEntity>> getUserComments(
      GetUserCommentsParam param) async {
    final result = await _remoteSource.getUserComments(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, CommentsListEntity>> getPostComments(
      GetPostCommentsParam param) async {
    final result = await _remoteSource.getPostComments(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }
}

