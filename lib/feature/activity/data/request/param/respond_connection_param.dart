import 'package:scouting_app/core/params/base_params.dart';

/// Parameter for responding to connection request
class RespondConnectionParam extends BaseParams {
  final int activityId;
  final bool accept; // true for accept, false for decline

  RespondConnectionParam({
    required this.activityId,
    required this.accept,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'activity_id': activityId,
      'accept': accept,
    };
  }
}

