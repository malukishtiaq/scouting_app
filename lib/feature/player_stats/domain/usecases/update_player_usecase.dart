import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../data/request/param/update_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Update Player Use Case
class UpdatePlayerUsecase {
  final IPlayerRepository repository;

  const UpdatePlayerUsecase({required this.repository});

  Future<Either<AppErrors, PlayerEntity>> call(UpdatePlayerParam param) async {
    return await repository.updatePlayer(param);
  }
}

