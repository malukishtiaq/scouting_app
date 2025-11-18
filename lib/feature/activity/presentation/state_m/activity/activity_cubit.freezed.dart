// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActivityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityStateCopyWith<$Res> {
  factory $ActivityStateCopyWith(
          ActivityState value, $Res Function(ActivityState) then) =
      _$ActivityStateCopyWithImpl<$Res, ActivityState>;
}

/// @nodoc
class _$ActivityStateCopyWithImpl<$Res, $Val extends ActivityState>
    implements $ActivityStateCopyWith<$Res> {
  _$ActivityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActivityInitImplCopyWith<$Res> {
  factory _$$ActivityInitImplCopyWith(
          _$ActivityInitImpl value, $Res Function(_$ActivityInitImpl) then) =
      __$$ActivityInitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActivityInitImplCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$ActivityInitImpl>
    implements _$$ActivityInitImplCopyWith<$Res> {
  __$$ActivityInitImplCopyWithImpl(
      _$ActivityInitImpl _value, $Res Function(_$ActivityInitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActivityInitImpl implements ActivityInit {
  const _$ActivityInitImpl();

  @override
  String toString() {
    return 'ActivityState.activityInit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActivityInitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) {
    return activityInit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) {
    return activityInit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityInit != null) {
      return activityInit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) {
    return activityInit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) {
    return activityInit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityInit != null) {
      return activityInit(this);
    }
    return orElse();
  }
}

abstract class ActivityInit implements ActivityState {
  const factory ActivityInit() = _$ActivityInitImpl;
}

/// @nodoc
abstract class _$$ActivityLoadingImplCopyWith<$Res> {
  factory _$$ActivityLoadingImplCopyWith(_$ActivityLoadingImpl value,
          $Res Function(_$ActivityLoadingImpl) then) =
      __$$ActivityLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActivityLoadingImplCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$ActivityLoadingImpl>
    implements _$$ActivityLoadingImplCopyWith<$Res> {
  __$$ActivityLoadingImplCopyWithImpl(
      _$ActivityLoadingImpl _value, $Res Function(_$ActivityLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActivityLoadingImpl implements ActivityLoading {
  const _$ActivityLoadingImpl();

  @override
  String toString() {
    return 'ActivityState.activityLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActivityLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) {
    return activityLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) {
    return activityLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityLoading != null) {
      return activityLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) {
    return activityLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) {
    return activityLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityLoading != null) {
      return activityLoading(this);
    }
    return orElse();
  }
}

abstract class ActivityLoading implements ActivityState {
  const factory ActivityLoading() = _$ActivityLoadingImpl;
}

/// @nodoc
abstract class _$$ActivityErrorImplCopyWith<$Res> {
  factory _$$ActivityErrorImplCopyWith(
          _$ActivityErrorImpl value, $Res Function(_$ActivityErrorImpl) then) =
      __$$ActivityErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppErrors error, VoidCallback callback});

  $AppErrorsCopyWith<$Res> get error;
}

/// @nodoc
class __$$ActivityErrorImplCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$ActivityErrorImpl>
    implements _$$ActivityErrorImplCopyWith<$Res> {
  __$$ActivityErrorImplCopyWithImpl(
      _$ActivityErrorImpl _value, $Res Function(_$ActivityErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? callback = null,
  }) {
    return _then(_$ActivityErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppErrors,
      null == callback
          ? _value.callback
          : callback // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AppErrorsCopyWith<$Res> get error {
    return $AppErrorsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$ActivityErrorImpl implements ActivityError {
  const _$ActivityErrorImpl(this.error, this.callback);

  @override
  final AppErrors error;
  @override
  final VoidCallback callback;

  @override
  String toString() {
    return 'ActivityState.activityError(error: $error, callback: $callback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.callback, callback) ||
                other.callback == callback));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, callback);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityErrorImplCopyWith<_$ActivityErrorImpl> get copyWith =>
      __$$ActivityErrorImplCopyWithImpl<_$ActivityErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) {
    return activityError(error, callback);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) {
    return activityError?.call(error, callback);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityError != null) {
      return activityError(error, callback);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) {
    return activityError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) {
    return activityError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activityError != null) {
      return activityError(this);
    }
    return orElse();
  }
}

abstract class ActivityError implements ActivityState {
  const factory ActivityError(
      final AppErrors error, final VoidCallback callback) = _$ActivityErrorImpl;

  AppErrors get error;
  VoidCallback get callback;
  @JsonKey(ignore: true)
  _$$ActivityErrorImplCopyWith<_$ActivityErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActivitiesLoadedStateImplCopyWith<$Res> {
  factory _$$ActivitiesLoadedStateImplCopyWith(
          _$ActivitiesLoadedStateImpl value,
          $Res Function(_$ActivitiesLoadedStateImpl) then) =
      __$$ActivitiesLoadedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ActivityListEntity activityListEntity});
}

/// @nodoc
class __$$ActivitiesLoadedStateImplCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$ActivitiesLoadedStateImpl>
    implements _$$ActivitiesLoadedStateImplCopyWith<$Res> {
  __$$ActivitiesLoadedStateImplCopyWithImpl(_$ActivitiesLoadedStateImpl _value,
      $Res Function(_$ActivitiesLoadedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityListEntity = null,
  }) {
    return _then(_$ActivitiesLoadedStateImpl(
      null == activityListEntity
          ? _value.activityListEntity
          : activityListEntity // ignore: cast_nullable_to_non_nullable
              as ActivityListEntity,
    ));
  }
}

/// @nodoc

class _$ActivitiesLoadedStateImpl implements ActivitiesLoadedState {
  const _$ActivitiesLoadedStateImpl(this.activityListEntity);

  @override
  final ActivityListEntity activityListEntity;

  @override
  String toString() {
    return 'ActivityState.activitiesLoaded(activityListEntity: $activityListEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivitiesLoadedStateImpl &&
            (identical(other.activityListEntity, activityListEntity) ||
                other.activityListEntity == activityListEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activityListEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivitiesLoadedStateImplCopyWith<_$ActivitiesLoadedStateImpl>
      get copyWith => __$$ActivitiesLoadedStateImplCopyWithImpl<
          _$ActivitiesLoadedStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) {
    return activitiesLoaded(activityListEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) {
    return activitiesLoaded?.call(activityListEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activitiesLoaded != null) {
      return activitiesLoaded(activityListEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) {
    return activitiesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) {
    return activitiesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) {
    if (activitiesLoaded != null) {
      return activitiesLoaded(this);
    }
    return orElse();
  }
}

abstract class ActivitiesLoadedState implements ActivityState {
  const factory ActivitiesLoadedState(
          final ActivityListEntity activityListEntity) =
      _$ActivitiesLoadedStateImpl;

  ActivityListEntity get activityListEntity;
  @JsonKey(ignore: true)
  _$$ActivitiesLoadedStateImplCopyWith<_$ActivitiesLoadedStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionRespondedStateImplCopyWith<$Res> {
  factory _$$ConnectionRespondedStateImplCopyWith(
          _$ConnectionRespondedStateImpl value,
          $Res Function(_$ConnectionRespondedStateImpl) then) =
      __$$ConnectionRespondedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ActivityEntity activityEntity});
}

/// @nodoc
class __$$ConnectionRespondedStateImplCopyWithImpl<$Res>
    extends _$ActivityStateCopyWithImpl<$Res, _$ConnectionRespondedStateImpl>
    implements _$$ConnectionRespondedStateImplCopyWith<$Res> {
  __$$ConnectionRespondedStateImplCopyWithImpl(
      _$ConnectionRespondedStateImpl _value,
      $Res Function(_$ConnectionRespondedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityEntity = null,
  }) {
    return _then(_$ConnectionRespondedStateImpl(
      null == activityEntity
          ? _value.activityEntity
          : activityEntity // ignore: cast_nullable_to_non_nullable
              as ActivityEntity,
    ));
  }
}

/// @nodoc

class _$ConnectionRespondedStateImpl implements ConnectionRespondedState {
  const _$ConnectionRespondedStateImpl(this.activityEntity);

  @override
  final ActivityEntity activityEntity;

  @override
  String toString() {
    return 'ActivityState.connectionResponded(activityEntity: $activityEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRespondedStateImpl &&
            (identical(other.activityEntity, activityEntity) ||
                other.activityEntity == activityEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activityEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionRespondedStateImplCopyWith<_$ConnectionRespondedStateImpl>
      get copyWith => __$$ConnectionRespondedStateImplCopyWithImpl<
          _$ConnectionRespondedStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() activityInit,
    required TResult Function() activityLoading,
    required TResult Function(AppErrors error, VoidCallback callback)
        activityError,
    required TResult Function(ActivityListEntity activityListEntity)
        activitiesLoaded,
    required TResult Function(ActivityEntity activityEntity)
        connectionResponded,
  }) {
    return connectionResponded(activityEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? activityInit,
    TResult? Function()? activityLoading,
    TResult? Function(AppErrors error, VoidCallback callback)? activityError,
    TResult? Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult? Function(ActivityEntity activityEntity)? connectionResponded,
  }) {
    return connectionResponded?.call(activityEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? activityInit,
    TResult Function()? activityLoading,
    TResult Function(AppErrors error, VoidCallback callback)? activityError,
    TResult Function(ActivityListEntity activityListEntity)? activitiesLoaded,
    TResult Function(ActivityEntity activityEntity)? connectionResponded,
    required TResult orElse(),
  }) {
    if (connectionResponded != null) {
      return connectionResponded(activityEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActivityInit value) activityInit,
    required TResult Function(ActivityLoading value) activityLoading,
    required TResult Function(ActivityError value) activityError,
    required TResult Function(ActivitiesLoadedState value) activitiesLoaded,
    required TResult Function(ConnectionRespondedState value)
        connectionResponded,
  }) {
    return connectionResponded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActivityInit value)? activityInit,
    TResult? Function(ActivityLoading value)? activityLoading,
    TResult? Function(ActivityError value)? activityError,
    TResult? Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult? Function(ConnectionRespondedState value)? connectionResponded,
  }) {
    return connectionResponded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActivityInit value)? activityInit,
    TResult Function(ActivityLoading value)? activityLoading,
    TResult Function(ActivityError value)? activityError,
    TResult Function(ActivitiesLoadedState value)? activitiesLoaded,
    TResult Function(ConnectionRespondedState value)? connectionResponded,
    required TResult orElse(),
  }) {
    if (connectionResponded != null) {
      return connectionResponded(this);
    }
    return orElse();
  }
}

abstract class ConnectionRespondedState implements ActivityState {
  const factory ConnectionRespondedState(final ActivityEntity activityEntity) =
      _$ConnectionRespondedStateImpl;

  ActivityEntity get activityEntity;
  @JsonKey(ignore: true)
  _$$ConnectionRespondedStateImplCopyWith<_$ConnectionRespondedStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
