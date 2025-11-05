import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/player_entity.dart';

part 'player_model.g.dart';

/// Player Model - Data Layer
@JsonSerializable(explicitToJson: true)
class PlayerModel {
  @JsonKey(name: 'player_id')
  final String? playerId;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? avatar;
  @JsonKey(name: 'cover_image')
  final String? coverImage;
  final String? username;
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? team;
  final String? position;
  final String? height;
  final String? weight;
  final String? age;
  @JsonKey(name: 'graduation_class')
  final String? graduationClass;
  final String? school;
  @JsonKey(name: 'average_location')
  final String? averageLocation;
  final String? bio;
  final bool? verified;
  @JsonKey(name: 'is_pro')
  final bool? isPro;
  final PlayerStatsModel? stats;
  @JsonKey(name: 'upcoming_games')
  final List<GameModel>? upcomingGames;
  final List<MediaModel>? media;

  const PlayerModel({
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

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);

  PlayerEntity toEntity() {
    return PlayerEntity(
      playerId: playerId,
      fullName: fullName,
      avatar: avatar,
      coverImage: coverImage,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      team: team,
      position: position,
      height: height,
      weight: weight,
      age: age,
      graduationClass: graduationClass,
      school: school,
      averageLocation: averageLocation,
      bio: bio,
      verified: verified,
      isPro: isPro,
      stats: stats?.toEntity(),
      upcomingGames: upcomingGames?.map((g) => g.toEntity()).toList(),
      media: media?.map((m) => m.toEntity()).toList(),
    );
  }
}

/// Player Stats Model
@JsonSerializable()
class PlayerStatsModel {
  @JsonKey(name: 'games_played')
  final int? gamesPlayed;
  final int? goals;
  final int? assists;
  @JsonKey(name: 'yellow_cards')
  final int? yellowCards;
  @JsonKey(name: 'red_cards')
  final int? redCards;
  @JsonKey(name: 'minutes_played')
  final int? minutesPlayed;
  @JsonKey(name: 'average_rating')
  final double? averageRating;
  @JsonKey(name: 'clean_sheets')
  final int? cleanSheets;
  final int? saves;

  const PlayerStatsModel({
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

  factory PlayerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatsModelToJson(this);

  PlayerStatsEntity toEntity() {
    return PlayerStatsEntity(
      gamesPlayed: gamesPlayed,
      goals: goals,
      assists: assists,
      yellowCards: yellowCards,
      redCards: redCards,
      minutesPlayed: minutesPlayed,
      averageRating: averageRating,
      cleanSheets: cleanSheets,
      saves: saves,
    );
  }
}

/// Game Model
@JsonSerializable()
class GameModel {
  @JsonKey(name: 'game_id')
  final String? gameId;
  final String? opponent;
  final String? date;
  final String? time;
  final String? location;
  @JsonKey(name: 'home_away')
  final String? homeAway;
  final String? competition;

  const GameModel({
    this.gameId,
    this.opponent,
    this.date,
    this.time,
    this.location,
    this.homeAway,
    this.competition,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);
  Map<String, dynamic> toJson() => _$GameModelToJson(this);

  GameEntity toEntity() {
    return GameEntity(
      gameId: gameId,
      opponent: opponent,
      date: date,
      time: time,
      location: location,
      homeAway: homeAway,
      competition: competition,
    );
  }
}

/// Media Model
@JsonSerializable()
class MediaModel {
  @JsonKey(name: 'media_id')
  final String? mediaId;
  @JsonKey(name: 'media_url')
  final String? mediaUrl;
  @JsonKey(name: 'thumbnail_url')
  final String? thumbnailUrl;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  final String? title;
  final String? description;
  @JsonKey(name: 'upload_date')
  final String? uploadDate;
  final int? duration;

  const MediaModel({
    this.mediaId,
    this.mediaUrl,
    this.thumbnailUrl,
    this.mediaType,
    this.title,
    this.description,
    this.uploadDate,
    this.duration,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
  Map<String, dynamic> toJson() => _$MediaModelToJson(this);

  MediaEntity toEntity() {
    return MediaEntity(
      mediaId: mediaId,
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      mediaType: mediaType,
      title: title,
      description: description,
      uploadDate: uploadDate,
      duration: duration,
    );
  }
}

