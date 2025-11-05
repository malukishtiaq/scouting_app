import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/icomments_remote.dart';
import '../../data/request/param/create_comment_param.dart';
import '../../data/request/param/get_user_comments_param.dart';
import '../../data/request/param/get_post_comments_param.dart';
import '../entity/comment_response_entity.dart';
import 'icomments_repository.dart';

@Singleton(as: ICommentsRepository)
class CommentsRepository extends Repository implements ICommentsRepository {
  final ICommentsRemoteSource remoteDataSource;

  CommentsRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, CommentResponseEntity>> createComment(
      CreateCommentParam param) async {
    return execute(
      remoteResult: await remoteDataSource.createComment(param),
    );
  }

  @override
  Future<Result<AppErrors, CommentsListEntity>> getUserComments(
      GetUserCommentsParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getUserComments(param),
    );
  }

  @override
  Future<Result<AppErrors, CommentsListEntity>> getPostComments(
      GetPostCommentsParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getPostComments(param),
    );
  }
}

