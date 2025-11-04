import 'package:injectable/injectable.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/entities/empty_response_entity.dart';
import '../repositories/iuser_profile_repository.dart';
import '../../data/request/param/update_avatar_param.dart';

@singleton
class UpdateAvatarUseCase
    extends UseCase<EmptyResponseEntity, UpdateAvatarParam> {
  final IUserProfileRepository repository;

  UpdateAvatarUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      UpdateAvatarParam param) async {
    return await repository.updateAvatar(param);
  }
}
