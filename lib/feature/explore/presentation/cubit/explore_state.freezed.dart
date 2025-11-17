// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExploreState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberDataEntity> members,
            bool isLoadingMore, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message, VoidCallback retry) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message, VoidCallback retry)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message, VoidCallback retry)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(ExploreLoaded value) loaded,
    required TResult Function(ExploreError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(ExploreLoaded value)? loaded,
    TResult? Function(ExploreError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(ExploreLoaded value)? loaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreStateCopyWith<$Res> {
  factory $ExploreStateCopyWith(
          ExploreState value, $Res Function(ExploreState) then) =
      _$ExploreStateCopyWithImpl<$Res, ExploreState>;
}

/// @nodoc
class _$ExploreStateCopyWithImpl<$Res, $Val extends ExploreState>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ExploreInitialImplCopyWith<$Res> {
  factory _$$ExploreInitialImplCopyWith(_$ExploreInitialImpl value,
          $Res Function(_$ExploreInitialImpl) then) =
      __$$ExploreInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExploreInitialImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreInitialImpl>
    implements _$$ExploreInitialImplCopyWith<$Res> {
  __$$ExploreInitialImplCopyWithImpl(
      _$ExploreInitialImpl _value, $Res Function(_$ExploreInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExploreInitialImpl
    with DiagnosticableTreeMixin
    implements ExploreInitial {
  const _$ExploreInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'ExploreState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExploreInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberDataEntity> members,
            bool isLoadingMore, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message, VoidCallback retry) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message, VoidCallback retry)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message, VoidCallback retry)? error,
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
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(ExploreLoaded value) loaded,
    required TResult Function(ExploreError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(ExploreLoaded value)? loaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(ExploreLoaded value)? loaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ExploreInitial implements ExploreState {
  const factory ExploreInitial() = _$ExploreInitialImpl;
}

/// @nodoc
abstract class _$$ExploreLoadingImplCopyWith<$Res> {
  factory _$$ExploreLoadingImplCopyWith(_$ExploreLoadingImpl value,
          $Res Function(_$ExploreLoadingImpl) then) =
      __$$ExploreLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExploreLoadingImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreLoadingImpl>
    implements _$$ExploreLoadingImplCopyWith<$Res> {
  __$$ExploreLoadingImplCopyWithImpl(
      _$ExploreLoadingImpl _value, $Res Function(_$ExploreLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExploreLoadingImpl
    with DiagnosticableTreeMixin
    implements ExploreLoading {
  const _$ExploreLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'ExploreState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExploreLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberDataEntity> members,
            bool isLoadingMore, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message, VoidCallback retry) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message, VoidCallback retry)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message, VoidCallback retry)? error,
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
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(ExploreLoaded value) loaded,
    required TResult Function(ExploreError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(ExploreLoaded value)? loaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(ExploreLoaded value)? loaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ExploreLoading implements ExploreState {
  const factory ExploreLoading() = _$ExploreLoadingImpl;
}

/// @nodoc
abstract class _$$ExploreLoadedImplCopyWith<$Res> {
  factory _$$ExploreLoadedImplCopyWith(
          _$ExploreLoadedImpl value, $Res Function(_$ExploreLoadedImpl) then) =
      __$$ExploreLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<MemberDataEntity> members,
      bool isLoadingMore,
      int currentPage,
      bool hasMore});
}

/// @nodoc
class __$$ExploreLoadedImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreLoadedImpl>
    implements _$$ExploreLoadedImplCopyWith<$Res> {
  __$$ExploreLoadedImplCopyWithImpl(
      _$ExploreLoadedImpl _value, $Res Function(_$ExploreLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? isLoadingMore = null,
    Object? currentPage = null,
    Object? hasMore = null,
  }) {
    return _then(_$ExploreLoadedImpl(
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<MemberDataEntity>,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ExploreLoadedImpl
    with DiagnosticableTreeMixin
    implements ExploreLoaded {
  const _$ExploreLoadedImpl(
      {required final List<MemberDataEntity> members,
      this.isLoadingMore = false,
      this.currentPage = 1,
      this.hasMore = true})
      : _members = members;

  final List<MemberDataEntity> _members;
  @override
  List<MemberDataEntity> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreState.loaded(members: $members, isLoadingMore: $isLoadingMore, currentPage: $currentPage, hasMore: $hasMore)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreState.loaded'))
      ..add(DiagnosticsProperty('members', members))
      ..add(DiagnosticsProperty('isLoadingMore', isLoadingMore))
      ..add(DiagnosticsProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty('hasMore', hasMore));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreLoadedImpl &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_members),
      isLoadingMore,
      currentPage,
      hasMore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreLoadedImplCopyWith<_$ExploreLoadedImpl> get copyWith =>
      __$$ExploreLoadedImplCopyWithImpl<_$ExploreLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberDataEntity> members,
            bool isLoadingMore, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message, VoidCallback retry) error,
  }) {
    return loaded(members, isLoadingMore, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message, VoidCallback retry)? error,
  }) {
    return loaded?.call(members, isLoadingMore, currentPage, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message, VoidCallback retry)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(members, isLoadingMore, currentPage, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(ExploreLoaded value) loaded,
    required TResult Function(ExploreError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(ExploreLoaded value)? loaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(ExploreLoaded value)? loaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ExploreLoaded implements ExploreState {
  const factory ExploreLoaded(
      {required final List<MemberDataEntity> members,
      final bool isLoadingMore,
      final int currentPage,
      final bool hasMore}) = _$ExploreLoadedImpl;

  List<MemberDataEntity> get members;
  bool get isLoadingMore;
  int get currentPage;
  bool get hasMore;
  @JsonKey(ignore: true)
  _$$ExploreLoadedImplCopyWith<_$ExploreLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExploreErrorImplCopyWith<$Res> {
  factory _$$ExploreErrorImplCopyWith(
          _$ExploreErrorImpl value, $Res Function(_$ExploreErrorImpl) then) =
      __$$ExploreErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, VoidCallback retry});
}

/// @nodoc
class __$$ExploreErrorImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreErrorImpl>
    implements _$$ExploreErrorImplCopyWith<$Res> {
  __$$ExploreErrorImplCopyWithImpl(
      _$ExploreErrorImpl _value, $Res Function(_$ExploreErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? retry = null,
  }) {
    return _then(_$ExploreErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      retry: null == retry
          ? _value.retry
          : retry // ignore: cast_nullable_to_non_nullable
              as VoidCallback,
    ));
  }
}

/// @nodoc

class _$ExploreErrorImpl with DiagnosticableTreeMixin implements ExploreError {
  const _$ExploreErrorImpl({required this.message, required this.retry});

  @override
  final String message;
  @override
  final VoidCallback retry;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreState.error(message: $message, retry: $retry)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreState.error'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('retry', retry));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.retry, retry) || other.retry == retry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, retry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreErrorImplCopyWith<_$ExploreErrorImpl> get copyWith =>
      __$$ExploreErrorImplCopyWithImpl<_$ExploreErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MemberDataEntity> members,
            bool isLoadingMore, int currentPage, bool hasMore)
        loaded,
    required TResult Function(String message, VoidCallback retry) error,
  }) {
    return error(message, retry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult? Function(String message, VoidCallback retry)? error,
  }) {
    return error?.call(message, retry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MemberDataEntity> members, bool isLoadingMore,
            int currentPage, bool hasMore)?
        loaded,
    TResult Function(String message, VoidCallback retry)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, retry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExploreInitial value) initial,
    required TResult Function(ExploreLoading value) loading,
    required TResult Function(ExploreLoaded value) loaded,
    required TResult Function(ExploreError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExploreInitial value)? initial,
    TResult? Function(ExploreLoading value)? loading,
    TResult? Function(ExploreLoaded value)? loaded,
    TResult? Function(ExploreError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExploreInitial value)? initial,
    TResult Function(ExploreLoading value)? loading,
    TResult Function(ExploreLoaded value)? loaded,
    TResult Function(ExploreError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ExploreError implements ExploreState {
  const factory ExploreError(
      {required final String message,
      required final VoidCallback retry}) = _$ExploreErrorImpl;

  String get message;
  VoidCallback get retry;
  @JsonKey(ignore: true)
  _$$ExploreErrorImplCopyWith<_$ExploreErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
