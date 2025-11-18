import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/feature/activity/data/request/model/activity_model.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';
import 'package:scouting_app/feature/activity/data/datasource/iactivity_remote.dart';

@Injectable(as: IActivityRemoteSource)
class ActivityRemoteSource extends IActivityRemoteSource {
  @override
  Future<Either<AppErrors, ActivityListModel>> listActivities(
      ListActivitiesParam param) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final mockJsonResponse = {
      'success': true,
      'message': 'Activities fetched successfully',
      'data': [
        {
          'id': 1,
          'type': 'connection_request',
          'title': 'Alex Morgan sent you a connection',
          'timestamp': '1d',
          'avatar_url': 'https://i.pravatar.cc/150?img=12',
          'user_id': 1,
          'user_name': 'Alex Morgan',
          'has_actions': true,
          'is_read': false,
        },
        {
          'id': 2,
          'type': 'post_liked',
          'title': 'Your post about the game was liked',
          'timestamp': '2d',
          'icon_name': 'heart',
          'has_actions': false,
          'is_read': false,
        },
        {
          'id': 3,
          'type': 'new_follower',
          'title': 'You have a new follower, Ethan Hunt.',
          'timestamp': '3d',
          'avatar_url': 'https://i.pravatar.cc/150?img=13',
          'has_actions': false,
          'is_read': false,
        },
        {
          'id': 4,
          'type': 'game_notification',
          'title': "Your game 'City League Final' is",
          'timestamp': '4d',
          'icon_name': 'settings',
          'has_actions': false,
          'is_read': false,
        },
      ],
      'total': 4,
      'current_page': 1,
      'last_page': 1,
    };

    try {
      final model = ActivityListModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppErrors, ActivityModel>> respondToConnection(
      RespondConnectionParam param) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final mockJsonResponse = {
      'id': param.activityId,
      'type': 'connection_request',
      'title': param.accept
          ? 'Connection request accepted'
          : 'Connection request declined',
      'timestamp': 'now',
      'has_actions': false,
      'is_read': true,
    };

    try {
      final model = ActivityModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }
}

