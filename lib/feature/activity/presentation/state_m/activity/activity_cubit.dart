import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/di/service_locator.dart';
import 'package:scouting_app/feature/activity/data/request/param/list_activities_param.dart';
import 'package:scouting_app/feature/activity/data/request/param/respond_connection_param.dart';
import 'package:scouting_app/feature/activity/domain/entity/activity_entity.dart';
import 'package:scouting_app/feature/activity/domain/usecase/list_activities_usecase.dart';
import 'package:scouting_app/feature/activity/domain/usecase/respond_connection_usecase.dart';

part 'activity_cubit.freezed.dart';
part 'activity_state.dart';

@injectable
class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(const ActivityState.activityInit());

  // Current activities list
  ActivityListEntity? _currentActivityListEntity;
  ActivityListEntity? get currentActivityListEntity => _currentActivityListEntity;

  // ========== ACTIVITY API METHODS ==========

  /// Load activities list
  void loadActivities({
    int page = 1,
    int perPage = 20,
    String? type,
    bool? unreadOnly,
  }) async {
    emit(const ActivityState.activityLoading());

    try {
      final param = ListActivitiesParam(
        page: page,
        perPage: perPage,
        type: type,
        unreadOnly: unreadOnly,
      );

      final result = await getIt<ListActivitiesUsecase>()(param);

      result.pick(
        onData: (data) {
          _currentActivityListEntity = data;
          emit(ActivityState.activitiesLoaded(data));
        },
        onError: (error) {
          emit(ActivityState.activityError(
            error,
            () => loadActivities(
              page: page,
              perPage: perPage,
              type: type,
              unreadOnly: unreadOnly,
            ),
          ));
        },
      );
    } catch (e) {
      emit(ActivityState.activityError(
        const AppErrors.connectionError(),
        () => loadActivities(
          page: page,
          perPage: perPage,
          type: type,
          unreadOnly: unreadOnly,
        ),
      ));
    }
  }

  /// Respond to connection request
  void respondToConnection({
    required int activityId,
    required bool accept,
  }) async {
    try {
      final param = RespondConnectionParam(
        activityId: activityId,
        accept: accept,
      );

      final result = await getIt<RespondConnectionUsecase>()(param);

      result.pick(
        onData: (data) {
          emit(ActivityState.connectionResponded(data));
          // Reload activities to update the list
          loadActivities();
        },
        onError: (error) {
          emit(ActivityState.activityError(
            error,
            () => respondToConnection(
              activityId: activityId,
              accept: accept,
            ),
          ));
        },
      );
    } catch (e) {
      emit(ActivityState.activityError(
        const AppErrors.connectionError(),
        () => respondToConnection(
          activityId: activityId,
          accept: accept,
        ),
      ));
    }
  }
}

