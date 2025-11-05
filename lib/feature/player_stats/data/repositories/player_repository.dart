part of '../../domain/repositories/iplayer_repository.dart';

@Injectable(as: IPlayerRepository)
class PlayerRepository extends IPlayerRepository {
  final IPlayerRemoteDatasource remoteDataSource;

  PlayerRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, PlayerEntity>> getPlayer(
      GetPlayerParam param) async {
    return execute<PlayerModel, PlayerEntity>(
      remoteResult: await remoteDataSource.getPlayer(param),
    );
  }

  @override
  Future<Result<AppErrors, PlayerEntity>> updatePlayer(
      UpdatePlayerParam param) async {
    return execute<PlayerModel, PlayerEntity>(
      remoteResult: await remoteDataSource.updatePlayer(param),
    );
  }

  @override
  Future<Result<AppErrors, MediaEntity>> uploadMedia(
      UploadMediaParam param) async {
    return execute<MediaModel, MediaEntity>(
      remoteResult: await remoteDataSource.uploadMedia(param),
    );
  }

  @override
  Future<Result<AppErrors, List<GameEntity>>> getUpcomingGames(
      GetPlayerParam param) async {
    return execute<List<GameModel>, List<GameEntity>>(
      remoteResult: await remoteDataSource.getUpcomingGames(param),
    );
  }

  @override
  Future<Result<AppErrors, List<MediaEntity>>> getPlayerMedia(
      GetPlayerParam param) async {
    return execute<List<MediaModel>, List<MediaEntity>>(
      remoteResult: await remoteDataSource.getPlayerMedia(param),
    );
  }
}
