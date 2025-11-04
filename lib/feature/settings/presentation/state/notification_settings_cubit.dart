import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../data/services/notification_preferences_service.dart';

/// State for notification settings
abstract class NotificationSettingsState {
  const NotificationSettingsState();
}

/// Initial state
class NotificationSettingsInitial extends NotificationSettingsState {
  const NotificationSettingsInitial();
}

/// Loading state
class NotificationSettingsLoading extends NotificationSettingsState {
  const NotificationSettingsLoading();
}

/// Loaded state
class NotificationSettingsLoaded extends NotificationSettingsState {
  final UserPreferencesEntity preferences;
  final Map<String, dynamic> summary;
  
  const NotificationSettingsLoaded({
    required this.preferences,
    required this.summary,
  });
}

/// Saving state
class NotificationSettingsSaving extends NotificationSettingsState {
  const NotificationSettingsSaving();
}

/// Saved state
class NotificationSettingsSaved extends NotificationSettingsState {
  const NotificationSettingsSaved();
}

/// Error state
class NotificationSettingsError extends NotificationSettingsState {
  final String message;
  
  const NotificationSettingsError(this.message);
}

/// Cubit for managing notification settings state
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationPreferencesService _notificationService;
  
  NotificationSettingsCubit({
    required NotificationPreferencesService notificationService,
  })  : _notificationService = notificationService,
        super(const NotificationSettingsInitial());

  /// Load notification preferences
  Future<void> loadNotificationPreferences() async {
    try {
      emit(const NotificationSettingsLoading());
      
      final preferences = await _notificationService.loadNotificationPreferences();
      final summary = await _notificationService.getNotificationSummary();
      
      emit(NotificationSettingsLoaded(
        preferences: preferences,
        summary: summary,
      ));
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
    }
  }

  /// Save notification preferences
  Future<void> saveNotificationPreferences(UserPreferencesEntity preferences) async {
    try {
      emit(const NotificationSettingsSaving());
      
      await _notificationService.saveNotificationPreferences(preferences);
      
      emit(const NotificationSettingsSaved());
      
      // Reload to get updated summary
      await loadNotificationPreferences();
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
    }
  }

  /// Update specific notification preference
  void updateNotificationPreference(UserPreferencesEntity updatedPreferences) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      emit(NotificationSettingsLoaded(
        preferences: updatedPreferences,
        summary: currentState.summary,
      ));
    }
  }

  /// Reset notification preferences to defaults
  Future<void> resetToDefaults() async {
    try {
      emit(const NotificationSettingsLoading());
      
      await _notificationService.resetToDefaults();
      
      // Reload default preferences
      await loadNotificationPreferences();
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
    }
  }

  /// Export notification preferences
  Future<String?> exportPreferences() async {
    try {
      if (state is NotificationSettingsLoaded) {
        final currentState = state as NotificationSettingsLoaded;
        return await _notificationService.exportPreferences(currentState.preferences);
      }
      return null;
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
      return null;
    }
  }

  /// Import notification preferences
  Future<void> importPreferences(String data) async {
    try {
      emit(const NotificationSettingsLoading());
      
      final preferences = await _notificationService.importPreferences(data);
      
      // Save imported preferences
      await _notificationService.saveNotificationPreferences(preferences);
      
      // Reload to get updated data
      await loadNotificationPreferences();
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
    }
  }

  /// Toggle specific notification type
  void toggleNotificationType(String type, bool value) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      UserPreferencesEntity updatedPreferences;
      
      switch (type) {
        case 'pushNotifications':
          updatedPreferences = currentState.preferences.copyWith(
            enablePushNotifications: value,
          );
          break;
        case 'emailNotifications':
          updatedPreferences = currentState.preferences.copyWith(
            enableEmailNotifications: value,
          );
          break;
        case 'inAppNotifications':
          updatedPreferences = currentState.preferences.copyWith(
            enableInAppNotifications: value,
          );
          break;
        case 'newMessages':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnNewMessages: value,
          );
          break;
        case 'friendRequests':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnFriendRequests: value,
          );
          break;
        case 'likes':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnLikes: value,
          );
          break;
        case 'comments':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnComments: value,
          );
          break;
        case 'mentions':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnMentions: value,
          );
          break;
        case 'follows':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnFollows: value,
          );
          break;
        case 'groupPosts':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnGroupPosts: value,
          );
          break;
        case 'events':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnEvents: value,
          );
          break;
        case 'birthdays':
          updatedPreferences = currentState.preferences.copyWith(
            notifyOnBirthdays: value,
          );
          break;
        case 'vibration':
          updatedPreferences = currentState.preferences.copyWith(
            vibrationEnabled: value,
          );
          break;
        case 'ledLight':
          updatedPreferences = currentState.preferences.copyWith(
            ledColorEnabled: value,
          );
          break;
        default:
          return;
      }
      
      updateNotificationPreference(updatedPreferences);
    }
  }

  /// Update quiet hours
  void updateQuietHours(bool enabled, String startTime, String endTime) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      final updatedPreferences = currentState.preferences.copyWith(
        quietHoursEnabled: enabled,
        quietHoursStart: startTime,
        quietHoursEnd: endTime,
      );
      
      updateNotificationPreference(updatedPreferences);
    }
  }

  /// Update notification sound
  void updateNotificationSound(String sound) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      final updatedPreferences = currentState.preferences.copyWith(
        notificationSound: sound,
      );
      
      updateNotificationPreference(updatedPreferences);
    }
  }

  /// Update custom ringtone
  void updateCustomRingtone(String ringtone) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      final updatedPreferences = currentState.preferences.copyWith(
        customRingtone: ringtone,
      );
      
      updateNotificationPreference(updatedPreferences);
    }
  }

  /// Add muted keyword
  void addMutedKeyword(String keyword) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      final updatedKeywords = List<String>.from(currentState.preferences.mutedKeywords)
        ..add(keyword);
      
      final updatedPreferences = currentState.preferences.copyWith(
        mutedKeywords: updatedKeywords,
      );
      
      updateNotificationPreference(updatedPreferences);
    }
  }

  /// Remove muted keyword
  void removeMutedKeyword(String keyword) {
    if (state is NotificationSettingsLoaded) {
      final currentState = state as NotificationSettingsLoaded;
      final updatedKeywords = List<String>.from(currentState.preferences.mutedKeywords)
        ..remove(keyword);
      
      final updatedPreferences = currentState.preferences.copyWith(
        mutedKeywords: updatedKeywords,
      );
      
      updateNotificationPreference(updatedPreferences);
    }
  }
}
