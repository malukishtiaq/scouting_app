import 'package:dartz/dartz.dart';
import '../request/model/comment_response_model.dart';
import '../request/param/create_comment_param.dart';
import '../request/param/get_user_comments_param.dart';
import '../request/param/get_post_comments_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';

abstract class ICommentsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, CommentResponseModel>> createComment(
      CreateCommentParam param);
  
  Future<Either<AppErrors, CommentsListModel>> getUserComments(
      GetUserCommentsParam param);
  
  Future<Either<AppErrors, CommentsListModel>> getPostComments(
      GetPostCommentsParam param);
}

