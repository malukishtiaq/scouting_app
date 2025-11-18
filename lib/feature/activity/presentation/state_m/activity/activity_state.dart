part of 'activity_cubit.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState.activityInit() = ActivityInit;
  const factory ActivityState.activityLoading() = ActivityLoading;
  const factory ActivityState.activityError(
    AppErrors error,
    VoidCallback callback,
  ) = ActivityError;

  const factory ActivityState.activitiesLoaded(
    ActivityListEntity activityListEntity,
  ) = ActivitiesLoadedState;

  const factory ActivityState.connectionResponded(
    ActivityEntity activityEntity,
  ) = ConnectionRespondedState;
}

