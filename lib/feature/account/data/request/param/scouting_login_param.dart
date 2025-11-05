import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

/// Scouting API Login Parameter - Simplified for Scouting API
/// Based on: POST /api/members/login
class ScoutingLoginParam extends BaseParams {
  final String email; // User's email address (required)
  final String password; // User's password (required)

  ScoutingLoginParam({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };

  /// Create from form data
  factory ScoutingLoginParam.fromForm({
    required String email,
    required String password,
  }) {
    return ScoutingLoginParam(
      email: email.trim(),
      password: password,
    );
  }
}

