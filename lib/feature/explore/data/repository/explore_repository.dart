import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/app_errors.dart';
import '../../domain/entity/explore_player_entity.dart';
import '../../domain/repository/iexplore_repository.dart';
import '../datasource/iexplore_remote.dart';
import '../request/param/get_nearby_players_param.dart';
import '../request/param/search_players_param.dart';

/// Explore Repository Implementation - Data Layer
/// Implements the explore repository contract
@Injectable(as: IExploreRepository)
class ExploreRepository implements IExploreRepository {
  final IExploreRemoteSource _remoteSource;

  ExploreRepository(this._remoteSource);

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> getNearbyPlayers(
    GetNearbyPlayersParam param,
  ) async {
    final result = await _remoteSource.getNearbyPlayers(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> searchPlayers(
    SearchPlayersParam param,
  ) async {
    final result = await _remoteSource.searchPlayers(param);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> getRecommendedPlayers() async {
    final result = await _remoteSource.getRecommendedPlayers();
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<AppErrors, ExploreResponseEntity>> getTrendingPlayers() async {
    final result = await _remoteSource.getTrendingPlayers();
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }
}

