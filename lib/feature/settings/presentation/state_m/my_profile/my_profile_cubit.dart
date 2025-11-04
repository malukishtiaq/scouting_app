import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../profile/domain/usecases/get_user_profile_usecase.dart';
import '../../../../profile/domain/usecases/update_avatar_usecase.dart';
import '../../../../profile/domain/usecases/update_cover_usecase.dart';
import '../../../../profile/data/request/param/user_profile_param.dart';
import '../../../../profile/data/request/param/update_avatar_param.dart';
import '../../../../profile/data/request/param/update_cover_param.dart';
import '../../../../profile/domain/entities/user_profile_entity.dart';
import 'my_profile_state.dart';

@injectable
class MyProfileCubit extends Cubit<MyProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final UpdateCoverUseCase _updateCoverUseCase;
  final AuthService _authService;

  bool _isLoading = false;

  MyProfileCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateAvatarUseCase updateAvatarUseCase,
    required UpdateCoverUseCase updateCoverUseCase,
    required AuthService authService,
  })  : _getUserProfileUseCase = getUserProfileUseCase,
        _updateAvatarUseCase = updateAvatarUseCase,
        _updateCoverUseCase = updateCoverUseCase,
        _authService = authService,
        super(const MyProfileState.initial());

  Future<void> loadMyProfile({bool refresh = false}) async {
    if (isClosed) return;

    // Prevent duplicate calls
    if (_isLoading && !refresh) {
      print('⚠️ MyProfileCubit: Already loading, skipping duplicate call');
      return;
    }

    _isLoading = true;

    // Get current user ID
    final userId = _authService.currentUserId?.toString();
    if (userId == null || userId.isEmpty) {
      emit(MyProfileState.error(
        message: 'User not logged in',
        profile: null,
      ));
      _isLoading = false;
      return;
    }

    emit(const MyProfileState.loading());

    try {
      final param = GetUserProfileParam(
        userId: userId,
        fetch: 'user_data,following', // Match Xamarin: "user_data,following"
      );

      final result = await _getUserProfileUseCase(param);

      if (isClosed) {
        _isLoading = false;
        return;
      }

      result.pick(
        onData: (response) {
          emit(MyProfileState.loaded(
            profile: response.userData,
            following: response.following,
            hasReachedMax: false,
          ));
          _isLoading = false;
        },
        onError: (error) {
          emit(MyProfileState.error(
            message: error.message ?? 'Failed to load profile',
            profile: null,
          ));
          _isLoading = false;
        },
      );
    } catch (e) {
      if (isClosed) {
        _isLoading = false;
        return;
      }

      emit(MyProfileState.error(
        message: 'An error occurred: ${e.toString()}',
        profile: null,
      ));
      _isLoading = false;
    }
  }

  Future<void> refreshProfile() async {
    await loadMyProfile(refresh: true);
  }

  // Implement avatar update functionality
  Future<void> updateAvatar(String filePath) async {
    if (isClosed) return;

    // Get current profile from state
    final currentState = state;
    UserProfileEntity? currentProfile;
    currentState.whenOrNull(
      loaded: (profile, following, hasReachedMax) => currentProfile = profile,
    );

    if (currentProfile == null) {
      emit(MyProfileState.error(
        message: 'Profile not loaded',
        profile: null,
      ));
      return;
    }

    emit(MyProfileState.imageUpdating(
      profile: currentProfile!,
      imageType: 'avatar',
    ));

    try {
      final param = UpdateAvatarParam(avatarPath: filePath);
      final result = await _updateAvatarUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (_) {
          // Don't reload entire profile, just update the avatar in current state
          final currentState = state;
          currentState.whenOrNull(
            loaded: (profile, following, hasReachedMax) {
              // Create updated profile with new avatar
              final updatedProfile = UserProfileEntity(
                userId: profile.userId,
                username: profile.username,
                email: profile.email,
                firstName: profile.firstName,
                lastName: profile.lastName,
                avatar: filePath, // Use local path temporarily
                cover: profile.cover,
                about: profile.about,
                gender: profile.gender,
                birthday: profile.birthday,
                countryId: profile.countryId,
                website: profile.website,
                facebook: profile.facebook,
                google: profile.google,
                twitter: profile.twitter,
                instagram: profile.instagram,
                youtube: profile.youtube,
                vk: profile.vk,
                lastSeenUnixTime: profile.lastSeenUnixTime,
                lastSeenStatus: profile.lastSeenStatus,
                isFollowing: profile.isFollowing,
                canFollow: profile.canFollow,
                isFollowingMe: profile.isFollowingMe,
                isBlocked: profile.isBlocked,
                isReported: profile.isReported,
                points: profile.points,
                proType: profile.proType,
                verified: profile.verified,
                details: profile.details,
              );

              emit(MyProfileState.loaded(
                profile: updatedProfile,
                following: following,
                hasReachedMax: hasReachedMax,
              ));
            },
          );
        },
        onError: (error) {
          emit(MyProfileState.error(
            message: error.message ?? 'Failed to update avatar',
            profile: currentProfile,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;

      emit(MyProfileState.error(
        message: 'An error occurred: ${e.toString()}',
        profile: currentProfile,
      ));
    }
  }

  // Implement cover update functionality
  Future<void> updateCover(String filePath) async {
    if (isClosed) return;

    // Get current profile from state
    final currentState = state;
    UserProfileEntity? currentProfile;
    currentState.whenOrNull(
      loaded: (profile, following, hasReachedMax) => currentProfile = profile,
    );

    if (currentProfile == null) {
      emit(MyProfileState.error(
        message: 'Profile not loaded',
        profile: null,
      ));
      return;
    }

    emit(MyProfileState.imageUpdating(
      profile: currentProfile!,
      imageType: 'cover',
    ));

    try {
      final param = UpdateCoverParam(coverPath: filePath);
      final result = await _updateCoverUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (_) {
          // Don't reload entire profile, just update the cover in current state
          final currentState = state;
          currentState.whenOrNull(
            loaded: (profile, following, hasReachedMax) {
              // Create updated profile with new cover
              final updatedProfile = UserProfileEntity(
                userId: profile.userId,
                username: profile.username,
                email: profile.email,
                firstName: profile.firstName,
                lastName: profile.lastName,
                avatar: profile.avatar,
                cover: filePath, // Use local path temporarily
                about: profile.about,
                gender: profile.gender,
                birthday: profile.birthday,
                countryId: profile.countryId,
                website: profile.website,
                facebook: profile.facebook,
                google: profile.google,
                twitter: profile.twitter,
                instagram: profile.instagram,
                youtube: profile.youtube,
                vk: profile.vk,
                lastSeenUnixTime: profile.lastSeenUnixTime,
                lastSeenStatus: profile.lastSeenStatus,
                isFollowing: profile.isFollowing,
                canFollow: profile.canFollow,
                isFollowingMe: profile.isFollowingMe,
                isBlocked: profile.isBlocked,
                isReported: profile.isReported,
                points: profile.points,
                proType: profile.proType,
                verified: profile.verified,
                details: profile.details,
              );

              emit(MyProfileState.loaded(
                profile: updatedProfile,
                following: following,
                hasReachedMax: hasReachedMax,
              ));
            },
          );
        },
        onError: (error) {
          emit(MyProfileState.error(
            message: error.message ?? 'Failed to update cover',
            profile: currentProfile,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;

      emit(MyProfileState.error(
        message: 'An error occurred: ${e.toString()}',
        profile: currentProfile,
      ));
    }
  }

  @override
  Future<void> close() {
    _isLoading = false;
    return super.close();
  }
}
