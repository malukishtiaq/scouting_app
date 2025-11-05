import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/toggle_like_param.dart';
import '../entity/like_response_entity.dart';
import '../repository/ilikes_repository.dart';

@singleton
class ToggleLikeUsecase extends UseCase<LikeResponseEntity, ToggleLikeParam> {
  final ILikesRepository repository;

  ToggleLikeUsecase(this.repository);

  @override
  Future<Result<AppErrors, LikeResponseEntity>> call(
      ToggleLikeParam param) async {
    return await repository.toggleLike(param);
  }
}

