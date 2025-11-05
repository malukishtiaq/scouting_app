import '../request/model/player_model.dart';
import '../request/param/get_player_param.dart';
import '../request/param/update_player_param.dart';
import '../request/param/upload_media_param.dart';

/// Player Remote Datasource Interface
abstract class IPlayerRemoteDatasource {
  /// Get player data from remote source
  Future<PlayerModel> getPlayer(GetPlayerParam param);

  /// Update player profile data
  Future<PlayerModel> updatePlayer(UpdatePlayerParam param);

  /// Upload media (photo or video)
  Future<MediaModel> uploadMedia(UploadMediaParam param);

  /// Get upcoming games for a player
  Future<List<GameModel>> getUpcomingGames(GetPlayerParam param);

  /// Get player media gallery
  Future<List<MediaModel>> getPlayerMedia(GetPlayerParam param);
}

