import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../data/request/param/get_posts_param.dart';
import '../entity/posts_response_entity.dart';

/// Interface for Posts Repository
abstract class IPostsRepository {
  /// Get paginated list of posts
  Future<Result<AppErrors, PostsResponseEntity>> getPosts(GetPostsParam param);

  /// Get a single post by ID
  Future<Result<AppErrors, PostEntity>> getPostById(GetPostByIdParam param);
}
