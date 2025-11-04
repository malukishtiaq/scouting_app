import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/love_loop/two_factor_param.dart';
import 'package:scouting_app/feature/account/domain/entity/login_response_entity.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

@injectable
class TwoFactorUseCase extends UseCase<AuthResponseEntity, TwoFactorParam> {
  final IAccountRepository _accountRepository;

  TwoFactorUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(
      TwoFactorParam param) async {
    return await _accountRepository.twoFactor(param);
  }
}
