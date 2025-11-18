import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for listing games
class ListGamesParam extends BaseParams {
  final int page;
  final int perPage;
  final String? status; // upcoming, ongoing, completed, cancelled
  final String? sportType; // football, basketball, etc.

  ListGamesParam({
    this.page = 1,
    this.perPage = 20,
    this.status,
    this.sportType,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'per_page': perPage,
      if (status != null) 'status': status,
      if (sportType != null) 'sport_type': sportType,
    };
  }
}

