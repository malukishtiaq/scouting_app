import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/feature/games/data/datasource/igames_remote.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/repository/igames_repository.dart';

@Injectable(as: IGamesRepository)
class GamesRepository extends IGamesRepository {
  final IGamesRemoteSource remoteDataSource;

  GamesRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, GamesListEntity>> listGames(
      ListGamesParam param) async {
    final result = await remoteDataSource.listGames(param);
    
    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, GameDetailsEntity>> getGameDetails(
      GetGameDetailsParam param) async {
    final result = await remoteDataSource.getGameDetails(param);
    
    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, GameDetailsEntity>> createGame(
      CreateGameParam param) async {
    final result = await remoteDataSource.createGame(param);
    
    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }

  @override
  Future<Result<AppErrors, GameDetailsEntity>> joinGame(
      JoinGameParam param) async {
    final result = await remoteDataSource.joinGame(param);
    
    return result.fold(
      (error) => Result.error(error),
      (model) => Result.data(model.toEntity()),
    );
  }
}
