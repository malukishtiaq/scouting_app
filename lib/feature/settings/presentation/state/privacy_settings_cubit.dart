import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../data/services/privacy_preferences_service.dart';

/// State for privacy settings
abstract class PrivacySettingsState {
  const PrivacySettingsState();
}

/// Initial state
class PrivacySettingsInitial extends PrivacySettingsState {
  const PrivacySettingsInitial();
}

/// Loading state
class PrivacySettingsLoading extends PrivacySettingsState {
  const PrivacySettingsLoading();
}

/// Loaded state
class PrivacySettingsLoaded extends PrivacySettingsState {
  final UserPreferencesEntity preferences;
  final Map<String, dynamic> summary;

  const PrivacySettingsLoaded({
    required this.preferences,
    required this.summary,
  });
}

/// Saving state
class PrivacySettingsSaving extends PrivacySettingsState {
  const PrivacySettingsSaving();
}

/// Saved state
class PrivacySettingsSaved extends PrivacySettingsState {
  const PrivacySettingsSaved();
}

/// Error state
class PrivacySettingsError extends PrivacySettingsState {
  final String message;

  const PrivacySettingsError(this.message);
}

/// Cubit for managing privacy settings state
class PrivacySettingsCubit extends Cubit<PrivacySettingsState> {
  final PrivacyPreferencesService _privacyService;

  PrivacySettingsCubit({
    required PrivacyPreferencesService privacyService,
  })  : _privacyService = privacyService,
        super(const PrivacySettingsInitial());

  /// Load privacy preferences
  Future<void> loadPrivacyPreferences() async {
    try {
      emit(const PrivacySettingsLoading());

      final preferences = await _privacyService.loadPrivacyPreferences();
      final summary = await _privacyService.getPrivacySummary();

      emit(PrivacySettingsLoaded(
        preferences: preferences,
        summary: summary,
      ));
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Save privacy preferences
  Future<void> savePrivacyPreferences(UserPreferencesEntity preferences) async {
    try {
      emit(const PrivacySettingsSaving());

      await _privacyService.savePrivacyPreferences(preferences);

      emit(const PrivacySettingsSaved());

      // Reload to get updated summary
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Update specific privacy preference
  void updatePrivacyPreference(UserPreferencesEntity updatedPreferences) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      emit(PrivacySettingsLoaded(
        preferences: updatedPreferences,
        summary: currentState.summary,
      ));
    }
  }

  /// Reset privacy preferences to defaults
  Future<void> resetToDefaults() async {
    try {
      emit(const PrivacySettingsLoading());

      await _privacyService.resetToDefaults();

      // Reload default preferences
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Export privacy preferences
  Future<String?> exportPreferences() async {
    try {
      if (state is PrivacySettingsLoaded) {
        final currentState = state as PrivacySettingsLoaded;
        return await _privacyService
            .exportPreferences(currentState.preferences);
      }
      return null;
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
      return null;
    }
  }

  /// Import privacy preferences
  Future<void> importPreferences(String data) async {
    try {
      emit(const PrivacySettingsLoading());

      final preferences = await _privacyService.importPreferences(data);

      // Save imported preferences
      await _privacyService.savePrivacyPreferences(preferences);

      // Reload to get updated data
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Toggle profile visibility
  void toggleProfileVisibility(String visibility) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        profileVisibility: visibility,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle online status visibility
  void toggleOnlineStatusVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showOnlineStatus: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle messages from strangers
  void toggleMessagesFromStrangers(bool allow) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        allowMessagesFromStrangers: allow,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle birthday visibility
  void toggleBirthdayVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showBirthday: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle location visibility
  void toggleLocationVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showLocation: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle email visibility
  void toggleEmailVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showEmail: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle phone number visibility
  void togglePhoneNumberVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showPhoneNumber: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle tagging permission
  void toggleTaggingPermission(bool allow) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        allowTagging: allow,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle tag approval requirement
  void toggleTagApprovalRequirement(bool require) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        requireApprovalForTags: require,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle friends list visibility
  void toggleFriendsListVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showFriendsList: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle followers list visibility
  void toggleFollowersListVisibility(bool visible) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        showFollowersList: visible,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle auto-accept friend requests
  void toggleAutoAcceptFriendRequests(bool autoAccept) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        autoAcceptFriendRequests: autoAccept,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle sharing permission
  void toggleSharingPermission(bool allow) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        allowSharing: allow,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Toggle downloads permission
  void toggleDownloadsPermission(bool allow) {
    if (state is PrivacySettingsLoaded) {
      final currentState = state as PrivacySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        allowDownloads: allow,
      );
      updatePrivacyPreference(updated);
    }
  }

  /// Add blocked user
  Future<void> addBlockedUser(String user) async {
    try {
      await _privacyService.addBlockedUser(user);
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Remove blocked user
  Future<void> removeBlockedUser(String user) async {
    try {
      await _privacyService.removeBlockedUser(user);
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Add muted user
  Future<void> addMutedUser(String user) async {
    try {
      await _privacyService.addMutedUser(user);
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }

  /// Remove muted user
  Future<void> removeMutedUser(String user) async {
    try {
      await _privacyService.removeMutedUser(user);
      await loadPrivacyPreferences();
    } catch (e) {
      emit(PrivacySettingsError(e.toString()));
    }
  }
}
