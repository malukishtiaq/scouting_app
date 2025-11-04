import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/usecases/get_user_preferences_usecase.dart';
import '../../domain/usecases/save_user_preferences_usecase.dart';
import '../../domain/usecases/update_privacy_settings_usecase.dart';
import '../../domain/usecases/update_notification_settings_usecase.dart';
import '../../domain/usecases/update_general_settings_usecase.dart';
import '../../data/request/param/update_privacy_settings_param.dart';
import '../../data/request/param/update_notification_settings_param.dart';
import '../../data/request/param/update_general_settings_param.dart';

/// State for settings
abstract class SettingsState {
  const SettingsState();
}

/// Initial state
class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

/// Loading state
class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

/// Loaded state
class SettingsLoaded extends SettingsState {
  final UserPreferencesEntity preferences;

  const SettingsLoaded(this.preferences);
}

/// Error state
class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);
}

/// Saving state
class SettingsSaving extends SettingsState {
  const SettingsSaving();
}

/// Saved state
class SettingsSaved extends SettingsState {
  const SettingsSaved();
}

/// Cubit for managing settings state
class SettingsCubit extends Cubit<SettingsState> {
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;
  final SaveUserPreferencesUseCase _saveUserPreferencesUseCase;
  final UpdatePrivacySettingsUseCase _updatePrivacySettingsUseCase;
  final UpdateNotificationSettingsUseCase _updateNotificationSettingsUseCase;
  final UpdateGeneralSettingsUseCase _updateGeneralSettingsUseCase;

  SettingsCubit({
    required GetUserPreferencesUseCase getUserPreferencesUseCase,
    required SaveUserPreferencesUseCase saveUserPreferencesUseCase,
    required UpdatePrivacySettingsUseCase updatePrivacySettingsUseCase,
    required UpdateNotificationSettingsUseCase
        updateNotificationSettingsUseCase,
    required UpdateGeneralSettingsUseCase updateGeneralSettingsUseCase,
  })  : _getUserPreferencesUseCase = getUserPreferencesUseCase,
        _saveUserPreferencesUseCase = saveUserPreferencesUseCase,
        _updatePrivacySettingsUseCase = updatePrivacySettingsUseCase,
        _updateNotificationSettingsUseCase = updateNotificationSettingsUseCase,
        _updateGeneralSettingsUseCase = updateGeneralSettingsUseCase,
        super(const SettingsInitial());

  /// Load user preferences
  Future<void> loadPreferences() async {
    if (isClosed) return; // ✅ Prevent emitting after close

    try {
      emit(const SettingsLoading());
      print('SettingsCubit: Loading preferences...');
      final preferences = await _getUserPreferencesUseCase();

      if (isClosed) return; // ✅ Check again after async operation

      print(
          'SettingsCubit: Preferences loaded successfully: ${preferences.enablePushNotifications}');
      emit(SettingsLoaded(preferences));
    } catch (e) {
      if (isClosed) return; // ✅ Check before emitting error

      print('SettingsCubit: Error loading preferences: $e');
      emit(SettingsError(e.toString()));
    }
  }

  /// Save user preferences
  Future<void> savePreferences(UserPreferencesEntity preferences) async {
    if (isClosed) return; // ✅ Prevent emitting after close

    try {
      emit(const SettingsSaving());
      await _saveUserPreferencesUseCase(preferences);

      if (isClosed) return; // ✅ Check again after async operation

      emit(const SettingsSaved());
      emit(SettingsLoaded(preferences));
    } catch (e) {
      if (isClosed) return; // ✅ Check before emitting error

      emit(SettingsError(e.toString()));
    }
  }

  /// Update specific preference
  void updatePreference(UserPreferencesEntity updatedPreferences) {
    if (state is SettingsLoaded) {
      emit(SettingsLoaded(updatedPreferences));
    }
  }

  /// Update privacy settings via API
  Future<void> updatePrivacySettings({
    String? followPrivacy,
    String? messagePrivacy,
    String? friendPrivacy,
    String? postPrivacy,
    String? birthdayPrivacy,
    String? confirmFollowRequests,
    String? showMyActivities,
    String? onlineUser,
    String? shareMyLocation,
  }) async {
    if (isClosed) return; // ✅ Prevent emitting after close

    try {
      emit(const SettingsSaving());

      final param = UpdatePrivacySettingsParam(
        followPrivacy: followPrivacy,
        messagePrivacy: messagePrivacy,
        friendPrivacy: friendPrivacy,
        postPrivacy: postPrivacy,
        birthdayPrivacy: birthdayPrivacy,
        confirmFollowRequests: confirmFollowRequests,
        showMyActivities: showMyActivities,
        onlineUser: onlineUser,
        shareMyLocation: shareMyLocation,
      );

      await _updatePrivacySettingsUseCase(param);

      if (isClosed) return; // ✅ Check again after async operation

      emit(const SettingsSaved());
      // Reload preferences to get updated data
      loadPreferences();
    } catch (e) {
      if (isClosed) return; // ✅ Check before emitting error

      emit(SettingsError('Error updating privacy settings: $e'));
    }
  }

  /// Update notification settings via API
  Future<void> updateNotificationSettings({
    String? eLiked,
    String? eCommented,
    String? eShared,
    String? eFollowed,
    String? eLikedPage,
    String? eVisited,
    String? eMentioned,
    String? eJoinedGroup,
    String? eAccepted,
    String? eProfileWallPost,
    String? eMemory,
    String? notifications,
    String? soundControl,
  }) async {
    if (isClosed) return; // ✅ Prevent emitting after close

    try {
      emit(const SettingsSaving());

      final param = UpdateNotificationSettingsParam(
        eLiked: eLiked,
        eCommented: eCommented,
        eShared: eShared,
        eFollowed: eFollowed,
        eLikedPage: eLikedPage,
        eVisited: eVisited,
        eMentioned: eMentioned,
        eJoinedGroup: eJoinedGroup,
        eAccepted: eAccepted,
        eProfileWallPost: eProfileWallPost,
        eMemory: eMemory,
        notifications: notifications,
        soundControl: soundControl,
      );

      await _updateNotificationSettingsUseCase(param);

      if (isClosed) return; // ✅ Check again after async operation

      emit(const SettingsSaved());
      // Reload preferences to get updated data
      loadPreferences();
    } catch (e) {
      if (isClosed) return; // ✅ Check before emitting error

      emit(SettingsError('Error updating notification settings: $e'));
    }
  }

  /// Update general settings via API
  Future<void> updateGeneralSettings({
    String? nightMode,
    String? language,
    String? storageConnectedMobile,
    String? storageConnectedWiFi,
    String? twoFactor,
    String? chatHeads,
  }) async {
    if (isClosed) return; // ✅ Prevent emitting after close

    try {
      emit(const SettingsSaving());

      final param = UpdateGeneralSettingsParam(
        nightMode: nightMode,
        language: language,
        storageConnectedMobile: storageConnectedMobile,
        storageConnectedWiFi: storageConnectedWiFi,
        twoFactor: twoFactor,
        chatHeads: chatHeads,
      );

      await _updateGeneralSettingsUseCase(param);

      if (isClosed) return; // ✅ Check again after async operation

      emit(const SettingsSaved());
      // Reload preferences to get updated data
      loadPreferences();
    } catch (e) {
      if (isClosed) return; // ✅ Check before emitting error

      emit(SettingsError('Error updating general settings: $e'));
    }
  }
}
