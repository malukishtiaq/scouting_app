import '../entities/user_preferences_entity.dart';
import '../repositories/isettings_repository.dart';

/// Use case for saving user preferences
class SaveUserPreferencesUseCase {
  final ISettingsRepository _repository;

  const SaveUserPreferencesUseCase(this._repository);

  /// Execute the use case
  Future<void> call(UserPreferencesEntity preferences) async {
    await _repository.saveUserPreferences(preferences);
  }
}
