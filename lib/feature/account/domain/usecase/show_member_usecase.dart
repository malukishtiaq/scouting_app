import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/show_member_param.dart';
import '../entity/member_response_entity.dart';
import '../repository/iaccount_repository.dart';

@singleton
class ShowMemberUsecase extends UseCase<MemberProfileEntity, ShowMemberParam> {
  final IAccountRepository repository;

  ShowMemberUsecase(this.repository);

  @override
  Future<Result<AppErrors, MemberProfileEntity>> call(
      ShowMemberParam param) async {
    return await repository.showMember(param);
  }
}

