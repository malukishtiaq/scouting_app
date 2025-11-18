import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for getting game details
class GetGameDetailsParam extends BaseParams {
  final int gameId;

  GetGameDetailsParam({
    required this.gameId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'game_id': gameId,
    };
  }
}
