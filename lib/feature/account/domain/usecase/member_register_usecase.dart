import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/scouting_register_param.dart';
import '../entity/auth_response_entity.dart' as Scouting;
import '../repository/iaccount_repository.dart';

/// Member Register use case for Scouting API
/// Uses /api/members/register endpoint
@singleton
class MemberRegisterUsecase extends UseCase<Scouting.AuthResponseEntity, ScoutingRegisterParam> {
  final IAccountRepository repository;

  MemberRegisterUsecase(this.repository);

  @override
  Future<Result<AppErrors, Scouting.AuthResponseEntity>> call(
      ScoutingRegisterParam param) async {
    return await repository.memberRegister(param);
  }
}
