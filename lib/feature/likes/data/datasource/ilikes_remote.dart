import 'package:dartz/dartz.dart';
import '../request/model/like_response_model.dart';
import '../request/param/toggle_like_param.dart';
import '../request/param/get_user_likes_param.dart';
import '../request/param/get_post_likes_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';

abstract class ILikesRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, LikeResponseModel>> toggleLike(ToggleLikeParam param);
  
  Future<Either<AppErrors, LikesListModel>> getUserLikes(
      GetUserLikesParam param);
  
  Future<Either<AppErrors, LikesListModel>> getPostLikes(
      GetPostLikesParam param);
}

