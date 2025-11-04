import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/errors/app_errors.dart';
import '../../../../mainapis.dart';
import '../../../../core/common/local_storage.dart';
import '../request/model/update_settings_response_model.dart';
import '../request/param/update_privacy_settings_param.dart';
import '../request/param/update_notification_settings_param.dart';
import '../request/param/update_general_settings_param.dart';
import 'isettings_remote_source.dart';

class SettingsRemoteSource extends ISettingsRemoteSource {
  @override
  Future<Either<AppErrors, UpdateSettingsResponseModel>> updatePrivacySettings(
    UpdatePrivacySettingsParam param,
  ) async {
    try {
      final accessToken = LocalStorage.authToken;
      if (accessToken == null || accessToken.isEmpty) {
        return Left(
            AppErrors.customError(message: 'Access token not available'));
      }

      final uri = Uri.parse(
          '${MainAPIS.websiteUrl}${MainAPIS.apiUpdateUserData}?access_token=$accessToken');

      final request = http.MultipartRequest('POST', uri);
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add form fields
      final paramMap = param.toMap();
      paramMap.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = UpdateSettingsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<AppErrors, UpdateSettingsResponseModel>>
      updateNotificationSettings(
    UpdateNotificationSettingsParam param,
  ) async {
    try {
      final accessToken = LocalStorage.authToken;
      if (accessToken == null || accessToken.isEmpty) {
        return Left(
            AppErrors.customError(message: 'Access token not available'));
      }

      final uri = Uri.parse(
          '${MainAPIS.websiteUrl}${MainAPIS.apiUpdateUserData}?access_token=$accessToken');

      final request = http.MultipartRequest('POST', uri);
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add form fields
      final paramMap = param.toMap();
      paramMap.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = UpdateSettingsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<AppErrors, UpdateSettingsResponseModel>> updateGeneralSettings(
    UpdateGeneralSettingsParam param,
  ) async {
    try {
      final accessToken = LocalStorage.authToken;
      if (accessToken == null || accessToken.isEmpty) {
        return Left(
            AppErrors.customError(message: 'Access token not available'));
      }

      final uri = Uri.parse(
          '${MainAPIS.websiteUrl}${MainAPIS.apiUpdateUserData}?access_token=$accessToken');

      final request = http.MultipartRequest('POST', uri);
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add form fields
      final paramMap = param.toMap();
      paramMap.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = UpdateSettingsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }
}
