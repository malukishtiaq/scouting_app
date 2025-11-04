import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(Response response) {
    if (response.statusCode.toString().startsWith('2') == false) {
      error = AppErrors.customError(
        message: response.data["message"],
        errors: response.data["errors"] as Map<String, dynamic>,
      );
      errorMessage = response.data["message"];
    }
  }
}
