import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/models/empty_response.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/love_loop/logout_param.dart';
import '../repository/iaccount_repository.dart';

@singleton
class LogoutUsecase extends UseCase<EmptyResponse, LogoutParam> {
  final IAccountRepository repository;

  LogoutUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(LogoutParam param) async {
    return await repository.logout(param);
  }
}
