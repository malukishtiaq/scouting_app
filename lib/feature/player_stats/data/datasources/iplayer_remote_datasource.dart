import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../../../../mainapis.dart';
import '../request/model/player_model.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';

part 'player_remote_datasource.dart';

/// Player Remote Datasource Interface
abstract class IPlayerRemoteDatasource extends RemoteDataSource {
  /// Get player data from remote source
  Future<Either<AppErrors, PlayerModel>> getPlayer(GetPlayerParam param);

  /// Update player profile data
  Future<Either<AppErrors, PlayerModel>> updatePlayer(UpdatePlayerParam param);

  /// Upload media (photo or video)
  Future<Either<AppErrors, MediaModel>> uploadMedia(UploadMediaParam param);

  /// Get upcoming games for a player
  Future<Either<AppErrors, List<GameModel>>> getUpcomingGames(
      GetPlayerParam param);

  /// Get player media gallery
  Future<Either<AppErrors, List<MediaModel>>> getPlayerMedia(
      GetPlayerParam param);
}
