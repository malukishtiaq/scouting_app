import 'package:dartz/dartz.dart';

import 'package:scouting_app/core/datasources/remote_data_source.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/feature/games/data/request/model/game_model.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';

abstract class IGamesRemoteSource extends RemoteDataSource {
  /// List all games
  /// GET /api/games
  Future<Either<AppErrors, GamesListModel>> listGames(ListGamesParam param);

  /// Get game details
  /// GET /api/games/{game_id}
  Future<Either<AppErrors, GameDetailsModel>> getGameDetails(
      GetGameDetailsParam param);

  /// Create a new game
  /// POST /api/games
  Future<Either<AppErrors, GameDetailsModel>> createGame(CreateGameParam param);

  /// Join a game
  /// POST /api/games/{game_id}/join
  Future<Either<AppErrors, GameDetailsModel>> joinGame(JoinGameParam param);
}

