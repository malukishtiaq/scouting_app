import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/update_profile_param.dart';
import '../entity/member_response_entity.dart';
import '../repository/iaccount_repository.dart';

@singleton
class UpdateProfileUsecase
    extends UseCase<UpdateProfileResponseEntity, UpdateProfileParam> {
  final IAccountRepository repository;

  UpdateProfileUsecase(this.repository);

  @override
  Future<Result<AppErrors, UpdateProfileResponseEntity>> call(
      UpdateProfileParam param) async {
    return await repository.updateProfile(param);
  }
}

