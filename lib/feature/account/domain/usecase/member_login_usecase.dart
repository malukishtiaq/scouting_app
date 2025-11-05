import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/login_param.dart';
import '../entity/login_response_entity.dart';
import '../repository/iaccount_repository.dart';

/// Member Login use case for Scouting API
/// Uses /api/members/login endpoint
@singleton
class MemberLoginUsecase extends UseCase<AuthResponseEntity, LoginParam> {
  final IAccountRepository repository;

  MemberLoginUsecase(this.repository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(LoginParam param) async {
    return await repository.memberLogin(param);
  }
}

