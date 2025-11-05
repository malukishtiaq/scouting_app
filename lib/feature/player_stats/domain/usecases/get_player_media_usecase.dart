import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../data/request/param/get_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Get Player Media Use Case
class GetPlayerMediaUsecase {
  final IPlayerRepository repository;

  const GetPlayerMediaUsecase({required this.repository});

  Future<Either<AppErrors, List<MediaEntity>>> call(
      GetPlayerParam param) async {
    return await repository.getPlayerMedia(param);
  }
}

