import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_user_comments_param.dart';
import '../entity/comment_response_entity.dart';
import '../repository/icomments_repository.dart';

@singleton
class GetUserCommentsUsecase
    extends UseCase<CommentsListEntity, GetUserCommentsParam> {
  final ICommentsRepository repository;

  GetUserCommentsUsecase(this.repository);

  @override
  Future<Result<AppErrors, CommentsListEntity>> call(
      GetUserCommentsParam param) async {
    return await repository.getUserComments(param);
  }
}

