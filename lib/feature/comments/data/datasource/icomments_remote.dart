import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../request/model/comment_response_model.dart';
import '../request/param/create_comment_param.dart';
import '../request/param/get_user_comments_param.dart';
import '../request/param/get_post_comments_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../mainapis.dart';

part 'comments_remote.dart';

abstract class ICommentsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, CommentResponseModel>> createComment(
      CreateCommentParam param);
  
  Future<Either<AppErrors, CommentsListModel>> getUserComments(
      GetUserCommentsParam param);
  
  Future<Either<AppErrors, CommentsListModel>> getPostComments(
      GetPostCommentsParam param);
}

