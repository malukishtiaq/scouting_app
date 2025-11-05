import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_post_comments_param.dart';
import '../entity/comment_response_entity.dart';
import '../repository/icomments_repository.dart';

@singleton
class GetPostCommentsUsecase
    extends UseCase<CommentsListEntity, GetPostCommentsParam> {
  final ICommentsRepository repository;

  GetPostCommentsUsecase(this.repository);

  @override
  Future<Result<AppErrors, CommentsListEntity>> call(
      GetPostCommentsParam param) async {
    return await repository.getPostComments(param);
  }
}

