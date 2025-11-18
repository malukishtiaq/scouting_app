import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for joining a game
class JoinGameParam extends BaseParams {
  final int gameId;

  JoinGameParam({
    required this.gameId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'game_id': gameId,
    };
  }
}

