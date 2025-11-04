import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../request/model/posts_response_model.dart';
import '../request/param/get_posts_param.dart';

/// Interface for Posts Remote Data Source
abstract class IPostsRemoteSource {
  /// Get paginated list of posts
  Future<Either<AppErrors, PostsResponseModel>> getPosts(GetPostsParam param);

  /// Get a single post by ID
  Future<Either<AppErrors, PostModel>> getPostById(GetPostByIdParam param);
}
