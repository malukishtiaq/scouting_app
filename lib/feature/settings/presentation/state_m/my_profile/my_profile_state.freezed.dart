// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProfileStateCopyWith<$Res> {
  factory $MyProfileStateCopyWith(
          MyProfileState value, $Res Function(MyProfileState) then) =
      _$MyProfileStateCopyWithImpl<$Res, MyProfileState>;
}

/// @nodoc
class _$MyProfileStateCopyWithImpl<$Res, $Val extends MyProfileState>
    implements $MyProfileStateCopyWith<$Res> {
  _$MyProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'MyProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MyProfileState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'MyProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MyProfileState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {UserProfileEntity profile,
      List<UserProfileFollowerEntity> following,
      bool hasReachedMax});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? following = null,
    Object? hasReachedMax = null,
  }) {
    return _then(_$LoadedImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileEntity,
      following: null == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<UserProfileFollowerEntity>,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.profile,
      required final List<UserProfileFollowerEntity> following,
      this.hasReachedMax = false})
      : _following = following;

  @override
  final UserProfileEntity profile;
  final List<UserProfileFollowerEntity> _following;
  @override
  List<UserProfileFollowerEntity> get following {
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_following);
  }

  @override
  @JsonKey()
  final bool hasReachedMax;

  @override
  String toString() {
    return 'MyProfileState.loaded(profile: $profile, following: $following, hasReachedMax: $hasReachedMax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality()
                .equals(other._following, _following) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile,
      const DeepCollectionEquality().hash(_following), hasReachedMax);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return loaded(profile, following, hasReachedMax);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return loaded?.call(profile, following, hasReachedMax);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(profile, following, hasReachedMax);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements MyProfileState {
  const factory _Loaded(
      {required final UserProfileEntity profile,
      required final List<UserProfileFollowerEntity> following,
      final bool hasReachedMax}) = _$LoadedImpl;

  UserProfileEntity get profile;
  List<UserProfileFollowerEntity> get following;
  bool get hasReachedMax;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageUpdatingImplCopyWith<$Res> {
  factory _$$ImageUpdatingImplCopyWith(
          _$ImageUpdatingImpl value, $Res Function(_$ImageUpdatingImpl) then) =
      __$$ImageUpdatingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile, String imageType});
}

/// @nodoc
class __$$ImageUpdatingImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$ImageUpdatingImpl>
    implements _$$ImageUpdatingImplCopyWith<$Res> {
  __$$ImageUpdatingImplCopyWithImpl(
      _$ImageUpdatingImpl _value, $Res Function(_$ImageUpdatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? imageType = null,
  }) {
    return _then(_$ImageUpdatingImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileEntity,
      imageType: null == imageType
          ? _value.imageType
          : imageType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ImageUpdatingImpl implements _ImageUpdating {
  const _$ImageUpdatingImpl({required this.profile, required this.imageType});

  @override
  final UserProfileEntity profile;
  @override
  final String imageType;

  @override
  String toString() {
    return 'MyProfileState.imageUpdating(profile: $profile, imageType: $imageType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUpdatingImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.imageType, imageType) ||
                other.imageType == imageType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, imageType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUpdatingImplCopyWith<_$ImageUpdatingImpl> get copyWith =>
      __$$ImageUpdatingImplCopyWithImpl<_$ImageUpdatingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return imageUpdating(profile, imageType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return imageUpdating?.call(profile, imageType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
    required TResult orElse(),
  }) {
    if (imageUpdating != null) {
      return imageUpdating(profile, imageType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return imageUpdating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return imageUpdating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (imageUpdating != null) {
      return imageUpdating(this);
    }
    return orElse();
  }
}

abstract class _ImageUpdating implements MyProfileState {
  const factory _ImageUpdating(
      {required final UserProfileEntity profile,
      required final String imageType}) = _$ImageUpdatingImpl;

  UserProfileEntity get profile;
  String get imageType;
  @JsonKey(ignore: true)
  _$$ImageUpdatingImplCopyWith<_$ImageUpdatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageUpdatedImplCopyWith<$Res> {
  factory _$$ImageUpdatedImplCopyWith(
          _$ImageUpdatedImpl value, $Res Function(_$ImageUpdatedImpl) then) =
      __$$ImageUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfileEntity profile, String imageType});
}

/// @nodoc
class __$$ImageUpdatedImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$ImageUpdatedImpl>
    implements _$$ImageUpdatedImplCopyWith<$Res> {
  __$$ImageUpdatedImplCopyWithImpl(
      _$ImageUpdatedImpl _value, $Res Function(_$ImageUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? imageType = null,
  }) {
    return _then(_$ImageUpdatedImpl(
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileEntity,
      imageType: null == imageType
          ? _value.imageType
          : imageType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ImageUpdatedImpl implements _ImageUpdated {
  const _$ImageUpdatedImpl({required this.profile, required this.imageType});

  @override
  final UserProfileEntity profile;
  @override
  final String imageType;

  @override
  String toString() {
    return 'MyProfileState.imageUpdated(profile: $profile, imageType: $imageType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageUpdatedImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.imageType, imageType) ||
                other.imageType == imageType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile, imageType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageUpdatedImplCopyWith<_$ImageUpdatedImpl> get copyWith =>
      __$$ImageUpdatedImplCopyWithImpl<_$ImageUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return imageUpdated(profile, imageType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return imageUpdated?.call(profile, imageType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
    required TResult orElse(),
  }) {
    if (imageUpdated != null) {
      return imageUpdated(profile, imageType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return imageUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return imageUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (imageUpdated != null) {
      return imageUpdated(this);
    }
    return orElse();
  }
}

abstract class _ImageUpdated implements MyProfileState {
  const factory _ImageUpdated(
      {required final UserProfileEntity profile,
      required final String imageType}) = _$ImageUpdatedImpl;

  UserProfileEntity get profile;
  String get imageType;
  @JsonKey(ignore: true)
  _$$ImageUpdatedImplCopyWith<_$ImageUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, UserProfileEntity? profile});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$MyProfileStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? profile = freezed,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfileEntity?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message, this.profile});

  @override
  final String message;
  @override
  final UserProfileEntity? profile;

  @override
  String toString() {
    return 'MyProfileState.error(message: $message, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)
        loaded,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdating,
    required TResult Function(UserProfileEntity profile, String imageType)
        imageUpdated,
    required TResult Function(String message, UserProfileEntity? profile) error,
  }) {
    return error(message, profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult? Function(UserProfileEntity profile, String imageType)?
        imageUpdated,
    TResult? Function(String message, UserProfileEntity? profile)? error,
  }) {
    return error?.call(message, profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserProfileEntity profile,
            List<UserProfileFollowerEntity> following, bool hasReachedMax)?
        loaded,
    TResult Function(UserProfileEntity profile, String imageType)?
        imageUpdating,
    TResult Function(UserProfileEntity profile, String imageType)? imageUpdated,
    TResult Function(String message, UserProfileEntity? profile)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ImageUpdating value) imageUpdating,
    required TResult Function(_ImageUpdated value) imageUpdated,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ImageUpdating value)? imageUpdating,
    TResult? Function(_ImageUpdated value)? imageUpdated,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ImageUpdating value)? imageUpdating,
    TResult Function(_ImageUpdated value)? imageUpdated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MyProfileState {
  const factory _Error(
      {required final String message,
      final UserProfileEntity? profile}) = _$ErrorImpl;

  String get message;
  UserProfileEntity? get profile;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
