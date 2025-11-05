import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/get_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Get Player Use Case
class GetPlayerUsecase extends UseCase<PlayerEntity, GetPlayerParam> {
  final IPlayerRepository repository;

  GetPlayerUsecase({required this.repository});

  @override
  Future<Result<AppErrors, PlayerEntity>> call(GetPlayerParam param) async {
    return await repository.getPlayer(param);
  }
}
