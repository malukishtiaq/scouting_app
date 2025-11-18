import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';
import 'package:scouting_app/feature/activity/domain/repository/iactivity_repository.dart';

@singleton
class RespondConnectionUsecase
    extends UseCase<ActivityEntity, RespondConnectionParam> {
  final IActivityRepository repository;

  RespondConnectionUsecase(this.repository);

  @override
  Future<Result<AppErrors, ActivityEntity>> call(
      RespondConnectionParam param) async {
    return await repository.respondToConnection(param);
  }
}

