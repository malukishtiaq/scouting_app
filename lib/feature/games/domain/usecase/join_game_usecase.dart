import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/repository/igames_repository.dart';

/// Join Game use case
/// Uses /api/games/{game_id}/join endpoint
@singleton
class JoinGameUsecase extends UseCase<GameDetailsEntity, JoinGameParam> {
  final IGamesRepository repository;

  JoinGameUsecase(this.repository);

  @override
  Future<Result<AppErrors, GameDetailsEntity>> call(
      JoinGameParam param) async {
    return await repository.joinGame(param);
  }
}

