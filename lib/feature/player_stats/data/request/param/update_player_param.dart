import 'package:equatable/equatable.dart';

import '../../../../../core/params/base_params.dart';

/// Parameter for updating player data
class UpdatePlayerParam extends BaseParams {
  final String playerId;
  final String? fullName;
  final String? avatar;
  final String? coverImage;
  final String? team;
  final String? position;
  final String? height;
  final String? weight;
  final String? age;
  final String? graduationClass;
  final String? school;
  final String? averageLocation;
  final String? bio;

  UpdatePlayerParam({
    required this.playerId,
    this.fullName,
    this.avatar,
    this.coverImage,
    this.team,
    this.position,
    this.height,
    this.weight,
    this.age,
    this.graduationClass,
    this.school,
    this.averageLocation,
    this.bio,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'player_id': playerId,
    };

    if (fullName != null) data['full_name'] = fullName;
    if (avatar != null) data['avatar'] = avatar;
    if (coverImage != null) data['cover_image'] = coverImage;
    if (team != null) data['team'] = team;
    if (position != null) data['position'] = position;
    if (height != null) data['height'] = height;
    if (weight != null) data['weight'] = weight;
    if (age != null) data['age'] = age;
    if (graduationClass != null) data['graduation_class'] = graduationClass;
    if (school != null) data['school'] = school;
    if (averageLocation != null) data['average_location'] = averageLocation;
    if (bio != null) data['bio'] = bio;

    return data;
  }

  @override
  List<Object?> get props => [
        playerId,
        fullName,
        avatar,
        coverImage,
        team,
        position,
        height,
        weight,
        age,
        graduationClass,
        school,
        averageLocation,
        bio,
      ];
}
