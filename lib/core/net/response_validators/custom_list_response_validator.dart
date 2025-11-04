import 'package:scouting_app/export_files.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/core/net/response_validators/response_validator.dart';
import 'package:dio/dio.dart';

class CustomListResponseValidator extends ResponseValidator {
  final String listKey;

  CustomListResponseValidator({this.listKey = "data"});

  @override
  void processData(Response response) {
    if (response.data is! Map<String, dynamic> ||
        response.data[listKey] is! List) {
      error = AppErrors.customError(message: "notValidResponse".tr);
      errorMessage = "notValidResponse".tr;
    }
  }
}
