import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/repository/igames_repository.dart';

/// Create Game use case
/// Uses /api/games endpoint
@singleton
class CreateGameUsecase
    extends UseCase<GameDetailsEntity, CreateGameParam> {
  final IGamesRepository repository;

  CreateGameUsecase(this.repository);

  @override
  Future<Result<AppErrors, GameDetailsEntity>> call(
      CreateGameParam param) async {
    return await repository.createGame(param);
  }
}

