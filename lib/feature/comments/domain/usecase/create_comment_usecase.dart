import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/create_comment_param.dart';
import '../entity/comment_response_entity.dart';
import '../repository/icomments_repository.dart';

@singleton
class CreateCommentUsecase
    extends UseCase<CommentResponseEntity, CreateCommentParam> {
  final ICommentsRepository repository;

  CreateCommentUsecase(this.repository);

  @override
  Future<Result<AppErrors, CommentResponseEntity>> call(
      CreateCommentParam param) async {
    return await repository.createComment(param);
  }
}

