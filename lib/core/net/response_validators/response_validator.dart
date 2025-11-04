import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app/core/errors/app_errors.dart';

abstract class ResponseValidator {
  AppErrors? error;
  String? errorMessage;

  void processData(Response response);

  bool get isValid {
    return !hasError;
  }

  bool get hasError {
    return error != null;
  }

  AppErrors get getError {
    if (error != null) {
      return error!;
    } else {
      throw FlutterError("Call [hasError] before to check there is an error");
    }
  }
}
