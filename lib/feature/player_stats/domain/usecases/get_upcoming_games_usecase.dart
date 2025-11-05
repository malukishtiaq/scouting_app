import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../data/request/param/get_player_param.dart';
import '../entities/player_entity.dart';
import '../repositories/iplayer_repository.dart';

/// Get Upcoming Games Use Case
class GetUpcomingGamesUsecase {
  final IPlayerRepository repository;

  const GetUpcomingGamesUsecase({required this.repository});

  Future<Either<AppErrors, List<GameEntity>>> call(
      GetPlayerParam param) async {
    return await repository.getUpcomingGames(param);
  }
}

