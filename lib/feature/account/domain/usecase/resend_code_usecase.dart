import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/models/empty_response.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/resend_code_param.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

class ResendCodeUseCase extends UseCase<EmptyResponse, ResendCodeParam> {
  final IAccountRepository _accountRepository;

  ResendCodeUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ResendCodeParam param) async {
    return await _accountRepository.resendCode(param);
  }
}
