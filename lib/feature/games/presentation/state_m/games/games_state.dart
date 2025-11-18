part of 'games_cubit.dart';

@freezed
class GamesState with _$GamesState {
  const factory GamesState.gamesInit() = GamesInit;
  const factory GamesState.gamesLoading() = GamesLoading;
  const factory GamesState.gamesError(
    AppErrors error,
    VoidCallback callback,
  ) = GamesError;

  const factory GamesState.gamesLoaded(
    GamesListEntity gamesListEntity,
  ) = GamesLoadedState;

  const factory GamesState.gameDetailsLoaded(
    GameDetailsEntity gameDetailsEntity,
  ) = GameDetailsLoadedState;

  const factory GamesState.gameCreated(
    GameDetailsEntity gameDetailsEntity,
  ) = GameCreatedState;

  const factory GamesState.gameJoined(
    GameDetailsEntity gameDetailsEntity,
  ) = GameJoinedState;
}

