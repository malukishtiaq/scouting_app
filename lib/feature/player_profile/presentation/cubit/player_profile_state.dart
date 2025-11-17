import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../account/domain/entity/member_response_entity.dart';

part 'player_profile_state.freezed.dart';

@freezed
class PlayerProfileState with _$PlayerProfileState {
  const factory PlayerProfileState.initial() = PlayerProfileInitial;
  const factory PlayerProfileState.loading() = PlayerProfileLoading;
  const factory PlayerProfileState.loaded({
    required MemberDataEntity player,
  }) = PlayerProfileLoaded;
  const factory PlayerProfileState.error({
    required String message,
  }) = PlayerProfileError;
}

