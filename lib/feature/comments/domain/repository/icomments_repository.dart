import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/request/param/create_comment_param.dart';
import '../../data/request/param/get_user_comments_param.dart';
import '../../data/request/param/get_post_comments_param.dart';
import '../entity/comment_response_entity.dart';

abstract class ICommentsRepository {
  Future<Result<AppErrors, CommentResponseEntity>> createComment(
      CreateCommentParam param);
  
  Future<Result<AppErrors, CommentsListEntity>> getUserComments(
      GetUserCommentsParam param);
  
  Future<Result<AppErrors, CommentsListEntity>> getPostComments(
      GetPostCommentsParam param);
}

