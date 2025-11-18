import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/di/service_locator.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';
import 'package:scouting_app/feature/games/domain/usecase/list_games_usecase.dart';
import 'package:scouting_app/feature/games/domain/usecase/get_game_details_usecase.dart';
import 'package:scouting_app/feature/games/domain/usecase/create_game_usecase.dart';
import 'package:scouting_app/feature/games/domain/usecase/join_game_usecase.dart';

part 'games_cubit.freezed.dart';
part 'games_state.dart';

@injectable
class GamesCubit extends Cubit<GamesState> {
  GamesCubit() : super(const GamesState.gamesInit());

  // Current games list
  GamesListEntity? _currentGamesListEntity;
  GamesListEntity? get currentGamesListEntity => _currentGamesListEntity;

  // Current game details
  GameDetailsEntity? _currentGameDetailsEntity;
  GameDetailsEntity? get currentGameDetailsEntity => _currentGameDetailsEntity;

  // ========== GAMES API METHODS ==========

  /// Load games list
  void loadGames({
    int page = 1,
    int perPage = 20,
    String? status,
    String? sportType,
  }) async {
    emit(const GamesState.gamesLoading());

    try {
      final param = ListGamesParam(
        page: page,
        perPage: perPage,
        status: status,
        sportType: sportType,
      );

      final result = await getIt<ListGamesUsecase>()(param);

      result.pick(
        onData: (data) {
          _currentGamesListEntity = data;
          emit(GamesState.gamesLoaded(data));
        },
        onError: (error) {
          emit(GamesState.gamesError(
            error,
            () => loadGames(
              page: page,
              perPage: perPage,
              status: status,
              sportType: sportType,
            ),
          ));
        },
      );
    } catch (e) {
      emit(GamesState.gamesError(
        const AppErrors.connectionError(),
        () => loadGames(
          page: page,
          perPage: perPage,
          status: status,
          sportType: sportType,
        ),
      ));
    }
  }

  /// Load game details
  void loadGameDetails(int gameId) async {
    emit(const GamesState.gamesLoading());

    try {
      final param = GetGameDetailsParam(gameId: gameId);

      final result = await getIt<GetGameDetailsUsecase>()(param);

      result.pick(
        onData: (data) {
          _currentGameDetailsEntity = data;
          emit(GamesState.gameDetailsLoaded(data));
        },
        onError: (error) {
          emit(GamesState.gamesError(
            error,
            () => loadGameDetails(gameId),
          ));
        },
      );
    } catch (e) {
      emit(GamesState.gamesError(
        const AppErrors.connectionError(),
        () => loadGameDetails(gameId),
      ));
    }
  }

  /// Create a new game
  void createGame({
    required String title,
    required String location,
    required String dateTime,
    required int maxPlayers,
    required String description,
    required String sportType,
  }) async {
    emit(const GamesState.gamesLoading());

    try {
      final param = CreateGameParam(
        title: title,
        location: location,
        dateTime: dateTime,
        maxPlayers: maxPlayers,
        description: description,
        sportType: sportType,
      );

      final result = await getIt<CreateGameUsecase>()(param);

      result.pick(
        onData: (data) {
          _currentGameDetailsEntity = data;
          emit(GamesState.gameCreated(data));
          // Reload games list after creating a new game
          loadGames();
        },
        onError: (error) {
          emit(GamesState.gamesError(
            error,
            () => createGame(
              title: title,
              location: location,
              dateTime: dateTime,
              maxPlayers: maxPlayers,
              description: description,
              sportType: sportType,
            ),
          ));
        },
      );
    } catch (e) {
      emit(GamesState.gamesError(
        const AppErrors.connectionError(),
        () => createGame(
          title: title,
          location: location,
          dateTime: dateTime,
          maxPlayers: maxPlayers,
          description: description,
          sportType: sportType,
        ),
      ));
    }
  }

  /// Join a game
  void joinGame(int gameId) async {
    emit(const GamesState.gamesLoading());

    try {
      final param = JoinGameParam(gameId: gameId);

      final result = await getIt<JoinGameUsecase>()(param);

      result.pick(
        onData: (data) {
          _currentGameDetailsEntity = data;
          emit(GamesState.gameJoined(data));
          // Reload games list after joining a game
          loadGames();
        },
        onError: (error) {
          emit(GamesState.gamesError(
            error,
            () => joinGame(gameId),
          ));
        },
      );
    } catch (e) {
      emit(GamesState.gamesError(
        const AppErrors.connectionError(),
        () => joinGame(gameId),
      ));
    }
  }

  /// Refresh games list
  void refreshGames() {
    loadGames();
  }
}
