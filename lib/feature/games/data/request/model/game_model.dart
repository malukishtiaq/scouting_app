import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/games/domain/entity/game_entity.dart';

/// Game Model
class GameModel extends BaseModel<GameEntity> {
  final int id;
  final String title;
  final String location;
  final String dateTime;
  final int hostId;
  final String hostName;
  final String hostAvatar;
  final int hostReliability;
  final int playersCount;
  final int maxPlayers;
  final String fieldImage;
  final String description;
  final String sportType;
  final String status;

  GameModel({
    required this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    required this.hostReliability,
    required this.playersCount,
    required this.maxPlayers,
    required this.fieldImage,
    required this.description,
    required this.sportType,
    required this.status,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      dateTime: json['date_time'] ?? '',
      hostId: json['host_id'] ?? 0,
      hostName: json['host_name'] ?? '',
      hostAvatar: json['host_avatar'] ?? '',
      hostReliability: json['host_reliability'] ?? 0,
      playersCount: json['players_count'] ?? 0,
      maxPlayers: json['max_players'] ?? 0,
      fieldImage: json['field_image'] ?? '',
      description: json['description'] ?? '',
      sportType: json['sport_type'] ?? '',
      status: json['status'] ?? 'upcoming',
    );
  }

  @override
  GameEntity toEntity() {
    return GameEntity(
      id: id,
      title: title,
      location: location,
      dateTime: dateTime,
      hostId: hostId,
      hostName: hostName,
      hostAvatar: hostAvatar,
      hostReliability: hostReliability,
      playersCount: playersCount,
      maxPlayers: maxPlayers,
      fieldImage: fieldImage,
      description: description,
      sportType: sportType,
      status: status,
    );
  }
}

/// Games List Response Model
class GamesListModel extends BaseModel<GamesListEntity> {
  final bool success;
  final String message;
  final List<GameModel> games;
  final int total;
  final int currentPage;
  final int lastPage;

  GamesListModel({
    required this.success,
    required this.message,
    required this.games,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory GamesListModel.fromJson(Map<String, dynamic> json) {
    return GamesListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      games: (json['data'] as List<dynamic>?)
              ?.map((game) => GameModel.fromJson(game))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
    );
  }

  @override
  GamesListEntity toEntity() {
    return GamesListEntity(
      success: success,
      message: message,
      games: games.map((game) => game.toEntity()).toList(),
      total: total,
      currentPage: currentPage,
      lastPage: lastPage,
    );
  }
}

/// Game Player Model
class GamePlayerModel extends BaseModel<GamePlayerEntity> {
  final int id;
  final String name;
  final String avatar;
  final String position;
  final int rating;
  final bool isHost;

  GamePlayerModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.position,
    required this.rating,
    required this.isHost,
  });

  factory GamePlayerModel.fromJson(Map<String, dynamic> json) {
    return GamePlayerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      position: json['position'] ?? '',
      rating: json['rating'] ?? 0,
      isHost: json['is_host'] ?? false,
    );
  }

  @override
  GamePlayerEntity toEntity() {
    return GamePlayerEntity(
      id: id,
      name: name,
      avatar: avatar,
      position: position,
      rating: rating,
      isHost: isHost,
    );
  }
}

/// Game Details Response Model
class GameDetailsModel extends BaseModel<GameDetailsEntity> {
  final bool success;
  final String message;
  final GameModel game;
  final List<GamePlayerModel> players;

  GameDetailsModel({
    required this.success,
    required this.message,
    required this.game,
    required this.players,
  });

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) {
    return GameDetailsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      game: GameModel.fromJson(json['game'] ?? {}),
      players: (json['players'] as List<dynamic>?)
              ?.map((player) => GamePlayerModel.fromJson(player))
              .toList() ??
          [],
    );
  }

  @override
  GameDetailsEntity toEntity() {
    return GameDetailsEntity(
      success: success,
      message: message,
      game: game.toEntity(),
      players: players.map((player) => player.toEntity()).toList(),
    );
  }
}

