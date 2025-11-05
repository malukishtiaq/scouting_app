import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_me_param.dart';
import '../entity/member_response_entity.dart';
import '../repository/iaccount_repository.dart';

@singleton
class GetMeUsecase extends UseCase<MemberProfileEntity, GetMeParam> {
  final IAccountRepository repository;

  GetMeUsecase(this.repository);

  @override
  Future<Result<AppErrors, MemberProfileEntity>> call(GetMeParam param) async {
    return await repository.getMe(param);
  }
}

