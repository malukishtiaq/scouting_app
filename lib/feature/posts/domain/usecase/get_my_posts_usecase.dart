import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_posts_param.dart';
import '../entity/posts_response_entity.dart';
import '../repositories/iposts_repository.dart';

@lazySingleton
class GetMyPostsUsecase extends UseCase<PostsResponseEntity, GetPostsParam> {
  final IPostsRepository repository;

  GetMyPostsUsecase(this.repository);

  @override
  Future<Result<AppErrors, PostsResponseEntity>> call(
      GetPostsParam param) async {
    return await repository.getMyPosts(param);
  }
}
