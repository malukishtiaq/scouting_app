import '../entities/user_preferences_entity.dart';
import '../repositories/isettings_repository.dart';

/// Use case for getting user preferences
class GetUserPreferencesUseCase {
  final ISettingsRepository _repository;

  const GetUserPreferencesUseCase(this._repository);

  /// Execute the use case
  Future<UserPreferencesEntity> call() async {
    return await _repository.getUserPreferences();
  }
}
