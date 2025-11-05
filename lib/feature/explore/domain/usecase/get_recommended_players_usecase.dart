import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/params/no_params.dart';
import '../entity/explore_player_entity.dart';
import '../repository/iexplore_repository.dart';

/// Get Recommended Players Use Case
/// Retrieves recommended players based on user preferences
@injectable
class GetRecommendedPlayersUseCase
    implements UseCase<ExploreResponseEntity, NoParams> {
  final IExploreRepository _repository;

  GetRecommendedPlayersUseCase(this._repository);

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> call(
    NoParams params,
  ) async {
    return await _repository.getRecommendedPlayers();
  }
}

