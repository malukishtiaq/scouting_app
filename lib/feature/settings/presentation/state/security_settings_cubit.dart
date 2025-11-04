import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../data/services/security_preferences_service.dart';

/// State for security settings
abstract class SecuritySettingsState {
  const SecuritySettingsState();
}

/// Initial state
class SecuritySettingsInitial extends SecuritySettingsState {
  const SecuritySettingsInitial();
}

/// Loading state
class SecuritySettingsLoading extends SecuritySettingsState {
  const SecuritySettingsLoading();
}

/// Loaded state
class SecuritySettingsLoaded extends SecuritySettingsState {
  final UserPreferencesEntity preferences;
  final Map<String, dynamic> summary;

  const SecuritySettingsLoaded({
    required this.preferences,
    required this.summary,
  });
}

/// Saving state
class SecuritySettingsSaving extends SecuritySettingsState {
  const SecuritySettingsSaving();
}

/// Saved state
class SecuritySettingsSaved extends SecuritySettingsState {
  const SecuritySettingsSaved();
}

/// Error state
class SecuritySettingsError extends SecuritySettingsState {
  final String message;

  const SecuritySettingsError(this.message);
}

/// Password changing state
class SecurityPasswordChanging extends SecuritySettingsState {
  const SecurityPasswordChanging();
}

/// Password changed state
class SecurityPasswordChanged extends SecuritySettingsState {
  const SecurityPasswordChanged();
}

/// Two-factor auth toggling state
class SecurityTwoFactorToggling extends SecuritySettingsState {
  const SecurityTwoFactorToggling();
}

/// Two-factor auth toggled state
class SecurityTwoFactorToggled extends SecuritySettingsState {
  final bool enabled;

  const SecurityTwoFactorToggled(this.enabled);
}

/// Cubit for managing security settings state
class SecuritySettingsCubit extends Cubit<SecuritySettingsState> {
  final SecurityPreferencesService _securityService;

  SecuritySettingsCubit({
    required SecurityPreferencesService securityService,
  })  : _securityService = securityService,
        super(const SecuritySettingsInitial());

  /// Load security preferences
  Future<void> loadSecurityPreferences() async {
    try {
      emit(const SecuritySettingsLoading());

      final preferences = await _securityService.loadSecurityPreferences();
      final summary = await _securityService.getSecuritySummary();

      emit(SecuritySettingsLoaded(
        preferences: preferences,
        summary: summary,
      ));
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Save security preferences
  Future<void> saveSecurityPreferences(
      UserPreferencesEntity preferences) async {
    try {
      emit(const SecuritySettingsSaving());

      await _securityService.saveSecurityPreferences(preferences);

      emit(const SecuritySettingsSaved());

      // Reload to get updated summary
      await loadSecurityPreferences();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Update specific security preference
  void updateSecurityPreference(UserPreferencesEntity updatedPreferences) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      emit(SecuritySettingsLoaded(
        preferences: updatedPreferences,
        summary: currentState.summary,
      ));
    }
  }

  /// Change password
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      emit(const SecurityPasswordChanging());

      final success =
          await _securityService.changePassword(currentPassword, newPassword);

      if (success) {
        emit(const SecurityPasswordChanged());
        // Reload preferences
        await loadSecurityPreferences();
      } else {
        emit(const SecuritySettingsError(
            'Password change failed. Please check your current password.'));
      }
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Toggle two-factor authentication
  Future<void> toggleTwoFactorAuth(bool enable,
      {String? verificationCode}) async {
    try {
      emit(const SecurityTwoFactorToggling());

      final success =
          await _securityService.toggleTwoFactorAuth(enable, verificationCode);

      if (success) {
        emit(SecurityTwoFactorToggled(enable));

        // Update preferences
        if (state is SecuritySettingsLoaded) {
          final currentState = state as SecuritySettingsLoaded;
          final updated = currentState.preferences.copyWith(
            twoFactorAuthEnabled: enable,
          );
          updateSecurityPreference(updated);
        }

        // Reload to get updated summary
        await loadSecurityPreferences();
      } else {
        emit(const SecuritySettingsError(
            'Two-factor authentication setup failed. Please check the verification code.'));
      }
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Generate backup codes
  Future<List<String>?> generateBackupCodes() async {
    try {
      final codes = await _securityService.generateBackupCodes();

      // Update preferences with backup codes
      if (state is SecuritySettingsLoaded) {
        final currentState = state as SecuritySettingsLoaded;
        final updated = currentState.preferences.copyWith(
          backupCodesGenerated: codes.join(','),
        );
        updateSecurityPreference(updated);
        await saveSecurityPreferences(updated);
      }

      return codes;
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
      return null;
    }
  }

  /// Toggle theme
  void toggleTheme(String theme) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(theme: theme);
      updateSecurityPreference(updated);
    }
  }

  /// Update language
  void updateLanguage(String language) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(language: language);
      updateSecurityPreference(updated);
    }
  }

