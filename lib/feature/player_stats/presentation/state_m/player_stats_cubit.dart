import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../di/service_locator.dart';
import '../../data/request/param/get_player_param.dart';
import '../../data/request/param/update_player_param.dart';
import '../../domain/usecases/get_player_usecase.dart';
import '../../domain/usecases/update_player_usecase.dart';
import 'player_stats_state.dart';

/// Player Stats Cubit - Manages player profile state
class PlayerStatsCubit extends Cubit<PlayerStatsState> {
  PlayerStatsCubit() : super(const PlayerStatsState.initial());

  /// Load player data by player ID
  Future<void> loadPlayer(String playerId) async {
    emit(const PlayerStatsState.loading());

    try {
      final param = GetPlayerParam(playerId: playerId);
      final result = await getIt<GetPlayerUsecase>()(param);

      result.pick(
        onData: (player) {
          emit(PlayerStatsState.loaded(player));
        },
        onError: (error) {
          emit(PlayerStatsState.error(error));
        },
      );
    } catch (e) {
      emit(const PlayerStatsState.error(
        AppErrors.customError(message: 'Failed to load player data'),
      ));
    }
  }

  /// Update player profile
  Future<void> updatePlayer(UpdatePlayerParam param) async {
    final player = _getPlayerFromState();
    if (player == null) return;

    emit(PlayerStatsState.playerUpdating(player));

    try {
      final result = await getIt<UpdatePlayerUsecase>()(param);

      result.pick(
        onData: (updatedPlayer) {
          emit(PlayerStatsState.playerUpdated(updatedPlayer));
        },
        onError: (error) {
          emit(PlayerStatsState.error(error));
        },
      );
    } catch (e) {
      emit(const PlayerStatsState.error(
        AppErrors.customError(message: 'Failed to update player profile'),
      ));
    }
  }

  /// Helper method to get player from current state
  dynamic _getPlayerFromState() {
    final currentState = state;
    if (currentState is PlayerStatsLoaded) {
      return currentState.player;
    } else if (currentState is PlayerStatsPlayerUpdating) {
      return currentState.player;
    } else if (currentState is PlayerStatsPlayerUpdated) {
      return currentState.player;
    }
    return null;
  }
}
