import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_post_likes_param.dart';
import '../entity/like_response_entity.dart';
import '../repository/ilikes_repository.dart';

@singleton
class GetPostLikesUsecase extends UseCase<LikesListEntity, GetPostLikesParam> {
  final ILikesRepository repository;

  GetPostLikesUsecase(this.repository);

  @override
  Future<Result<AppErrors, LikesListEntity>> call(
      GetPostLikesParam param) async {
    return await repository.getPostLikes(param);
  }
}

