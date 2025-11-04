import 'package:injectable/injectable.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/login_param.dart';
import '../entity/login_response_entity.dart';
import '../repository/iaccount_repository.dart';

/// Login use case that handles different response types based on Xamarin's logic:
/// - Successful login: Returns user data and access token
/// - Pending verification: Returns user ID for 2FA verification
/// - Error: Returns specific error details
@singleton
class LoginUsecase extends UseCase<AuthResponseEntity, LoginParam> {
  final IAccountRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> call(LoginParam param) async {
    return await repository.login(param);
  }
}
