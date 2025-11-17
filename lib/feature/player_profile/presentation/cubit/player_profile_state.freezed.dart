// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MemberDataEntity player) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MemberDataEntity player)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MemberDataEntity player)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerProfileInitial value) initial,
    required TResult Function(PlayerProfileLoading value) loading,
    required TResult Function(PlayerProfileLoaded value) loaded,
    required TResult Function(PlayerProfileError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerProfileInitial value)? initial,
    TResult? Function(PlayerProfileLoading value)? loading,
    TResult? Function(PlayerProfileLoaded value)? loaded,
    TResult? Function(PlayerProfileError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerProfileInitial value)? initial,
    TResult Function(PlayerProfileLoading value)? loading,
    TResult Function(PlayerProfileLoaded value)? loaded,
    TResult Function(PlayerProfileError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerProfileStateCopyWith<$Res> {
  factory $PlayerProfileStateCopyWith(
          PlayerProfileState value, $Res Function(PlayerProfileState) then) =
      _$PlayerProfileStateCopyWithImpl<$Res, PlayerProfileState>;
}

/// @nodoc
class _$PlayerProfileStateCopyWithImpl<$Res, $Val extends PlayerProfileState>
    implements $PlayerProfileStateCopyWith<$Res> {
  _$PlayerProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PlayerProfileInitialImplCopyWith<$Res> {
  factory _$$PlayerProfileInitialImplCopyWith(_$PlayerProfileInitialImpl value,
          $Res Function(_$PlayerProfileInitialImpl) then) =
      __$$PlayerProfileInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayerProfileInitialImplCopyWithImpl<$Res>
    extends _$PlayerProfileStateCopyWithImpl<$Res, _$PlayerProfileInitialImpl>
    implements _$$PlayerProfileInitialImplCopyWith<$Res> {
  __$$PlayerProfileInitialImplCopyWithImpl(_$PlayerProfileInitialImpl _value,
      $Res Function(_$PlayerProfileInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PlayerProfileInitialImpl implements PlayerProfileInitial {
  const _$PlayerProfileInitialImpl();

  @override
  String toString() {
    return 'PlayerProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MemberDataEntity player) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MemberDataEntity player)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MemberDataEntity player)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerProfileInitial value) initial,
    required TResult Function(PlayerProfileLoading value) loading,
    required TResult Function(PlayerProfileLoaded value) loaded,
    required TResult Function(PlayerProfileError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerProfileInitial value)? initial,
    TResult? Function(PlayerProfileLoading value)? loading,
    TResult? Function(PlayerProfileLoaded value)? loaded,
    TResult? Function(PlayerProfileError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerProfileInitial value)? initial,
    TResult Function(PlayerProfileLoading value)? loading,
    TResult Function(PlayerProfileLoaded value)? loaded,
    TResult Function(PlayerProfileError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PlayerProfileInitial implements PlayerProfileState {
  const factory PlayerProfileInitial() = _$PlayerProfileInitialImpl;
}

/// @nodoc
abstract class _$$PlayerProfileLoadingImplCopyWith<$Res> {
  factory _$$PlayerProfileLoadingImplCopyWith(_$PlayerProfileLoadingImpl value,
          $Res Function(_$PlayerProfileLoadingImpl) then) =
      __$$PlayerProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayerProfileLoadingImplCopyWithImpl<$Res>
    extends _$PlayerProfileStateCopyWithImpl<$Res, _$PlayerProfileLoadingImpl>
    implements _$$PlayerProfileLoadingImplCopyWith<$Res> {
  __$$PlayerProfileLoadingImplCopyWithImpl(_$PlayerProfileLoadingImpl _value,
      $Res Function(_$PlayerProfileLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PlayerProfileLoadingImpl implements PlayerProfileLoading {
  const _$PlayerProfileLoadingImpl();

  @override
  String toString() {
    return 'PlayerProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MemberDataEntity player) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MemberDataEntity player)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MemberDataEntity player)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerProfileInitial value) initial,
    required TResult Function(PlayerProfileLoading value) loading,
    required TResult Function(PlayerProfileLoaded value) loaded,
    required TResult Function(PlayerProfileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerProfileInitial value)? initial,
    TResult? Function(PlayerProfileLoading value)? loading,
    TResult? Function(PlayerProfileLoaded value)? loaded,
    TResult? Function(PlayerProfileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerProfileInitial value)? initial,
    TResult Function(PlayerProfileLoading value)? loading,
    TResult Function(PlayerProfileLoaded value)? loaded,
    TResult Function(PlayerProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PlayerProfileLoading implements PlayerProfileState {
  const factory PlayerProfileLoading() = _$PlayerProfileLoadingImpl;
}

/// @nodoc
abstract class _$$PlayerProfileLoadedImplCopyWith<$Res> {
  factory _$$PlayerProfileLoadedImplCopyWith(_$PlayerProfileLoadedImpl value,
          $Res Function(_$PlayerProfileLoadedImpl) then) =
      __$$PlayerProfileLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MemberDataEntity player});
}

/// @nodoc
class __$$PlayerProfileLoadedImplCopyWithImpl<$Res>
    extends _$PlayerProfileStateCopyWithImpl<$Res, _$PlayerProfileLoadedImpl>
    implements _$$PlayerProfileLoadedImplCopyWith<$Res> {
  __$$PlayerProfileLoadedImplCopyWithImpl(_$PlayerProfileLoadedImpl _value,
      $Res Function(_$PlayerProfileLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
  }) {
    return _then(_$PlayerProfileLoadedImpl(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as MemberDataEntity,
    ));
  }
}

/// @nodoc

class _$PlayerProfileLoadedImpl implements PlayerProfileLoaded {
  const _$PlayerProfileLoadedImpl({required this.player});

  @override
  final MemberDataEntity player;

  @override
  String toString() {
    return 'PlayerProfileState.loaded(player: $player)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileLoadedImpl &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerProfileLoadedImplCopyWith<_$PlayerProfileLoadedImpl> get copyWith =>
      __$$PlayerProfileLoadedImplCopyWithImpl<_$PlayerProfileLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MemberDataEntity player) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(player);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MemberDataEntity player)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(player);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MemberDataEntity player)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(player);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerProfileInitial value) initial,
    required TResult Function(PlayerProfileLoading value) loading,
    required TResult Function(PlayerProfileLoaded value) loaded,
    required TResult Function(PlayerProfileError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerProfileInitial value)? initial,
    TResult? Function(PlayerProfileLoading value)? loading,
    TResult? Function(PlayerProfileLoaded value)? loaded,
    TResult? Function(PlayerProfileError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerProfileInitial value)? initial,
    TResult Function(PlayerProfileLoading value)? loading,
    TResult Function(PlayerProfileLoaded value)? loaded,
    TResult Function(PlayerProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PlayerProfileLoaded implements PlayerProfileState {
  const factory PlayerProfileLoaded({required final MemberDataEntity player}) =
      _$PlayerProfileLoadedImpl;

  MemberDataEntity get player;
  @JsonKey(ignore: true)
  _$$PlayerProfileLoadedImplCopyWith<_$PlayerProfileLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayerProfileErrorImplCopyWith<$Res> {
  factory _$$PlayerProfileErrorImplCopyWith(_$PlayerProfileErrorImpl value,
          $Res Function(_$PlayerProfileErrorImpl) then) =
      __$$PlayerProfileErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PlayerProfileErrorImplCopyWithImpl<$Res>
    extends _$PlayerProfileStateCopyWithImpl<$Res, _$PlayerProfileErrorImpl>
    implements _$$PlayerProfileErrorImplCopyWith<$Res> {
  __$$PlayerProfileErrorImplCopyWithImpl(_$PlayerProfileErrorImpl _value,
      $Res Function(_$PlayerProfileErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PlayerProfileErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PlayerProfileErrorImpl implements PlayerProfileError {
  const _$PlayerProfileErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'PlayerProfileState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerProfileErrorImplCopyWith<_$PlayerProfileErrorImpl> get copyWith =>
      __$$PlayerProfileErrorImplCopyWithImpl<_$PlayerProfileErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(MemberDataEntity player) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(MemberDataEntity player)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(MemberDataEntity player)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlayerProfileInitial value) initial,
    required TResult Function(PlayerProfileLoading value) loading,
    required TResult Function(PlayerProfileLoaded value) loaded,
    required TResult Function(PlayerProfileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlayerProfileInitial value)? initial,
    TResult? Function(PlayerProfileLoading value)? loading,
    TResult? Function(PlayerProfileLoaded value)? loaded,
    TResult? Function(PlayerProfileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlayerProfileInitial value)? initial,
    TResult Function(PlayerProfileLoading value)? loading,
    TResult Function(PlayerProfileLoaded value)? loaded,
    TResult Function(PlayerProfileError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PlayerProfileError implements PlayerProfileState {
  const factory PlayerProfileError({required final String message}) =
      _$PlayerProfileErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$PlayerProfileErrorImplCopyWith<_$PlayerProfileErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
