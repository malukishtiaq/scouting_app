import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_post_by_id_param.dart';
import '../entity/post_response_entity.dart';
import '../repository/iscouting_posts_repository.dart';

@singleton
class GetPostByIdUsecase
    extends UseCase<PostResponseEntity, GetPostByIdParam> {
  final IScoutingPostsRepository repository;

  GetPostByIdUsecase(this.repository);

  @override
  Future<Result<AppErrors, PostResponseEntity>> call(
      GetPostByIdParam param) async {
    return await repository.getPostById(param);
  }
}

