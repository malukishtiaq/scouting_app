import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/request/param/get_posts_param.dart';
import '../../data/request/param/get_post_by_id_param.dart';
import '../entity/post_response_entity.dart';

abstract class IScoutingPostsRepository {
  Future<Result<AppErrors, PostsListResponseEntity>> getPosts(
      GetPostsParam param);
  
  Future<Result<AppErrors, PostResponseEntity>> getPostById(
      GetPostByIdParam param);
}

