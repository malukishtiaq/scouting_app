import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/love_loop/register_param.dart';
import '../entity/login_response_entity.dart';
import '../repository/iaccount_repository.dart';

/// Member Register use case for Scouting API
/// Uses /api/members/register endpoint
@singleton
class MemberRegisterUsecase extends UseCase<AuthResponseEntity, RegisterParam> {
  final IAccountRepository repository;

  MemberRegisterUsecase(this.repository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(
      RegisterParam param) async {
    return await repository.memberRegister(param);
  }
}

