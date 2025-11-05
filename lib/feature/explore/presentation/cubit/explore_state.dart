part of 'explore_cubit.dart';

@freezed
class ExploreState with _$ExploreState {
  /// Initial state
  const factory ExploreState.exploreInit() = ExploreInit;

  /// Loading state
  const factory ExploreState.exploreLoading() = ExploreLoading;

  /// Success state with players data
  const factory ExploreState.exploreLoadSuccess(
    List<ExplorePlayerEntity> players,
  ) = ExploreLoadSuccess;

  /// Error state
  const factory ExploreState.exploreError(
    AppErrors error,
    VoidCallback callback,
  ) = ExploreError;

  /// Search results state
  const factory ExploreState.searchResults(
    List<ExplorePlayerEntity> players,
    String query,
  ) = SearchResults;

  /// Empty state (no players found)
  const factory ExploreState.exploreEmpty(String message) = ExploreEmpty;
}

