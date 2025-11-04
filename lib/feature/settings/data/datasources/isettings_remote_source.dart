import 'package:dartz/dartz.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../request/model/update_settings_response_model.dart';
import '../request/param/update_privacy_settings_param.dart';
import '../request/param/update_notification_settings_param.dart';
import '../request/param/update_general_settings_param.dart';

abstract class ISettingsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, UpdateSettingsResponseModel>> updatePrivacySettings(
    UpdatePrivacySettingsParam param,
  );

  Future<Either<AppErrors, UpdateSettingsResponseModel>>
      updateNotificationSettings(
    UpdateNotificationSettingsParam param,
  );

  Future<Either<AppErrors, UpdateSettingsResponseModel>> updateGeneralSettings(
    UpdateGeneralSettingsParam param,
  );
}
