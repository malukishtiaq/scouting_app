import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class ReferralResponseValidator extends ResponseValidator {
  @override
  void processData(Response response) {
    // First check HTTP status code
    if (response.statusCode.toString().startsWith('2') == false) {
      error = AppErrors.customError(
        message:
            response.data["message"] ?? "HTTP Error ${response.statusCode}",
        errors: response.data["errors"] as Map<String, dynamic>? ?? {},
      );
      errorMessage =
          response.data["message"] ?? "HTTP Error ${response.statusCode}";
      return;
    }

    // If HTTP status is 200, check the api_status in the response body
    if (response.data is Map<String, dynamic>) {
      final apiStatus = response.data["api_status"];

      // If api_status is 200, it's successful
      if (apiStatus == 200) {
        return; // Success
      }

      // If api_status is 220 (pending verification), treat as success with empty data
      if (apiStatus == 220) {
        return; // Success with pending verification
      }

      // For other api_status values (like 404), check if there's actual data
      // If there's data in the response, treat it as success regardless of api_status
      final hasData = response.data["data"] != null &&
          (response.data["data"] is List
              ? (response.data["data"] as List).isNotEmpty
              : response.data["data"] is Map
                  ? (response.data["data"] as Map).isNotEmpty
                  : response.data["data"].toString().isNotEmpty);

      if (hasData) {
        return; // Success - we have data despite api_status
      }

      // Only treat as error if there's no data and api_status indicates error
      error = AppErrors.customError(
        message: response.data["errors"]?["error_text"] ??
            response.data["message"] ??
            "API Error: Status $apiStatus",
        errors: response.data["errors"] as Map<String, dynamic>? ?? {},
      );
      errorMessage = response.data["errors"]?["error_text"] ??
          response.data["message"] ??
          "API Error: Status $apiStatus";
    }
  }
}
