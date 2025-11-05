import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/request/param/toggle_like_param.dart';
import '../../data/request/param/get_user_likes_param.dart';
import '../../data/request/param/get_post_likes_param.dart';
import '../entity/like_response_entity.dart';

abstract class ILikesRepository {
  Future<Result<AppErrors, LikeResponseEntity>> toggleLike(ToggleLikeParam param);
  
  Future<Result<AppErrors, LikesListEntity>> getUserLikes(
      GetUserLikesParam param);
  
  Future<Result<AppErrors, LikesListEntity>> getPostLikes(
      GetPostLikesParam param);
}

