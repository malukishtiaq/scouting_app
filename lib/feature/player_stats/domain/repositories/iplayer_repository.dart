import '../../data/datasources/iplayer_remote_datasource.dart';
import '../../data/request/model/player_model.dart';
import '../../data/request/param/get_player_param.dart';
import '../../data/request/param/update_player_param.dart';
import '../../data/request/param/upload_media_param.dart';
import '../../domain/entities/player_entity.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import 'package:injectable/injectable.dart';

part '../../data/repositories/player_repository.dart';

/// Player Repository Interface
abstract class IPlayerRepository extends Repository {
  /// Get player data by player ID
  Future<Result<AppErrors, PlayerEntity>> getPlayer(GetPlayerParam param);

  /// Update player profile data
  Future<Result<AppErrors, PlayerEntity>> updatePlayer(UpdatePlayerParam param);

  /// Upload media (photo or video)
  Future<Result<AppErrors, MediaEntity>> uploadMedia(UploadMediaParam param);

  /// Get upcoming games for a player
  Future<Result<AppErrors, List<GameEntity>>> getUpcomingGames(
      GetPlayerParam param);

  /// Get player media gallery
  Future<Result<AppErrors, List<MediaEntity>>> getPlayerMedia(
      GetPlayerParam param);
}
