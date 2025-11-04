import 'package:injectable/injectable.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/entities/empty_response_entity.dart';
import '../repositories/iuser_profile_repository.dart';
import '../../data/request/param/update_cover_param.dart';

@singleton
class UpdateCoverUseCase
    extends UseCase<EmptyResponseEntity, UpdateCoverParam> {
  final IUserProfileRepository repository;

  UpdateCoverUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      UpdateCoverParam param) async {
    return await repository.updateCover(param);
  }
}
