import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/request/param/update_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Update Player Use Case
class UpdatePlayerUsecase extends UseCase<PlayerEntity, UpdatePlayerParam> {
  final IPlayerRepository repository;

  UpdatePlayerUsecase({required this.repository});

  @override
  Future<Result<AppErrors, PlayerEntity>> call(UpdatePlayerParam param) async {
    return await repository.updatePlayer(param);
  }
}
