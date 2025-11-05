import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../../domain/entities/player_entity.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';

/// Player Repository Interface
abstract class IPlayerRepository {
  /// Get player data by player ID
  Future<Either<AppErrors, PlayerEntity>> getPlayer(GetPlayerParam param);

  /// Update player profile data
  Future<Either<AppErrors, PlayerEntity>> updatePlayer(UpdatePlayerParam param);

  /// Upload media (photo or video)
  Future<Either<AppErrors, MediaEntity>> uploadMedia(UploadMediaParam param);

  /// Get upcoming games for a player
  Future<Either<AppErrors, List<GameEntity>>> getUpcomingGames(
      GetPlayerParam param);

  /// Get player media gallery
  Future<Either<AppErrors, List<MediaEntity>>> getPlayerMedia(
      GetPlayerParam param);
}

