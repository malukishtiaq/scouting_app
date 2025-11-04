import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/account/data/request/param/social_login_param.dart';
import 'package:scouting_app/feature/account/domain/entity/login_response_entity.dart';
import 'package:scouting_app/feature/account/domain/repository/iaccount_repository.dart';

/// Social Login Use Case
/// Handles business logic for social media authentication
@injectable
class SocialLoginUseCase extends UseCase<AuthResponseEntity, SocialLoginParam> {
  final IAccountRepository _accountRepository;

  SocialLoginUseCase(this._accountRepository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(
      SocialLoginParam param) async {
    return await _accountRepository.socialLogin(param);
  }
}
