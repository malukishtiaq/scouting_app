import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:scouting_app/core/common/app_config.dart';

import '../common/local_storage.dart';
import '../constants/app/app_constants.dart';
import '../../mainapis.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final os = AppConfig().os;
    if (os != null) options.headers[AppConstants.HEADER_OS] = '$os';

    final appVersion = AppConfig().appVersion;
    if (appVersion != null) {
      options.headers[AppConstants.HEADER_APP_VERSION] = appVersion;
    }
    options.headers[AppConstants.HEADER_ACCEPT] =
        'application/json, text/plain, */*';

    final token = LocalStorage.authToken;
    if (token != null && token.isNotEmpty) {
      options.headers[AppConstants.HEADER_AUTH] = 'Bearer $token';
    } else {
      options.headers.remove(AppConstants.HEADER_AUTH);
    }

    // Set headers to avoid bot-protection blocks (Imunify360)
    const userAgent =
        'Mozilla/5.0 (Linux; Android 13; SM-A146B Build/TQ3A.230705.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/124.0.0.0 Mobile Safari/537.36';
    options.headers['User-Agent'] = userAgent;
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['Origin'] = MainAPIS.websiteUrl;
    options.headers['Referer'] = MainAPIS.websiteUrl;

    options.headers[AppConstants.APP_NAME] = AppConstants.TITLE_APP_NAME;

    options.headers[AppConstants.HEADER_LANGUAGE] = Intl.getCurrentLocale();

    return super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final int startTime = response.requestOptions.extra['startTime'];
    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final int requestDuration = endTime - startTime;

    if (kDebugMode) {
      print(
          'Request to ${response.requestOptions.path} took: ${requestDuration}ms');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final int startTime = err.requestOptions.extra['startTime'];
    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final int requestDuration = endTime - startTime;

    if (kDebugMode) {
      print(
          'Request to ${err.requestOptions.path} took: ${requestDuration}ms (with error)');
    }
    super.onError(err, handler);
  }
}
