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

    // Check api_status field in response body for authentication responses
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
  }
}
