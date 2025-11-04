import 'package:scouting_app/export_files.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class FriendsResponseValidator extends ResponseValidator {
  @override
  void processData(Response response) {
    if (response.data is! Map<String, dynamic>) {
      error = AppErrors.customError(message: "notValidResponse".tr);
      errorMessage = "notValidResponse".tr;
      return;
    }

    final data = response.data as Map<String, dynamic>;

    // Check if the response has the expected structure for friends API
    if (!data.containsKey('data') || data['data'] is! Map<String, dynamic>) {
      error = AppErrors.customError(message: "notValidResponse".tr);
      errorMessage = "notValidResponse".tr;
      return;
    }

    final friendsData = data['data'] as Map<String, dynamic>;

    // Check if we have following or followers arrays
    if (!friendsData.containsKey('following') &&
        !friendsData.containsKey('followers')) {
      error = AppErrors.customError(message: "notValidResponse".tr);
      errorMessage = "notValidResponse".tr;
      return;
    }

    // Transform the response to match what listRequest expects
    final List<dynamic> friendsList = [];

    if (friendsData['following'] is List) {
      friendsList.addAll(friendsData['following'] as List<dynamic>);
    }

    if (friendsData['followers'] is List) {
      friendsList.addAll(friendsData['followers'] as List<dynamic>);
    }

    // Replace the response data with the flattened list
    response.data = {
      'data': friendsList,
      'api_status': data['api_status'],
    };
  }
}
