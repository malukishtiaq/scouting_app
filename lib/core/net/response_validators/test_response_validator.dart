import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';

class TestResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    if (data["message"].toString().contains("Fail")) {
      error = AppErrors.customError(message: data["message"]);
      errorMessage = data["message"];
    }
  }
}
