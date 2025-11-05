import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_posts_param.dart';
import '../entity/post_response_entity.dart';
import '../repository/iscouting_posts_repository.dart';

@singleton
class GetPostsUsecase
    extends UseCase<PostsListResponseEntity, GetPostsParam> {
  final IScoutingPostsRepository repository;

  GetPostsUsecase(this.repository);

  @override
  Future<Result<AppErrors, PostsListResponseEntity>> call(
      GetPostsParam param) async {
    return await repository.getPosts(param);
  }
}

