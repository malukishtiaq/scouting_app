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
}
