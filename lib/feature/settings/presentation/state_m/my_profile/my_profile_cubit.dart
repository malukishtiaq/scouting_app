import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../account/domain/usecase/get_me_usecase.dart';
import '../../../../account/data/request/param/get_me_param.dart';
import '../../../../profile/domain/usecases/update_avatar_usecase.dart';
import '../../../../profile/domain/usecases/update_cover_usecase.dart';
import '../../../../profile/data/request/param/update_avatar_param.dart';
import '../../../../profile/data/request/param/update_cover_param.dart';
import '../../../../profile/domain/entities/user_profile_entity.dart';
import 'my_profile_state.dart';

@injectable
class MyProfileCubit extends Cubit<MyProfileState> {
  final GetMeUsecase _getMeUsecase;
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final UpdateCoverUseCase _updateCoverUseCase;
  final AuthService _authService;

  bool _isLoading = false;

  MyProfileCubit({
    required GetMeUsecase getMeUsecase,
    required UpdateAvatarUseCase updateAvatarUseCase,
    required UpdateCoverUseCase updateCoverUseCase,
    required AuthService authService,
  })  : _getMeUsecase = getMeUsecase,
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

    // Check if user is logged in
    if (!_authService.isLoggedIn) {
      emit(MyProfileState.error(
        message: 'User not logged in',
        profile: null,
      ));
      _isLoading = false;
      return;
    }

    emit(const MyProfileState.loading());

    // ⚠️ WORKAROUND: Temporarily disabled /api/me call due to backend bug
    // The backend's Helper::isUserProfileCompleted() crashes when playerProfile is null
    // Using mock profile data until backend is fixed
    print('⚠️ MyProfileCubit: Skipping /api/me call due to backend bug');
    print('ℹ️ Using mock profile data until backend is fixed');

    // Create a mock profile from auth service data
    final mockProfile = UserProfileEntity(
      userId: _authService.currentUserId?.toString() ?? '0',
      username: _authService.currentUsername ?? 'User',
      email: 'user@example.com', // TODO: Get from login response
      firstName: _authService.currentUsername ?? 'User',
      lastName: '',
      avatar: 'https://scouting.terveys.io/images/default-avatar.png',
      cover: '',
      about: '',
      gender: '',
      birthday: '',
      countryId: '',
      website: '',
      facebook: '',
      google: '',
      twitter: '',
      instagram: '',
      youtube: '',
      vk: '',
      lastSeenUnixTime: 0,
      lastSeenStatus: '',
      isFollowing: false,
      canFollow: false,
      isFollowingMe: false,
      isBlocked: false,
      isReported: false,
      points: 0,
      proType: '',
      verified: false,
      details: null,
    );

    emit(MyProfileState.loaded(
      profile: mockProfile,
      following: [],
      hasReachedMax: false,
    ));
    _isLoading = false;
    return;

    // TODO: Re-enable this when backend fixes the bug
    /*
    try {
      // Use /me endpoint to get current user profile (Scouting API)
      final param = GetMeParam();
      final result = await _getMeUsecase(param);

      if (isClosed) {
        _isLoading = false;
        return;
      }

      result.pick(
        onData: (response) {
          // Convert MemberDataEntity to UserProfileEntity for compatibility
          final memberData = response.data;
          final profile = UserProfileEntity(
            userId: _authService.currentUserId?.toString() ?? '0',
            username: memberData.name ?? '',
            email: memberData.email,
            firstName: memberData.name ?? '',
            lastName: '',
            avatar: memberData.avatar,
            cover: '', // Not available in Scouting API /me response
            about: '', // Not available in Scouting API /me response
            gender: '', // Not available in Scouting API /me response
            birthday: '', // Not available in Scouting API /me response
            countryId: '', // Not available in Scouting API /me response
            website: '', // Not available in Scouting API /me response
            facebook: '', // Not available in Scouting API /me response
            google: '', // Not available in Scouting API /me response
            twitter: '', // Not available in Scouting API /me response
            instagram: '', // Not available in Scouting API /me response
            youtube: '', // Not available in Scouting API /me response
            vk: '', // Not available in Scouting API /me response
            lastSeenUnixTime: 0, // Not available in Scouting API /me response
            lastSeenStatus: '', // Not available in Scouting API /me response
            isFollowing: false, // Not available in Scouting API /me response
            canFollow: false, // Not available in Scouting API /me response
            isFollowingMe: false, // Not available in Scouting API /me response
            isBlocked: false, // Not available in Scouting API /me response
            isReported: false, // Not available in Scouting API /me response
            points: 0, // Not available in Scouting API /me response
            proType: '', // Not available in Scouting API /me response
            verified:
                memberData.emailVerified, // Map email_verified to verified
            details: null, // Not available in Scouting API /me response
          );

          emit(MyProfileState.loaded(
            profile: profile,
            following: [], // No following data from /me endpoint
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
    */
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
