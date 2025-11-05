import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_user_likes_param.dart';
import '../entity/like_response_entity.dart';
import '../repository/ilikes_repository.dart';

@singleton
class GetUserLikesUsecase
    extends UseCase<LikesListEntity, GetUserLikesParam> {
  final ILikesRepository repository;

  GetUserLikesUsecase(this.repository);

  @override
  Future<Result<AppErrors, LikesListEntity>> call(
      GetUserLikesParam param) async {
    return await repository.getUserLikes(param);
  }
}

