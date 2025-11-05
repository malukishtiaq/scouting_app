import '../../../../../core/params/base_params.dart';

/// Parameter for fetching player data
class GetPlayerParam extends BaseParams {
  final String playerId;

  GetPlayerParam({required this.playerId});

  Map<String, dynamic> toJson() {
    return {
      'player_id': playerId,
    };
  }

  @override
  List<Object?> get props => [playerId];

  @override
  Map<String, dynamic> toMap() {
    return {
      'player_id': playerId,
    };
  }
}
