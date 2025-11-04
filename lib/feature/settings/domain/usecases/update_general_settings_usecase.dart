import '../entities/update_settings_response_entity.dart';
import '../repositories/isettings_repository.dart';
import '../../data/request/param/update_general_settings_param.dart';

/// Use case for updating general settings
class UpdateGeneralSettingsUseCase {
  final ISettingsRepository _repository;

  const UpdateGeneralSettingsUseCase(this._repository);

  /// Execute the use case
  Future<void> call(UpdateGeneralSettingsParam param) async {
    final result = await _repository.updateGeneralSettings(param);
    // Handle the result if needed
    result.pick(
      onData: (response) {
        print('General settings updated successfully');
      },
      onError: (error) {
        print('Error updating general settings: ${error.message}');
        throw Exception('Failed to update general settings: ${error.message}');
      },
    );
  }
}
