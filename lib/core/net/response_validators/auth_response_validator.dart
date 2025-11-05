import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class AuthResponseValidator extends ResponseValidator {
  @override
  void processData(Response response) {
    // Check HTTP status code first
    if (response.statusCode.toString().startsWith('2') == false) {
      error = AppErrors.customError(
        message: response.data["message"] ?? "HTTP Error",
        errors: response.data["errors"] ?? {"Error": "HTTP Status Error"},
      );
      errorMessage = response.data["message"] ?? "HTTP Error";
      return;
    }

    // Check api_status field in response body for WoWonder API authentication responses
    if (response.data != null && response.data["api_status"] != null) {
      final apiStatus = response.data["api_status"].toString();

      // Check if api_status indicates an error
      if (apiStatus != "200" && apiStatus != "220") {
        final errorText = response.data["errors"]?["error_text"] ??
            response.data["message"] ??
            "Authentication failed";

        error = AppErrors.customError(
          message: errorText,
          errors: response.data["errors"] ?? {"api_status": apiStatus},
        );
        errorMessage = errorText;
        return;
      }
    }

    // Check success field for Scouting API authentication responses
    if (response.data != null && response.data["success"] != null) {
      final success = response.data["success"];

      // If success is false, check for error message
      if (success == false) {
        final errorText = response.data["message"] ?? "Authentication failed";
        final errors = response.data["errors"] ?? {"error": errorText};

        error = AppErrors.customError(
          message: errorText,
          errors: errors,
        );
        errorMessage = errorText;
        return;
      }
    }
  }
}
