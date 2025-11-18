import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/feature/games/data/request/model/game_model.dart';
import 'package:scouting_app/feature/games/data/request/param/list_games_param.dart';
import 'package:scouting_app/feature/games/data/request/param/get_game_details_param.dart';
import 'package:scouting_app/feature/games/data/request/param/create_game_param.dart';
import 'package:scouting_app/feature/games/data/request/param/join_game_param.dart';
import 'package:scouting_app/feature/games/data/datasource/igames_remote.dart';

@Injectable(as: IGamesRemoteSource)
class GamesRemoteSource extends IGamesRemoteSource {
  @override
  Future<Either<AppErrors, GamesListModel>> listGames(
      ListGamesParam param) async {
    // TODO: Replace with actual API endpoint when backend is ready
    // return request<GamesListModel>(
    //   method: HttpMethod.get,
    //   url: '${MainApis.baseUrl}/games',
    //   queryParameters: param.toMap(),
    //   createModel: GamesListModel.fromJson,
    // );

    // Mock API response - simulating what the real API would return
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay

    // GamesListModel expects: data as List, total, current_page, last_page at root
    final mockJsonResponse = {
      'success': true,
      'message': 'Games fetched successfully',
      'data': [
        {
          'id': 1,
          'title': 'Central Park',
          'location': 'Central Park',
          'date_time': 'Tomorrow, 5:00 PM',
          'host_id': 1,
          'host_name': 'Alex',
          'host_avatar': 'https://i.pravatar.cc/150?img=1',
          'host_reliability': 100,
          'players_count': 10,
          'max_players': 22,
          'field_image':
              'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=400',
          'description':
              'Join us for a friendly football match at Central Park!',
          'sport_type': 'Football',
          'status': 'upcoming',
        },
        {
          'id': 2,
          'title': 'Riverside Park',
          'location': 'Riverside Park',
          'date_time': 'Next Saturday, 10:00 AM',
          'host_id': 2,
          'host_name': 'Ethan',
          'host_avatar': 'https://i.pravatar.cc/150?img=2',
          'host_reliability': 95,
          'players_count': 12,
          'max_players': 22,
          'field_image':
              'https://images.unsplash.com/photo-1556056504-5c7696c4c28d?w=400',
          'description': 'Morning football session at Riverside Park',
          'sport_type': 'Football',
          'status': 'upcoming',
        },
        {
          'id': 3,
          'title': 'Prospect Park',
          'location': 'Prospect Park',
          'date_time': 'Next Sunday, 2:00 PM',
          'host_id': 3,
          'host_name': 'Liam',
          'host_avatar': 'https://i.pravatar.cc/150?img=3',
          'host_reliability': 98,
          'players_count': 8,
          'max_players': 22,
          'field_image':
              'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400',
          'description': 'Afternoon football match at Prospect Park',
          'sport_type': 'Football',
          'status': 'upcoming',
        },
      ],
      'total': 3,
      'current_page': 1,
      'last_page': 1,
    };

    try {
      final model = GamesListModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppErrors, GameDetailsModel>> getGameDetails(
      GetGameDetailsParam param) async {
    // TODO: Replace with actual API endpoint when backend is ready
    // return request<GameDetailsModel>(
    //   method: HttpMethod.get,
    //   url: '${MainApis.baseUrl}/games/${param.gameId}',
    //   createModel: GameDetailsModel.fromJson,
    // );

    // Mock API response
    await Future.delayed(const Duration(milliseconds: 500));

    // GameDetailsModel expects: game and players at root level
    final mockJsonResponse = {
      'success': true,
      'message': 'Game details fetched successfully',
      'game': {
        'id': param.gameId,
        'title': 'Central Park',
        'location': 'Central Park',
        'date_time': 'Tomorrow, 5:00 PM',
        'host_id': 1,
        'host_name': 'Alex',
        'host_avatar': 'https://i.pravatar.cc/150?img=1',
        'host_reliability': 100,
        'players_count': 10,
        'max_players': 22,
        'field_image':
            'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=400',
        'description':
            'Join us for a friendly football match at Central Park!',
        'sport_type': 'Football',
        'status': 'upcoming',
      },
      'players': [
        {
          'id': 1,
          'name': 'Alex',
          'avatar': 'https://i.pravatar.cc/150?img=1',
          'position': 'Forward',
          'rating': 4,
          'is_host': true,
        },
        {
          'id': 2,
          'name': 'John Doe',
          'avatar': 'https://i.pravatar.cc/150?img=4',
          'position': 'Midfielder',
          'rating': 5,
          'is_host': false,
        },
        {
          'id': 3,
          'name': 'Jane Smith',
          'avatar': 'https://i.pravatar.cc/150?img=5',
          'position': 'Defender',
          'rating': 4,
          'is_host': false,
        },
      ],
    };

    try {
      final model = GameDetailsModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppErrors, GameDetailsModel>> createGame(
      CreateGameParam param) async {
    // TODO: Replace with actual API endpoint when backend is ready
    // return request<GameDetailsModel>(
    //   method: HttpMethod.post,
    //   url: '${MainApis.baseUrl}/games',
    //   body: param.toMap(),
    //   createModel: GameDetailsModel.fromJson,
    // );

    // Mock API response
    await Future.delayed(const Duration(milliseconds: 500));

    // GameDetailsModel expects: game and players at root level
    final mockJsonResponse = {
      'success': true,
      'message': 'Game created successfully',
      'game': {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': param.title,
        'location': param.location,
        'date_time': param.dateTime,
        'host_id': 1,
        'host_name': 'You',
        'host_avatar': 'https://i.pravatar.cc/150?img=1',
        'host_reliability': 100,
        'players_count': 1,
        'max_players': param.maxPlayers,
        'field_image':
            'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=400',
        'description': param.description,
        'sport_type': param.sportType,
        'status': 'upcoming',
      },
      'players': [
        {
          'id': 1,
          'name': 'You',
          'avatar': 'https://i.pravatar.cc/150?img=1',
          'position': 'Host',
          'rating': 5,
          'is_host': true,
        },
      ],
    };

    try {
      final model = GameDetailsModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }

  @override
  Future<Either<AppErrors, GameDetailsModel>> joinGame(
      JoinGameParam param) async {
    // TODO: Replace with actual API endpoint when backend is ready
    // return request<GameDetailsModel>(
    //   method: HttpMethod.post,
    //   url: '${MainApis.baseUrl}/games/${param.gameId}/join',
    //   createModel: GameDetailsModel.fromJson,
    // );

    // Mock API response
    await Future.delayed(const Duration(milliseconds: 500));

    // GameDetailsModel expects: game and players at root level
    final mockJsonResponse = {
      'success': true,
      'message': 'Successfully joined game',
      'game': {
        'id': param.gameId,
        'title': 'Central Park',
        'location': 'Central Park',
        'date_time': 'Tomorrow, 5:00 PM',
        'host_id': 1,
        'host_name': 'Alex',
        'host_avatar': 'https://i.pravatar.cc/150?img=1',
        'host_reliability': 100,
        'players_count': 11,
        'max_players': 22,
        'field_image':
            'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=400',
        'description':
            'Join us for a friendly football match at Central Park!',
        'sport_type': 'Football',
        'status': 'upcoming',
      },
      'players': [
        {
          'id': 1,
          'name': 'Alex',
          'avatar': 'https://i.pravatar.cc/150?img=1',
          'position': 'Forward',
          'rating': 4,
          'is_host': true,
        },
        {
          'id': 2,
          'name': 'John Doe',
          'avatar': 'https://i.pravatar.cc/150?img=4',
          'position': 'Midfielder',
          'rating': 5,
          'is_host': false,
        },
        {
          'id': DateTime.now().millisecondsSinceEpoch,
          'name': 'You',
          'avatar': 'https://i.pravatar.cc/150?img=10',
          'position': 'Player',
          'rating': 4,
          'is_host': false,
        },
      ],
    };

    try {
      final model = GameDetailsModel.fromJson(mockJsonResponse);
      return Right(model);
    } catch (e) {
      return Left(AppErrors.customError(message: e.toString()));
    }
  }
}
