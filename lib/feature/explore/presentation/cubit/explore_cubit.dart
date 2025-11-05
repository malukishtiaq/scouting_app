import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../domain/entity/explore_player_entity.dart';
import '../../../domain/usecase/get_nearby_players_usecase.dart';
import '../../../domain/usecase/search_players_usecase.dart';
import '../../../domain/usecase/get_recommended_players_usecase.dart';
import '../../../data/request/param/get_nearby_players_param.dart';
import '../../../data/request/param/search_players_param.dart';
import '../../../../../core/params/no_params.dart';
import '../../../../../di/service_locator.dart';

part 'explore_cubit.freezed.dart';
part 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(const ExploreState.exploreInit());

  List<ExplorePlayerEntity> _players = [];
  List<ExplorePlayerEntity> get players => _players;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  /// Load nearby players based on location
  void loadNearbyPlayers({
    double? latitude,
    double? longitude,
    double radiusKm = 50.0,
  }) async {
    emit(const ExploreState.exploreLoading());

    try {
      final param = GetNearbyPlayersParam(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
      );

      final result = await getIt<GetNearbyPlayersUseCase>()(param);

      result.pick(
        onData: (response) {
          _players = response.players ?? [];
          emit(ExploreState.exploreLoadSuccess(_players));
        },
        onError: (error) {
          emit(ExploreState.exploreError(
            error,
            () => loadNearbyPlayers(
              latitude: latitude,
              longitude: longitude,
              radiusKm: radiusKm,
            ),
          ));
        },
      );
    } catch (e) {
      emit(ExploreState.exploreError(
        const AppErrors.customError(
            message: 'Failed to load nearby players. Please try again.'),
        () => loadNearbyPlayers(
          latitude: latitude,
          longitude: longitude,
          radiusKm: radiusKm,
        ),
      ));
    }
  }

  /// Search players by query
  void searchPlayers(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      // If query is empty, reload nearby players
      loadNearbyPlayers();
      return;
    }

    emit(const ExploreState.exploreLoading());

    try {
      final param = SearchPlayersParam(query: query);

      final result = await getIt<SearchPlayersUseCase>()(param);

      result.pick(
        onData: (response) {
          _players = response.players ?? [];
          emit(ExploreState.exploreLoadSuccess(_players));
        },
        onError: (error) {
          emit(ExploreState.exploreError(
            error,
            () => searchPlayers(query),
          ));
        },
      );
    } catch (e) {
      emit(ExploreState.exploreError(
        const AppErrors.customError(
            message: 'Failed to search players. Please try again.'),
        () => searchPlayers(query),
      ));
    }
  }

  /// Load recommended players
  void loadRecommendedPlayers() async {
    emit(const ExploreState.exploreLoading());

    try {
      final result = await getIt<GetRecommendedPlayersUseCase>()(NoParams());

      result.pick(
        onData: (response) {
          _players = response.players ?? [];
          emit(ExploreState.exploreLoadSuccess(_players));
        },
        onError: (error) {
          emit(ExploreState.exploreError(
            error,
            () => loadRecommendedPlayers(),
          ));
        },
      );
    } catch (e) {
      emit(ExploreState.exploreError(
        const AppErrors.customError(
            message: 'Failed to load recommended players. Please try again.'),
        () => loadRecommendedPlayers(),
      ));
    }
  }

  /// Refresh players
  void refresh() {
    if (_searchQuery.isNotEmpty) {
      searchPlayers(_searchQuery);
    } else {
      loadNearbyPlayers();
    }
  }

  /// Clear search and reload
  void clearSearch() {
    _searchQuery = '';
    loadNearbyPlayers();
  }
}

