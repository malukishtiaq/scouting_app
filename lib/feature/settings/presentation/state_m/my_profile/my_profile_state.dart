import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../profile/domain/entities/user_profile_entity.dart';

part 'my_profile_state.freezed.dart';

@freezed
class MyProfileState with _$MyProfileState {
  const factory MyProfileState.initial() = _Initial;
  const factory MyProfileState.loading() = _Loading;
  const factory MyProfileState.loaded({
    required UserProfileEntity profile,
    required List<UserProfileFollowerEntity> following,
    @Default(false) bool hasReachedMax,
  }) = _Loaded;
  const factory MyProfileState.imageUpdating({
    required UserProfileEntity profile,
    required String imageType, // 'avatar' or 'cover'
  }) = _ImageUpdating;
  const factory MyProfileState.imageUpdated({
    required UserProfileEntity profile,
    required String imageType,
  }) = _ImageUpdated;
  const factory MyProfileState.error({
    required String message,
    UserProfileEntity? profile,
  }) = _Error;
}
