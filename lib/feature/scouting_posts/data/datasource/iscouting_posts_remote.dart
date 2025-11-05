import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../request/model/post_response_model.dart';
import '../request/param/get_posts_param.dart';
import '../request/param/get_post_by_id_param.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../mainapis.dart';

part 'scouting_posts_remote.dart';

abstract class IScoutingPostsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, PostsListResponseModel>> getPosts(
      GetPostsParam param);
  
  Future<Either<AppErrors, PostResponseModel>> getPostById(
      GetPostByIdParam param);
}

