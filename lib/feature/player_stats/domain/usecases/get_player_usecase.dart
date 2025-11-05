import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../data/request/param/get_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Get Player Use Case
class GetPlayerUsecase {
  final IPlayerRepository repository;

  const GetPlayerUsecase({required this.repository});

  Future<Either<AppErrors, PlayerEntity>> call(GetPlayerParam param) async {
    return await repository.getPlayer(param);
  }
}