  /// Update font size
  void updateFontSize(double fontSize) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(fontSize: fontSize);
      updateSecurityPreference(updated);
    }
  }

  /// Update time format
  void updateTimeFormat(String timeFormat) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(timeFormat: timeFormat);
      updateSecurityPreference(updated);
    }
  }

  /// Update date format
  void updateDateFormat(String dateFormat) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(dateFormat: dateFormat);
      updateSecurityPreference(updated);
    }
  }

  /// Update primary color
  void updatePrimaryColor(String color) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(primaryColor: color);
      updateSecurityPreference(updated);
    }
  }

  /// Update accent color
  void updateAccentColor(String color) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(accentColor: color);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle animations
  void toggleAnimations(bool enable) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(enableAnimations: enable);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle haptic feedback
  void toggleHapticFeedback(bool enable) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(enableHapticFeedback: enable);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle compact mode
  void toggleCompactMode(bool enable) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(compactMode: enable);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle password requirement for sensitive actions
  void togglePasswordRequirement(bool require) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated = currentState.preferences.copyWith(
        requirePasswordForSensitiveActions: require,
      );
      updateSecurityPreference(updated);
    }
  }

  /// Update session timeout
  void updateSessionTimeout(int minutes) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(sessionTimeoutMinutes: minutes);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle logout on device change
  void toggleLogoutOnDeviceChange(bool enable) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(logOutOnDeviceChange: enable);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle new device login notifications
  void toggleNewDeviceNotifications(bool enable) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(notifyOnNewDeviceLogin: enable);
      updateSecurityPreference(updated);
    }
  }

  /// Toggle allow remember device
  void toggleAllowRememberDevice(bool allow) {
    if (state is SecuritySettingsLoaded) {
      final currentState = state as SecuritySettingsLoaded;
      final updated =
          currentState.preferences.copyWith(allowRememberDevice: allow);
      updateSecurityPreference(updated);
    }
  }

  /// Get trusted devices
  Future<List<Map<String, dynamic>>?> getTrustedDevices() async {
    try {
      return await _securityService.getTrustedDevices();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
      return null;
    }
  }

  /// Remove trusted device
  Future<void> removeTrustedDevice(String deviceId) async {
    try {
      await _securityService.removeTrustedDevice(deviceId);
      // Reload preferences to update trusted devices list
      await loadSecurityPreferences();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Get login activity
  Future<List<Map<String, dynamic>>?> getLoginActivity() async {
    try {
      return await _securityService.getLoginActivity();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
      return null;
    }
  }

  /// Get active sessions
  Future<List<Map<String, dynamic>>?> getActiveSessions() async {
    try {
      return await _securityService.getActiveSessions();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
      return null;
    }
  }

  /// End session
  Future<void> endSession(String sessionId) async {
    try {
      await _securityService.endSession(sessionId);
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// End all other sessions
  Future<void> endAllOtherSessions() async {
    try {
      await _securityService.endAllOtherSessions();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Request data download
  Future<void> requestDataDownload() async {
    try {
      await _securityService.requestDataDownload();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    try {
      emit(const SecuritySettingsLoading());

      await _securityService.resetToDefaults();

      // Reload default preferences
      await loadSecurityPreferences();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }

  /// Export preferences
  Future<String?> exportPreferences() async {
    try {
      if (state is SecuritySettingsLoaded) {
        final currentState = state as SecuritySettingsLoaded;
        return await _securityService
            .exportPreferences(currentState.preferences);
      }
      return null;
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
      return null;
    }
  }

  /// Import preferences
  Future<void> importPreferences(String data) async {
    try {
      emit(const SecuritySettingsLoading());

      final preferences = await _securityService.importPreferences(data);

      // Save imported preferences
      await _securityService.saveSecurityPreferences(preferences);

      // Reload to get updated data
      await loadSecurityPreferences();
    } catch (e) {
      emit(SecuritySettingsError(e.toString()));
    }
  }
}
