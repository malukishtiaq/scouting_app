import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/models/empty_response.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/love_loop/resend_email_param.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

class ResendEmailUseCase extends UseCase<EmptyResponse, ResendEmailParam> {
  final IAccountRepository _accountRepository;

  ResendEmailUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ResendEmailParam param) async {
    return await _accountRepository.resendEmail(param);
  }
}
