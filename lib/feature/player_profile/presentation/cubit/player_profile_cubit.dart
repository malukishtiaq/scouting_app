import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../account/domain/entity/member_response_entity.dart';
import 'player_profile_state.dart';

@injectable
class PlayerProfileCubit extends Cubit<PlayerProfileState> {
  PlayerProfileCubit() : super(const PlayerProfileState.initial());

  /// Load player profile
  /// If playerData is provided, use it immediately
  /// Otherwise, fetch from API (to be implemented)
  void loadPlayer(String playerId, MemberDataEntity? playerData) {
    if (playerData != null) {
      // Use provided data
      emit(PlayerProfileState.loaded(player: playerData));
    } else {
      // TODO: Implement API call to fetch player by ID
      emit(const PlayerProfileState.loading());

      // For now, show error since API not implemented
      emit(const PlayerProfileState.error(
        message: 'Player data not available',
      ));
    }
  }
}
