import '../entities/update_settings_response_entity.dart';
import '../repositories/isettings_repository.dart';
import '../../data/request/param/update_notification_settings_param.dart';

/// Use case for updating notification settings
class UpdateNotificationSettingsUseCase {
  final ISettingsRepository _repository;

  const UpdateNotificationSettingsUseCase(this._repository);

  /// Execute the use case
  Future<void> call(UpdateNotificationSettingsParam param) async {
    final result = await _repository.updateNotificationSettings(param);
    // Handle the result if needed
    result.pick(
      onData: (response) {
        print('Notification settings updated successfully');
      },
      onError: (error) {
        print('Error updating notification settings: ${error.message}');
        throw Exception(
            'Failed to update notification settings: ${error.message}');
      },
    );
  }
}
