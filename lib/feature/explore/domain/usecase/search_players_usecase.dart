import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/explore_player_entity.dart';
import '../repository/iexplore_repository.dart';
import '../../data/request/param/search_players_param.dart';

/// Search Players Use Case
/// Searches for players based on query string
@injectable
class SearchPlayersUseCase
    implements UseCase<ExploreResponseEntity, SearchPlayersParam> {
  final IExploreRepository _repository;

  SearchPlayersUseCase(this._repository);

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> call(
    SearchPlayersParam params,
  ) async {
    return await _repository.searchPlayers(params);
  }
}

