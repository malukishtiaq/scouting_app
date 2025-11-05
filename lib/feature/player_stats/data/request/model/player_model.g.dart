// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => PlayerModel(
      playerId: json['player_id'] as String?,
      fullName: json['full_name'] as String?,
      avatar: json['avatar'] as String?,
      coverImage: json['cover_image'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      team: json['team'] as String?,
      position: json['position'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      age: json['age'] as String?,
      graduationClass: json['graduation_class'] as String?,
      school: json['school'] as String?,
      averageLocation: json['average_location'] as String?,
      bio: json['bio'] as String?,
      verified: json['verified'] as bool?,
      isPro: json['is_pro'] as bool?,
      stats: json['stats'] == null
          ? null
          : PlayerStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      upcomingGames: (json['upcoming_games'] as List<dynamic>?)
          ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'full_name': instance.fullName,
      'avatar': instance.avatar,
      'cover_image': instance.coverImage,
      'username': instance.username,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'team': instance.team,
      'position': instance.position,
      'height': instance.height,
      'weight': instance.weight,
      'age': instance.age,
      'graduation_class': instance.graduationClass,
      'school': instance.school,
      'average_location': instance.averageLocation,
      'bio': instance.bio,
      'verified': instance.verified,
      'is_pro': instance.isPro,
      'stats': instance.stats?.toJson(),
      'upcoming_games': instance.upcomingGames?.map((e) => e.toJson()).toList(),
      'media': instance.media?.map((e) => e.toJson()).toList(),
    };

PlayerStatsModel _$PlayerStatsModelFromJson(Map<String, dynamic> json) =>
    PlayerStatsModel(
      gamesPlayed: (json['games_played'] as num?)?.toInt(),
      goals: (json['goals'] as num?)?.toInt(),
      assists: (json['assists'] as num?)?.toInt(),
      yellowCards: (json['yellow_cards'] as num?)?.toInt(),
      redCards: (json['red_cards'] as num?)?.toInt(),
      minutesPlayed: (json['minutes_played'] as num?)?.toInt(),
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      cleanSheets: (json['clean_sheets'] as num?)?.toInt(),
      saves: (json['saves'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayerStatsModelToJson(PlayerStatsModel instance) =>
    <String, dynamic>{
      'games_played': instance.gamesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'yellow_cards': instance.yellowCards,
      'red_cards': instance.redCards,
      'minutes_played': instance.minutesPlayed,
      'average_rating': instance.averageRating,
      'clean_sheets': instance.cleanSheets,
      'saves': instance.saves,
    };

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      gameId: json['game_id'] as String?,
      opponent: json['opponent'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      homeAway: json['home_away'] as String?,
      competition: json['competition'] as String?,
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'game_id': instance.gameId,
      'opponent': instance.opponent,
      'date': instance.date,
      'time': instance.time,
      'location': instance.location,
      'home_away': instance.homeAway,
      'competition': instance.competition,
    };

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      mediaId: json['media_id'] as String?,
      mediaUrl: json['media_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      mediaType: json['media_type'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      uploadDate: json['upload_date'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'media_id': instance.mediaId,
      'media_url': instance.mediaUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'media_type': instance.mediaType,
      'title': instance.title,
      'description': instance.description,
      'upload_date': instance.uploadDate,
      'duration': instance.duration,
    };
