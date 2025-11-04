import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/love_loop/replace_password_param.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

import '../../../../core/models/empty_response.dart';

class ReplacePasswordUseCase extends UseCase<EmptyResponse, ReplacePasswordParam> {
  final IAccountRepository _accountRepository;

  ReplacePasswordUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(ReplacePasswordParam param) async {
    return await _accountRepository.replacePassword(param);
  }
}
