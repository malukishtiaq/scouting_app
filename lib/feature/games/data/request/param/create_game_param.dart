import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for creating a new game
class CreateGameParam extends BaseParams {
  final String title;
  final String location;
  final String dateTime;
  final int maxPlayers;
  final String description;
  final String sportType;

  CreateGameParam({
    required this.title,
    required this.location,
    required this.dateTime,
    required this.maxPlayers,
    required this.description,
    required this.sportType,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'date_time': dateTime,
      'max_players': maxPlayers,
      'description': description,
      'sport_type': sportType,
    };
  }
}

