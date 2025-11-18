import '../../../../core/entities/base_entity.dart';

/// Game Entity
class GameEntity extends BaseEntity {
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
  final String status; // upcoming, ongoing, completed, cancelled

  GameEntity({
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

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        dateTime,
        hostId,
        hostName,
        hostAvatar,
        hostReliability,
        playersCount,
        maxPlayers,
        fieldImage,
        description,
        sportType,
        status,
      ];
}

/// Games List Response Entity
class GamesListEntity extends BaseEntity {
  final bool success;
  final String message;
  final List<GameEntity> games;
  final int total;
  final int currentPage;
  final int lastPage;

  GamesListEntity({
    required this.success,
    required this.message,
    required this.games,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        games,
        total,
        currentPage,
        lastPage,
      ];
}

/// Game Details Entity
class GameDetailsEntity extends BaseEntity {
  final bool success;
  final String message;
  final GameEntity game;
  final List<GamePlayerEntity> players;

  GameDetailsEntity({
    required this.success,
    required this.message,
    required this.game,
    required this.players,
  });

  @override
  List<Object?> get props => [success, message, game, players];
}

/// Game Player Entity
class GamePlayerEntity extends BaseEntity {
  final int id;
  final String name;
  final String avatar;
  final String position;
  final int rating;
  final bool isHost;

  GamePlayerEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.position,
    required this.rating,
    required this.isHost,
  });

  @override
  List<Object?> get props => [id, name, avatar, position, rating, isHost];
}

