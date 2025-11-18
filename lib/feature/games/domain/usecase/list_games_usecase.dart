import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/repository/igames_repository.dart';

/// List Games use case
/// Uses /api/games endpoint
@singleton
class ListGamesUsecase
    extends UseCase<GamesListEntity, ListGamesParam> {
  final IGamesRepository repository;

  ListGamesUsecase(this.repository);

  @override
  Future<Result<AppErrors, GamesListEntity>> call(
      ListGamesParam param) async {
    return await repository.listGames(param);
  }
}

