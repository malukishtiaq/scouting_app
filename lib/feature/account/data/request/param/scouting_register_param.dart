import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

/// Scouting API Register Parameter - Simplified for Scouting API
/// Based on: POST /api/members/register
class ScoutingRegisterParam extends BaseParams {
  final String email; // User's email address (required)
  final String password; // User's password (required, min 8 characters)

  ScoutingRegisterParam({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };

  /// Create from form data
  factory ScoutingRegisterParam.fromForm({
    required String email,
    required String password,
  }) {
    return ScoutingRegisterParam(
      email: email.trim(),
      password: password,
    );
  }
}

