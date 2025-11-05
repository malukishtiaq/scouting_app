import '../../../../core/models/base_model.dart';
import '../../domain/entity/explore_player_entity.dart';

/// Explore Player Model - Data Layer
/// Lightweight player data for explore/search results
class ExplorePlayerModel extends BaseModel<ExplorePlayerEntity> {
  final String? playerId;
  final String? fullName;
  final String? username;
  final String? avatar;
  final String? position;
  final String? team;
  final String? location;
  final String? age;
  final String? graduationClass;
  final bool? verified;
  final bool? isPro;
  final double? distanceKm;
  final int? matchPercentage;

  ExplorePlayerModel({
    this.playerId,
    this.fullName,
    this.username,
    this.avatar,
    this.position,
    this.team,
    this.location,
    this.age,
    this.graduationClass,
    this.verified,
    this.isPro,
    this.distanceKm,
    this.matchPercentage,
  });

  factory ExplorePlayerModel.fromJson(Map<String, dynamic> json) {
    return ExplorePlayerModel(
      playerId: json['player_id']?.toString() ?? json['user_id']?.toString(),
      fullName: json['full_name'] ?? json['name'],
      username: json['username'],
      avatar: json['avatar'] ?? json['profile_picture'],
      position: json['position'],
      team: json['team'],
      location: json['location'],
      age: json['age']?.toString(),
      graduationClass: json['graduation_class']?.toString(),
      verified: json['verified'] ?? false,
      isPro: json['is_pro'] ?? json['pro'] ?? false,
      distanceKm: json['distance_km']?.toDouble() ?? json['distance']?.toDouble(),
      matchPercentage: json['match_percentage']?.toInt() ?? json['match']?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_id': playerId,
      'full_name': fullName,
      'username': username,
      'avatar': avatar,
      'position': position,
      'team': team,
      'location': location,
      'age': age,
      'graduation_class': graduationClass,
      'verified': verified,
      'is_pro': isPro,
      'distance_km': distanceKm,
      'match_percentage': matchPercentage,
    };
  }

  @override
  ExplorePlayerEntity toEntity() {
    return ExplorePlayerEntity(
      playerId: playerId,
      fullName: fullName,
      username: username,
      avatar: avatar,
      position: position,
      team: team,
      location: location,
      age: age,
      graduationClass: graduationClass,
      verified: verified,
      isPro: isPro,
      distanceKm: distanceKm,
      matchPercentage: matchPercentage,
    );
  }
}

/// Explore Response Model - Data Layer
/// Contains list of players and metadata
class ExploreResponseModel extends BaseModel<ExploreResponseEntity> {
  final int apiStatus;
  final List<ExplorePlayerModel>? players;
  final int? totalCount;
  final int? currentPage;
  final int? totalPages;
  final String? message;

  ExploreResponseModel({
    required this.apiStatus,
    this.players,
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.message,
  });

  factory ExploreResponseModel.fromJson(Map<String, dynamic> json) {
    List<ExplorePlayerModel>? playersList;
    
    // Handle different response structures
    if (json['data'] != null && json['data'] is List) {
      playersList = (json['data'] as List)
          .map((item) => ExplorePlayerModel.fromJson(item))
          .toList();
    } else if (json['players'] != null && json['players'] is List) {
      playersList = (json['players'] as List)
          .map((item) => ExplorePlayerModel.fromJson(item))
          .toList();
    } else if (json['users'] != null && json['users'] is List) {
      playersList = (json['users'] as List)
          .map((item) => ExplorePlayerModel.fromJson(item))
          .toList();
    }

    return ExploreResponseModel(
      apiStatus: json['api_status'] ?? 200,
      players: playersList,
      totalCount: json['total_count']?.toInt() ?? json['total']?.toInt(),
      currentPage: json['current_page']?.toInt() ?? json['page']?.toInt(),
      totalPages: json['total_pages']?.toInt() ?? json['pages']?.toInt(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api_status': apiStatus,
      'data': players?.map((player) => player.toJson()).toList(),
      'total_count': totalCount,
      'current_page': currentPage,
      'total_pages': totalPages,
      'message': message,
    };
  }

  @override
  ExploreResponseEntity toEntity() {
    return ExploreResponseEntity(
      players: players?.map((model) => model.toEntity()).toList(),
      totalCount: totalCount,
      currentPage: currentPage,
      totalPages: totalPages,
      message: message,
    );
  }
}

