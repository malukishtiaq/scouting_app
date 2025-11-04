import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class UserProfileResponseValidator extends ResponseValidator {
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
      if (apiStatus == 200 || apiStatus == "200") {
        // Also check if user_data exists
        if (response.data["user_data"] != null) {
          return; // Success - we have user data
        } else {
          // API says success but no user_data
          error = AppErrors.customError(
            message: "User data not found in response",
          );
          errorMessage = "User data not found in response";
          return;
        }
      }

      // For other api_status values, check if there's an error message
      final errorMsg = response.data["message"] ?? 
                      response.data["error"] ?? 
                      "API returned status: $apiStatus";
      
      error = AppErrors.customError(
        message: errorMsg,
        errors: response.data["errors"] as Map<String, dynamic>? ?? {},
      );
      errorMessage = errorMsg;
    } else {
      // Response is not a Map
      error = AppErrors.customError(
        message: "Invalid response format",
      );
      errorMessage = "Invalid response format";
    }
  }
}

