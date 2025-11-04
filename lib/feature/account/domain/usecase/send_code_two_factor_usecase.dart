import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/models/empty_response.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/love_loop/send_code_two_factor_param.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

class SendCodeTwoFactorUseCase extends UseCase<EmptyResponse, SendCodeTwoFactorParam> {
  final IAccountRepository _accountRepository;

  SendCodeTwoFactorUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(SendCodeTwoFactorParam param) async {
    return await _accountRepository.sendCodeTwoFactor(param);
  }
}
