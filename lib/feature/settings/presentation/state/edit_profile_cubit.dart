import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile_entity.dart';

/// States for Edit Profile feature
abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

class EditProfileLoaded extends EditProfileState {
  final UserProfileEntity profile;

  const EditProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileSaving extends EditProfileState {
  const EditProfileSaving();
}

class EditProfileSaved extends EditProfileState {
  final UserProfileEntity profile;

  const EditProfileSaved({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileError extends EditProfileState {
  final String message;

  const EditProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Cubit for managing Edit Profile state
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileInitial());

  /// Load user profile
  void loadProfile() {
    emit(const EditProfileLoading());

    // TODO: Implement actual profile loading from repository
    // For now, emit a mock profile
    try {
      // This would typically call a repository method
      // final profile = await _profileRepository.getCurrentUserProfile();

      // Mock profile for now
      final mockProfile = UserProfileEntity(
        id: 'current_user',
        username: 'current_user',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        about: 'This is a sample about text',
        isVerified: false,
      );

      emit(EditProfileLoaded(profile: mockProfile));
    } catch (e) {
      emit(EditProfileError(message: 'Failed to load profile: $e'));
    }
  }

  /// Save user profile
  void saveProfile(UserProfileEntity profile) {
    emit(const EditProfileSaving());

    // TODO: Implement actual profile saving to repository
    try {
      // This would typically call a repository method
      // await _profileRepository.updateProfile(profile);

      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        emit(EditProfileSaved(profile: profile));
      });
    } catch (e) {
      emit(EditProfileError(message: 'Failed to save profile: $e'));
    }
  }

  /// Update profile field
  void updateField(String field, String value) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      final updatedProfile = currentState.profile.copyWith(
          // This would need to be implemented based on the field
          // For now, we'll just emit the current profile
          );
      emit(EditProfileLoaded(profile: updatedProfile));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const EditProfileInitial());
  }
}
