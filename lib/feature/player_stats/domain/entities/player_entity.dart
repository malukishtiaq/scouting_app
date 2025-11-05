import 'package:equatable/equatable.dart';

import '../../../../core/entities/base_entity.dart';

/// Player Entity - Domain Layer
/// Contains all player information including personal details, stats, and media
class PlayerEntity extends BaseEntity {
  final String? playerId;
  final String? fullName;
  final String? avatar;
  final String? coverImage;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? team;
  final String? position;
  final String? height;
  final String? weight;
  final String? age;
  final String? graduationClass;
  final String? school;
  final String? averageLocation;
  final String? bio;
  final bool? verified;
  final bool? isPro;
  final PlayerStatsEntity? stats;
  final List<GameEntity>? upcomingGames;
  final List<MediaEntity>? media;

  PlayerEntity({
    this.playerId,
    this.fullName,
    this.avatar,
    this.coverImage,
    this.username,
    this.email,
    this.phoneNumber,
    this.team,
    this.position,
    this.height,
    this.weight,
    this.age,
    this.graduationClass,
    this.school,
    this.averageLocation,
    this.bio,
    this.verified,
    this.isPro,
    this.stats,
    this.upcomingGames,
    this.media,
  });

  @override
  List<Object?> get props => [
        playerId,
        fullName,
        avatar,
        coverImage,
        username,
        email,
        phoneNumber,
        team,
        position,
        height,
        weight,
        age,
        graduationClass,
        school,
        averageLocation,
        bio,
        verified,
        isPro,
        stats,
        upcomingGames,
        media,
      ];

  PlayerEntity copyWith({
    String? playerId,
    String? fullName,
    String? avatar,
    String? coverImage,
    String? username,
    String? email,
    String? phoneNumber,
    String? team,
    String? position,
    String? height,
    String? weight,
    String? age,
    String? graduationClass,
    String? school,
    String? averageLocation,
    String? bio,
    bool? verified,
    bool? isPro,
    PlayerStatsEntity? stats,
    List<GameEntity>? upcomingGames,
    List<MediaEntity>? media,
  }) {
    return PlayerEntity(
      playerId: playerId ?? this.playerId,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      coverImage: coverImage ?? this.coverImage,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      team: team ?? this.team,
      position: position ?? this.position,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      graduationClass: graduationClass ?? this.graduationClass,
      school: school ?? this.school,
      averageLocation: averageLocation ?? this.averageLocation,
      bio: bio ?? this.bio,
      verified: verified ?? this.verified,
      isPro: isPro ?? this.isPro,
      stats: stats ?? this.stats,
      upcomingGames: upcomingGames ?? this.upcomingGames,
      media: media ?? this.media,
    );
  }
}

/// Player Stats Entity
class PlayerStatsEntity extends Equatable {
  final int? gamesPlayed;
  final int? goals;
  final int? assists;
  final int? yellowCards;
  final int? redCards;
  final int? minutesPlayed;
  final double? averageRating;
  final int? cleanSheets;
  final int? saves;

  const PlayerStatsEntity({
    this.gamesPlayed,
    this.goals,
    this.assists,
    this.yellowCards,
    this.redCards,
    this.minutesPlayed,
    this.averageRating,
    this.cleanSheets,
    this.saves,
  });

  @override
  List<Object?> get props => [
        gamesPlayed,
        goals,
        assists,
        yellowCards,
        redCards,
        minutesPlayed,
        averageRating,
        cleanSheets,
        saves,
      ];

  PlayerStatsEntity copyWith({
    int? gamesPlayed,
    int? goals,
    int? assists,
    int? yellowCards,
    int? redCards,
    int? minutesPlayed,
    double? averageRating,
    int? cleanSheets,
    int? saves,
  }) {
    return PlayerStatsEntity(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      goals: goals ?? this.goals,
      assists: assists ?? this.assists,
      yellowCards: yellowCards ?? this.yellowCards,
      redCards: redCards ?? this.redCards,
      minutesPlayed: minutesPlayed ?? this.minutesPlayed,
      averageRating: averageRating ?? this.averageRating,
      cleanSheets: cleanSheets ?? this.cleanSheets,
      saves: saves ?? this.saves,
    );
  }
}

/// Game Entity - Represents upcoming games
class GameEntity extends Equatable {
  final String? gameId;
  final String? opponent;
  final String? date;
  final String? time;
  final String? location;
  final String? homeAway; // "Home" or "Away"
  final String? competition;

  const GameEntity({
    this.gameId,
    this.opponent,
    this.date,
    this.time,
    this.location,
    this.homeAway,
    this.competition,
  });

  @override
  List<Object?> get props => [
        gameId,
        opponent,
        date,
        time,
        location,
        homeAway,
        competition,
      ];

  GameEntity copyWith({
    String? gameId,
    String? opponent,
    String? date,
    String? time,
    String? location,
    String? homeAway,
    String? competition,
  }) {
    return GameEntity(
      gameId: gameId ?? this.gameId,
      opponent: opponent ?? this.opponent,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      homeAway: homeAway ?? this.homeAway,
      competition: competition ?? this.competition,
    );
  }
}

/// Media Entity - Represents player videos and photos
class MediaEntity extends Equatable {
  final String? mediaId;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? mediaType; // "video" or "photo"
  final String? title;
  final String? description;
  final String? uploadDate;
  final int? duration; // In seconds (for videos)

  const MediaEntity({
    this.mediaId,
    this.mediaUrl,
    this.thumbnailUrl,
    this.mediaType,
    this.title,
    this.description,
    this.uploadDate,
    this.duration,
  });

  @override
  List<Object?> get props => [
        mediaId,
        mediaUrl,
        thumbnailUrl,
        mediaType,
        title,
        description,
        uploadDate,
        duration,
      ];

  MediaEntity copyWith({
    String? mediaId,
    String? mediaUrl,
    String? thumbnailUrl,
    String? mediaType,
    String? title,
    String? description,
    String? uploadDate,
    int? duration,
  }) {
    return MediaEntity(
      mediaId: mediaId ?? this.mediaId,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      description: description ?? this.description,
      uploadDate: uploadDate ?? this.uploadDate,
      duration: duration ?? this.duration,
    );
  }
}
