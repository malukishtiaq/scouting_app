import 'package:injectable/injectable.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/models/empty_response.dart';
import '../../data/request/param/love_loop/delete_account_param.dart';
import '../repository/iaccount_repository.dart';

@singleton
class DeleteAccountUsecase extends UseCase<EmptyResponse, DeleteAccountParam> {
  final IAccountRepository repository;

  DeleteAccountUsecase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      DeleteAccountParam param) async {
    return await repository.deleteAccount(param);
  }
}
