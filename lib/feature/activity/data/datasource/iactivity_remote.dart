import 'package:dartz/dartz.dart';
import 'package:scouting_app/core/datasources/remote_data_source.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/feature/activity/data/request/model/activity_model.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';

abstract class IActivityRemoteSource extends RemoteDataSource {
  /// List all activities
  /// GET /api/activities
  Future<Either<AppErrors, ActivityListModel>> listActivities(
      ListActivitiesParam param);

  /// Respond to connection request
  /// POST /api/activities/{activity_id}/respond
  Future<Either<AppErrors, ActivityModel>> respondToConnection(
      RespondConnectionParam param);
}

