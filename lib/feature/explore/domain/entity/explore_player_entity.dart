import 'package:equatable/equatable.dart';

/// Explore Player Entity - Domain Layer
/// Lightweight player data for explore/search results
class ExplorePlayerEntity extends Equatable {
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
  final double? distanceKm; // Distance from user in kilometers
  final int? matchPercentage; // Match percentage for recommendations

  const ExplorePlayerEntity({
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

  @override
  List<Object?> get props => [
        playerId,
        fullName,
        username,
        avatar,
        position,
        team,
        location,
        age,
        graduationClass,
        verified,
        isPro,
        distanceKm,
        matchPercentage,
      ];

  ExplorePlayerEntity copyWith({
    String? playerId,
    String? fullName,
    String? username,
    String? avatar,
    String? position,
    String? team,
    String? location,
    String? age,
    String? graduationClass,
    bool? verified,
    bool? isPro,
    double? distanceKm,
    int? matchPercentage,
  }) {
    return ExplorePlayerEntity(
      playerId: playerId ?? this.playerId,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      position: position ?? this.position,
      team: team ?? this.team,
      location: location ?? this.location,
      age: age ?? this.age,
      graduationClass: graduationClass ?? this.graduationClass,
      verified: verified ?? this.verified,
      isPro: isPro ?? this.isPro,
      distanceKm: distanceKm ?? this.distanceKm,
      matchPercentage: matchPercentage ?? this.matchPercentage,
    );
  }
}

/// Explore Response Entity - Contains list of players and metadata
class ExploreResponseEntity extends Equatable {
  final List<ExplorePlayerEntity>? players;
  final int? totalCount;
  final int? currentPage;
  final int? totalPages;
  final String? message;

  const ExploreResponseEntity({
    this.players,
    this.totalCount,
    this.currentPage,
    this.totalPages,
    this.message,
  });

  @override
  List<Object?> get props => [
        players,
        totalCount,
        currentPage,
        totalPages,
        message,
      ];

  ExploreResponseEntity copyWith({
    List<ExplorePlayerEntity>? players,
    int? totalCount,
    int? currentPage,
    int? totalPages,
    String? message,
  }) {
    return ExploreResponseEntity(
      players: players ?? this.players,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      message: message ?? this.message,
    );
  }
}

