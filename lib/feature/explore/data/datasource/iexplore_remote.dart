import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/net/create_model_interceptor/primitive_create_model_interceptor.dart';
import '../../../../core/net/http_client.dart';
import '../../../../mainapis.dart';
import '../request/model/explore_response_model.dart';
import '../request/param/get_nearby_players_param.dart';
import '../request/param/search_players_param.dart';

part 'explore_remote.dart';

/// Explore Remote Data Source Interface
/// Defines the contract for remote explore data operations
abstract class IExploreRemoteSource extends RemoteDataSource {
  /// Get nearby players based on location
  Future<Either<AppErrors, ExploreResponseModel>> getNearbyPlayers(
    GetNearbyPlayersParam param,
  );

  /// Search players by query
  Future<Either<AppErrors, ExploreResponseModel>> searchPlayers(
    SearchPlayersParam param,
  );

  /// Get recommended players based on user preferences
  Future<Either<AppErrors, ExploreResponseModel>> getRecommendedPlayers();

  /// Get trending players
  Future<Either<AppErrors, ExploreResponseModel>> getTrendingPlayers();
}

