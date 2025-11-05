import 'package:dartz/dartz.dart';
import '../request/model/post_response_model.dart';
import '../request/param/get_posts_param.dart';
import '../request/param/get_post_by_id_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';

abstract class IScoutingPostsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, PostsListResponseModel>> getPosts(
      GetPostsParam param);
  
  Future<Either<AppErrors, PostResponseModel>> getPostById(
      GetPostByIdParam param);
}

