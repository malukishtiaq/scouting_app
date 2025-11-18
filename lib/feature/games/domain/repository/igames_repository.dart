import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/repositories/repository.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';

abstract class IGamesRepository extends Repository {
  /// List all games
  /// GET /api/games
  Future<Result<AppErrors, GamesListEntity>> listGames(ListGamesParam param);

  /// Get game details
  /// GET /api/games/{game_id}
  Future<Result<AppErrors, GameDetailsEntity>> getGameDetails(
      GetGameDetailsParam param);

  /// Create a new game
  /// POST /api/games
  Future<Result<AppErrors, GameDetailsEntity>> createGame(
      CreateGameParam param);

  /// Join a game
  /// POST /api/games/{game_id}/join
  Future<Result<AppErrors, GameDetailsEntity>> joinGame(JoinGameParam param);
}
