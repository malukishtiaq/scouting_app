import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/repositories/repository.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';

abstract class IActivityRepository extends Repository {
  /// List all activities
  /// GET /api/activities
  Future<Result<AppErrors, ActivityListEntity>> listActivities(
      ListActivitiesParam param);

  /// Respond to connection request
  /// POST /api/activities/{activity_id}/respond
  Future<Result<AppErrors, ActivityEntity>> respondToConnection(
      RespondConnectionParam param);
}

