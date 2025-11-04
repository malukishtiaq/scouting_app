import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/core/params/base_params.dart';
import 'package:scouting_app/feature/account/domain/entity/login_response_entity.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

/// Verification parameter for account verification
class VerifyAccountParam extends BaseParams {
  final String userId;
  final String code;
  final String typeCode; // "AccountSms" or "AccountEmail"

  VerifyAccountParam({
    required this.userId,
    required this.code,
    required this.typeCode,
  });

  @override
  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'code': code,
        'type_code': typeCode,
      };
}

@injectable
class VerifyAccountUseCase
    extends UseCase<AuthResponseEntity, VerifyAccountParam> {
  final IAccountRepository _accountRepository;

  VerifyAccountUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(
      VerifyAccountParam param) async {
    return await _accountRepository.verifyAccount(param);
  }
}
