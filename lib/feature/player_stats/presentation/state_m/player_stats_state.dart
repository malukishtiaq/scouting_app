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
  
  // Specific states for games loading
  const factory PlayerStatsState.gamesLoading(PlayerEntity player) = PlayerStatsGamesLoading;
  
  const factory PlayerStatsState.gamesLoaded(
    PlayerEntity player,
    List<GameEntity> games,
  ) = PlayerStatsGamesLoaded;
  
  // Specific states for media loading
  const factory PlayerStatsState.mediaLoading(PlayerEntity player) = PlayerStatsMediaLoading;
  
  const factory PlayerStatsState.mediaLoaded(
    PlayerEntity player,
    List<MediaEntity> media,
  ) = PlayerStatsMediaLoaded;
  
  // State for media upload
  const factory PlayerStatsState.mediaUploading(PlayerEntity player) = PlayerStatsMediaUploading;
  
  const factory PlayerStatsState.mediaUploaded(
    PlayerEntity player,
    MediaEntity newMedia,
  ) = PlayerStatsMediaUploaded;
  
  // State for player update
  const factory PlayerStatsState.playerUpdating(PlayerEntity player) = PlayerStatsPlayerUpdating;
  
  const factory PlayerStatsState.playerUpdated(PlayerEntity player) = PlayerStatsPlayerUpdated;
}

