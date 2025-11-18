import 'package:injectable/injectable.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/results/result.dart';
import 'package:scouting_app/core/usecases/usecase.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/repository/igames_repository.dart';

/// Get Game Details use case
/// Uses /api/games/{game_id} endpoint
@singleton
class GetGameDetailsUsecase
    extends UseCase<GameDetailsEntity, GetGameDetailsParam> {
  final IGamesRepository repository;

  GetGameDetailsUsecase(this.repository);

  @override
  Future<Result<AppErrors, GameDetailsEntity>> call(
      GetGameDetailsParam param) async {
    return await repository.getGameDetails(param);
  }
}
