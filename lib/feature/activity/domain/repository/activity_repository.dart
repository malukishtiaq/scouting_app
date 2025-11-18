import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/feature/activity/data/datasource/iactivity_remote.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';
import 'package:scouting_app/feature/activity/domain/repository/iactivity_repository.dart';

@Injectable(as: IActivityRepository)
class ActivityRepository extends IActivityRepository {
  final IActivityRemoteSource remoteDataSource;

  ActivityRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, ActivityListEntity>> listActivities(
      ListActivitiesParam param) async {
    final result = await remoteDataSource.listActivities(param);

    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, ActivityEntity>> respondToConnection(
      RespondConnectionParam param) async {
    final result = await remoteDataSource.respondToConnection(param);

    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }
}

