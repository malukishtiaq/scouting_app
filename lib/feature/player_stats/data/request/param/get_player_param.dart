import 'package:equatable/equatable.dart';

/// Parameter for fetching player data
class GetPlayerParam extends Equatable {
  final String playerId;

  const GetPlayerParam({required this.playerId});

  Map<String, dynamic> toJson() {
    return {
      'player_id': playerId,
    };
  }

  @override
  List<Object?> get props => [playerId];
}

