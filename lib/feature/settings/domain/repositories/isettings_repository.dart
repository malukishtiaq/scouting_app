import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../entities/update_settings_response_entity.dart';
import '../entities/user_preferences_entity.dart';
import '../../data/request/param/update_privacy_settings_param.dart';
import '../../data/request/param/update_notification_settings_param.dart';
import '../../data/request/param/update_general_settings_param.dart';

abstract class ISettingsRepository {
  /// Get user preferences (for existing use cases)
  Future<UserPreferencesEntity> getUserPreferences();

  /// Save user preferences (for existing use cases)
  Future<void> saveUserPreferences(UserPreferencesEntity preferences);

  Future<Result<AppErrors, UpdateSettingsResponseEntity>> updatePrivacySettings(
    UpdatePrivacySettingsParam param,
  );

  Future<Result<AppErrors, UpdateSettingsResponseEntity>>
      updateNotificationSettings(
    UpdateNotificationSettingsParam param,
  );

  Future<Result<AppErrors, UpdateSettingsResponseEntity>> updateGeneralSettings(
    UpdateGeneralSettingsParam param,
  );
}
