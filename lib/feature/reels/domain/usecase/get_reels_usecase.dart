import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_reels_param.dart';
import '../entity/reels_response_entity.dart';
import '../repositories/ireels_repository.dart';

/// Get reels use case that fetches random video reels
@singleton
class GetReelsUsecase extends UseCase<ReelsResponseEntity, GetReelsParam> {
  final IReelsRepository repository;

  GetReelsUsecase(this.repository);

  @override
  Future<Result<AppErrors, ReelsResponseEntity>> call(
      GetReelsParam param) async {
    return await repository.getReels(param);
  }
}
