import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_posts_param.dart';
import '../entity/posts_response_entity.dart';
import '../repositories/iposts_repository.dart';

@injectable
class GetPostsUsecase extends UseCase<PostsResponseEntity, GetPostsParam> {
  final IPostsRepository _repository;

  GetPostsUsecase(this._repository);

  @override
  Future<Result<AppErrors, PostsResponseEntity>> call(
      GetPostsParam param) async {
    return await _repository.getPosts(param);
  }
}
