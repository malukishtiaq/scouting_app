import 'package:dartz/dartz.dart';
import '../../../../core/errors/app_errors.dart';
import '../entity/explore_player_entity.dart';
import '../../data/request/param/get_nearby_players_param.dart';
import '../../data/request/param/search_players_param.dart';

/// Explore Repository Interface - Domain Layer
/// Defines the contract for explore data operations
abstract class IExploreRepository {
  /// Get nearby players based on location
  Future<Either<AppErrors, ExploreResponseEntity>> getNearbyPlayers(
    GetNearbyPlayersParam param,
  );

  /// Search players by query
  Future<Either<AppErrors, ExploreResponseEntity>> searchPlayers(
    SearchPlayersParam param,
  );

  /// Get recommended players based on user preferences
  Future<Either<AppErrors, ExploreResponseEntity>> getRecommendedPlayers();

  /// Get trending players
  Future<Either<AppErrors, ExploreResponseEntity>> getTrendingPlayers();
}

