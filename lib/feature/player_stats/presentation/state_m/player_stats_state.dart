import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/errors/app_errors.dart';
import '../../domain/entities/player_entity.dart';

part 'player_stats_state.freezed.dart';

@freezed
class PlayerStatsState with _$PlayerStatsState {
  const factory PlayerStatsState.initial() = PlayerStatsInitial;
  
  const factory PlayerStatsState.loading() = PlayerStatsLoading;
  
  const factory PlayerStatsState.loaded(PlayerEntity player) = PlayerStatsLoaded;
  
  const factory PlayerStatsState.error(AppErrors error) = PlayerStatsError;
  
  // State for player update
  const factory PlayerStatsState.playerUpdating(PlayerEntity player) = PlayerStatsPlayerUpdating;
  
  const factory PlayerStatsState.playerUpdated(PlayerEntity player) = PlayerStatsPlayerUpdated;
}
