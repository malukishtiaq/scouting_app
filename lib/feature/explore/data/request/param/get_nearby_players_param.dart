import '../../../../core/params/base_params.dart';

/// Get Nearby Players Param
/// Parameters for fetching nearby players based on location
class GetNearbyPlayersParam extends BaseParams {
  final double? latitude;
  final double? longitude;
  final double? radiusKm; // Search radius in kilometers
  final int? page;
  final int? limit;
  final String? position; // Filter by position (optional)
  final String? ageMin; // Minimum age filter (optional)
  final String? ageMax; // Maximum age filter (optional)

  GetNearbyPlayersParam({
    this.latitude,
    this.longitude,
    this.radiusKm = 50.0,
    this.page = 1,
    this.limit = 20,
    this.position,
    this.ageMin,
    this.ageMax,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'page': page,
      'limit': limit,
      'radius_km': radiusKm,
    };

    if (latitude != null) map['latitude'] = latitude;
    if (longitude != null) map['longitude'] = longitude;
    if (position != null && position!.isNotEmpty) map['position'] = position;
    if (ageMin != null && ageMin!.isNotEmpty) map['age_min'] = ageMin;
    if (ageMax != null && ageMax!.isNotEmpty) map['age_max'] = ageMax;

    return map;
  }
}

