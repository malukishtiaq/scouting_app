import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/models/empty_response.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/love_loop/reset_password_param.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

class ResetPasswordUseCase extends UseCase<EmptyResponse, ResetPasswordParam> {
  final IAccountRepository _accountRepository;

  ResetPasswordUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ResetPasswordParam param) async {
    return await _accountRepository.resetPassword(param);
  }
}
