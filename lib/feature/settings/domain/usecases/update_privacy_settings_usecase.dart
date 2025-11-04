import '../entities/update_settings_response_entity.dart';
import '../repositories/isettings_repository.dart';
import '../../data/request/param/update_privacy_settings_param.dart';

/// Use case for updating privacy settings
class UpdatePrivacySettingsUseCase {
  final ISettingsRepository _repository;

  const UpdatePrivacySettingsUseCase(this._repository);

  /// Execute the use case
  Future<void> call(UpdatePrivacySettingsParam param) async {
    final result = await _repository.updatePrivacySettings(param);
    // Handle the result if needed
    result.pick(
      onData: (response) {
        print('Privacy settings updated successfully');
      },
      onError: (error) {
        print('Error updating privacy settings: ${error.message}');
        throw Exception('Failed to update privacy settings: ${error.message}');
      },
    );
  }
}
