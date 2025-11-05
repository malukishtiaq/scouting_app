import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/explore_player_entity.dart';
import '../repository/iexplore_repository.dart';
import '../../data/request/param/get_nearby_players_param.dart';

/// Get Nearby Players Use Case
/// Retrieves players near the user's location
@injectable
class GetNearbyPlayersUseCase
    implements UseCase<ExploreResponseEntity, GetNearbyPlayersParam> {
  final IExploreRepository _repository;

  GetNearbyPlayersUseCase(this._repository);

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> call(
    GetNearbyPlayersParam params,
  ) async {
    return await _repository.getNearbyPlayers(params);
  }
}

