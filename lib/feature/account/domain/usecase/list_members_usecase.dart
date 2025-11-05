import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/list_members_param.dart';
import '../entity/member_response_entity.dart';
import '../repository/iaccount_repository.dart';

@singleton
class ListMembersUsecase extends UseCase<MembersListEntity, ListMembersParam> {
  final IAccountRepository repository;

  ListMembersUsecase(this.repository);

  @override
  Future<Result<AppErrors, MembersListEntity>> call(
      ListMembersParam param) async {
    return await repository.listMembers(param);
  }
}

