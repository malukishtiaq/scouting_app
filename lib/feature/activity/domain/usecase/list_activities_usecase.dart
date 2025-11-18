import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';
import 'package:scouting_app/feature/activity/domain/repository/iactivity_repository.dart';

@singleton
class ListActivitiesUsecase
    extends UseCase<ActivityListEntity, ListActivitiesParam> {
  final IActivityRepository repository;

  ListActivitiesUsecase(this.repository);

  @override
  Future<Result<AppErrors, ActivityListEntity>> call(
      ListActivitiesParam param) async {
    return await repository.listActivities(param);
  }
}

