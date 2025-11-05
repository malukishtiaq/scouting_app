import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/scouting_login_param.dart';
import '../entity/auth_response_entity.dart' as Scouting;
import '../repository/iaccount_repository.dart';

/// Member Login use case for Scouting API
/// Uses /api/members/login endpoint
@singleton
class MemberLoginUsecase extends UseCase<Scouting.AuthResponseEntity, ScoutingLoginParam> {
  final IAccountRepository repository;

  MemberLoginUsecase(this.repository);

  @override
  Future<Result<AppErrors, Scouting.AuthResponseEntity>> call(ScoutingLoginParam param) async {
    return await repository.memberLogin(param);
  }
}
