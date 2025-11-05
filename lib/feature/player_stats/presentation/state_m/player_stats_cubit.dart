import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/request/param/get_player_param.dart';
import '../../data/request/param/update_player_param.dart';
import '../../data/request/param/upload_media_param.dart';
import '../../domain/usecases/get_player_media_usecase.dart';
import '../../domain/usecases/get_player_usecase.dart';
import '../../domain/usecases/get_upcoming_games_usecase.dart';
import '../../domain/usecases/update_player_usecase.dart';
import '../../domain/usecases/upload_media_usecase.dart';
import 'player_stats_state.dart';

/// Player Stats Cubit - Manages player profile state
class PlayerStatsCubit extends Cubit<PlayerStatsState> {
  final GetPlayerUsecase getPlayerUsecase;
  final UpdatePlayerUsecase updatePlayerUsecase;
  final UploadMediaUsecase uploadMediaUsecase;
  final GetUpcomingGamesUsecase getUpcomingGamesUsecase;
  final GetPlayerMediaUsecase getPlayerMediaUsecase;

  PlayerStatsCubit({
    required this.getPlayerUsecase,
    required this.updatePlayerUsecase,
    required this.uploadMediaUsecase,
    required this.getUpcomingGamesUsecase,
    required this.getPlayerMediaUsecase,
  }) : super(const PlayerStatsState.initial());

  /// Load player data by player ID
  Future<void> loadPlayer(String playerId) async {
    emit(const PlayerStatsState.loading());

    final result = await getPlayerUsecase(GetPlayerParam(playerId: playerId));

    result.fold(
      (error) => emit(PlayerStatsState.error(error)),
      (player) => emit(PlayerStatsState.loaded(player)),
    );
  }

  /// Load upcoming games for the player
  Future<void> loadUpcomingGames(String playerId) async {
    // Only load games if we have a player loaded
    final currentState = state;
    if (currentState is! PlayerStatsLoaded &&
        currentState is! PlayerStatsGamesLoaded &&
        currentState is! PlayerStatsMediaLoaded) {
      return;
    }

    final player = _getPlayerFromState();
    if (player == null) return;

    emit(PlayerStatsState.gamesLoading(player));

    final result =
        await getUpcomingGamesUsecase(GetPlayerParam(playerId: playerId));

    result.fold(
      (error) => emit(PlayerStatsState.error(error)),
      (games) => emit(PlayerStatsState.gamesLoaded(player, games)),
    );
  }

  /// Load player media gallery
  Future<void> loadPlayerMedia(String playerId) async {
    final player = _getPlayerFromState();
    if (player == null) return;

    emit(PlayerStatsState.mediaLoading(player));

    final result =
        await getPlayerMediaUsecase(GetPlayerParam(playerId: playerId));

    result.fold(
      (error) => emit(PlayerStatsState.error(error)),
      (media) => emit(PlayerStatsState.mediaLoaded(player, media)),
    );
  }

  /// Update player profile
  Future<void> updatePlayer(UpdatePlayerParam param) async {
    final player = _getPlayerFromState();
    if (player == null) return;

    emit(PlayerStatsState.playerUpdating(player));

    final result = await updatePlayerUsecase(param);

    result.fold(
      (error) => emit(PlayerStatsState.error(error)),
      (updatedPlayer) => emit(PlayerStatsState.playerUpdated(updatedPlayer)),
    );
  }

  /// Upload media (photo or video)
  Future<void> uploadMedia(UploadMediaParam param) async {
    final player = _getPlayerFromState();
    if (player == null) return;

    emit(PlayerStatsState.mediaUploading(player));

    final result = await uploadMediaUsecase(param);

    result.fold(
      (error) => emit(PlayerStatsState.error(error)),
      (newMedia) => emit(PlayerStatsState.mediaUploaded(player, newMedia)),
    );
  }

  /// Helper method to get player from current state
  dynamic _getPlayerFromState() {
    final currentState = state;
    if (currentState is PlayerStatsLoaded) {
      return currentState.player;
    } else if (currentState is PlayerStatsGamesLoading) {
      return currentState.player;
    } else if (currentState is PlayerStatsGamesLoaded) {
      return currentState.player;
    } else if (currentState is PlayerStatsMediaLoading) {
      return currentState.player;
    } else if (currentState is PlayerStatsMediaLoaded) {
      return currentState.player;
    } else if (currentState is PlayerStatsMediaUploading) {
      return currentState.player;
    } else if (currentState is PlayerStatsMediaUploaded) {
      return currentState.player;
    } else if (currentState is PlayerStatsPlayerUpdating) {
      return currentState.player;
    } else if (currentState is PlayerStatsPlayerUpdated) {
      return currentState.player;
    }
    return null;
  }
}

