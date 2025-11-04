import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/app_errors.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/user_profile_photo_entity.dart' as photo_entity;
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../data/request/param/user_profile_param.dart';

part 'user_profile_state.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final GetUserProfileByUsernameUseCase getUserProfileByUsernameUseCase;
  final FollowUserUseCase followUserUseCase;
  final BlockUserUseCase blockUserUseCase;
  final ReportUserUseCase reportUserUseCase;
  final PokeUserUseCase pokeUserUseCase;
  final AddToFamilyUseCase addToFamilyUseCase;
  final GetUserPostsUseCase getUserPostsUseCase;
  final GetUserPhotosUseCase getUserPhotosUseCase;
  final GetUserFollowersUseCase getUserFollowersUseCase;
  final GetUserFollowingUseCase getUserFollowingUseCase;
  final GetUserPagesUseCase getUserPagesUseCase;
  final GetUserGroupsUseCase getUserGroupsUseCase;

  // ✅ Cache the loaded profile to prevent null issues
  UserProfileEntity? _cachedProfile;

  UserProfileCubit({
    required this.getUserProfileUseCase,
    required this.getUserProfileByUsernameUseCase,
    required this.followUserUseCase,
    required this.blockUserUseCase,
    required this.reportUserUseCase,
    required this.pokeUserUseCase,
    required this.addToFamilyUseCase,
    required this.getUserPostsUseCase,
    required this.getUserPhotosUseCase,
    required this.getUserFollowersUseCase,
    required this.getUserFollowingUseCase,
    required this.getUserPagesUseCase,
    required this.getUserGroupsUseCase,
  }) : super(const UserProfileInitial());

  // Helper to get current profile from any state or cache
  UserProfileEntity? _getCurrentProfile() {
    if (state is UserProfileLoaded) {
      return (state as UserProfileLoaded).userProfile;
    } else if (state is UserProfilePostsLoaded) {
      return (state as UserProfilePostsLoaded).userProfile;
    } else if (state is UserProfilePhotosLoaded) {
      return (state as UserProfilePhotosLoaded).userProfile;
    } else if (state is UserProfileFollowersLoaded) {
      return (state as UserProfileFollowersLoaded).userProfile;
    } else if (state is UserProfileFollowingLoaded) {
      return (state as UserProfileFollowingLoaded).userProfile;
    }
    return _cachedProfile; // Fallback to cache
  }

  Future<void> loadUserProfile(String userId, {String? username}) async {
    if (isClosed) return;

    emit(const UserProfileLoading());

    try {
      final param = GetUserProfileParam(
        userId: userId,
        username: username,
      );

      final result = await getUserProfileUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          if (!isClosed) {
            _cachedProfile = response.userData; // ✅ Cache the profile
            emit(UserProfileLoaded(userProfile: response.userData));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to load user profile: $e')));
      }
    }
  }

  Future<void> loadUserProfileByUsername(String username) async {
    if (isClosed) return;

    emit(const UserProfileLoading());

    try {
      final param = GetUserProfileByUsernameParam(username: username);

      final result = await getUserProfileByUsernameUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          if (!isClosed) {
            _cachedProfile = response.userData; // ✅ Cache the profile
            emit(UserProfileLoaded(userProfile: response.userData));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to load user profile: $e')));
      }
    }
  }

  Future<void> followUser(String userId) async {
    if (isClosed) return;

    try {
      final param = FollowUserParam(userId: userId);

      final result = await followUserUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          if (isClosed) return;

          // Update the current state to reflect the follow action
          // Get the current profile from whatever state we're in
          UserProfileEntity? currentProfile;

          if (state is UserProfileLoaded) {
            currentProfile = (state as UserProfileLoaded).userProfile;
          } else if (state is UserProfilePostsLoaded) {
            currentProfile = (state as UserProfilePostsLoaded).userProfile;
          } else if (state is UserProfilePhotosLoaded) {
            currentProfile = (state as UserProfilePhotosLoaded).userProfile;
          }

          if (currentProfile != null) {
            // Toggle the follow status
            final updatedProfile = UserProfileEntity(
              userId: currentProfile.userId,
              username: currentProfile.username,
              email: currentProfile.email,
              firstName: currentProfile.firstName,
              lastName: currentProfile.lastName,
              avatar: currentProfile.avatar,
              cover: currentProfile.cover,
              about: currentProfile.about,
              gender: currentProfile.gender,
              birthday: currentProfile.birthday,
              countryId: currentProfile.countryId,
              website: currentProfile.website,
              facebook: currentProfile.facebook,
              google: currentProfile.google,
              twitter: currentProfile.twitter,
              instagram: currentProfile.instagram,
              youtube: currentProfile.youtube,
              vk: currentProfile.vk,
              lastSeenUnixTime: currentProfile.lastSeenUnixTime,
              lastSeenStatus: currentProfile.lastSeenStatus,
              isFollowing: !(currentProfile.isFollowing ?? false),
              canFollow: currentProfile.canFollow,
              isFollowingMe: currentProfile.isFollowingMe,
              isBlocked: currentProfile.isBlocked,
              isReported: currentProfile.isReported,
              points: currentProfile.points,
              proType: currentProfile.proType,
              verified: currentProfile.verified,
              details: currentProfile.details,
            );

            // Emit the appropriate state based on what we were in
            if (state is UserProfileLoaded) {
              emit(UserProfileLoaded(userProfile: updatedProfile));
            } else if (state is UserProfilePostsLoaded) {
              final postsState = state as UserProfilePostsLoaded;
              emit(UserProfilePostsLoaded(
                userProfile: updatedProfile,
                posts: postsState.posts,
              ));
            } else if (state is UserProfilePhotosLoaded) {
              final photosState = state as UserProfilePhotosLoaded;
              emit(UserProfilePhotosLoaded(
                userProfile: updatedProfile,
                photos: photosState.photos,
              ));
            }
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to follow user: $e')));
      }
    }
  }

  Future<void> blockUser(String userId, bool blockAction) async {
    if (isClosed) return;

    try {
      final param = BlockUserParam(userId: userId, blockAction: blockAction);

      final result = await blockUserUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          // Update the current state to reflect the block action
          if (!isClosed && state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            final updatedProfile = UserProfileEntity(
              userId: currentState.userProfile.userId,
              username: currentState.userProfile.username,
              email: currentState.userProfile.email,
              firstName: currentState.userProfile.firstName,
              lastName: currentState.userProfile.lastName,
              avatar: currentState.userProfile.avatar,
              cover: currentState.userProfile.cover,
              about: currentState.userProfile.about,
              gender: currentState.userProfile.gender,
              birthday: currentState.userProfile.birthday,
              countryId: currentState.userProfile.countryId,
              website: currentState.userProfile.website,
              facebook: currentState.userProfile.facebook,
              google: currentState.userProfile.google,
              twitter: currentState.userProfile.twitter,
              instagram: currentState.userProfile.instagram,
              youtube: currentState.userProfile.youtube,
              vk: currentState.userProfile.vk,
              lastSeenUnixTime: currentState.userProfile.lastSeenUnixTime,
              lastSeenStatus: currentState.userProfile.lastSeenStatus,
              isFollowing: currentState.userProfile.isFollowing,
              canFollow: currentState.userProfile.canFollow,
              isFollowingMe: currentState.userProfile.isFollowingMe,
              isBlocked: blockAction,
              isReported: currentState.userProfile.isReported,
              points: currentState.userProfile.points,
              proType: currentState.userProfile.proType,
              verified: currentState.userProfile.verified,
              details: currentState.userProfile.details,
            );
            emit(UserProfileLoaded(userProfile: updatedProfile));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to block user: $e')));
      }
    }
  }

  Future<void> reportUser(String userId, {String? text}) async {
    if (isClosed) return;

    try {
      final param = ReportUserParam(userId: userId, text: text);

      final result = await reportUserUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          // Update the current state to reflect the report action
          if (!isClosed && state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            final updatedProfile = UserProfileEntity(
              userId: currentState.userProfile.userId,
              username: currentState.userProfile.username,
              email: currentState.userProfile.email,
              firstName: currentState.userProfile.firstName,
              lastName: currentState.userProfile.lastName,
              avatar: currentState.userProfile.avatar,
              cover: currentState.userProfile.cover,
              about: currentState.userProfile.about,
              gender: currentState.userProfile.gender,
              birthday: currentState.userProfile.birthday,
              countryId: currentState.userProfile.countryId,
              website: currentState.userProfile.website,
              facebook: currentState.userProfile.facebook,
              google: currentState.userProfile.google,
              twitter: currentState.userProfile.twitter,
              instagram: currentState.userProfile.instagram,
              youtube: currentState.userProfile.youtube,
              vk: currentState.userProfile.vk,
              lastSeenUnixTime: currentState.userProfile.lastSeenUnixTime,
              lastSeenStatus: currentState.userProfile.lastSeenStatus,
              isFollowing: currentState.userProfile.isFollowing,
              canFollow: currentState.userProfile.canFollow,
              isFollowingMe: currentState.userProfile.isFollowingMe,
              isBlocked: currentState.userProfile.isBlocked,
              isReported: true,
              points: currentState.userProfile.points,
              proType: currentState.userProfile.proType,
              verified: currentState.userProfile.verified,
              details: currentState.userProfile.details,
            );
            emit(UserProfileLoaded(userProfile: updatedProfile));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to report user: $e')));
      }
    }
  }

  Future<void> pokeUser(String userId) async {
    if (isClosed) return;

    try {
      final param = PokeUserParam(userId: userId);

      final result = await pokeUserUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          // Poke doesn't change the profile state, just show success
          if (!isClosed) {
            emit(UserProfilePokeSuccess(response.displayMessage));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to poke user: $e')));
      }
    }
  }

  Future<void> addToFamily(String userId, String type) async {
    if (isClosed) return;

    try {
      final param = AddToFamilyParam(userId: userId, type: type);

      final result = await addToFamilyUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (response) {
          // Add to family doesn't change the profile state, just show success
          if (!isClosed) {
            emit(UserProfileAddToFamilySuccess(response.displayMessage));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to add to family: $e')));
      }
    }
  }

  Future<void> loadUserPosts(String userId,
      {int page = 1, int limit = 20}) async {
    if (isClosed) return;

    try {
      final param = GetUserPostsParam(userId: userId, page: page, limit: limit);

      final result = await getUserPostsUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (posts) {
          if (isClosed) return;

          // Preserve the current user profile data
          if (state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: posts,
              ));
            }
          } else if (state is UserProfilePhotosLoaded) {
            // If coming from photos tab, preserve the profile data
            final currentState = state as UserProfilePhotosLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: posts,
              ));
            }
          } else if (state is UserProfilePostsLoaded) {
            // If already in posts loaded state, preserve the profile data
            final currentState = state as UserProfilePostsLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: posts,
              ));
            }
          } else {
            // If no profile data, emit error
            if (!isClosed) {
              emit(UserProfileError(
                  AppErrors.customError(message: 'User profile not loaded')));
            }
          }
        },
        onError: (error) {
          if (isClosed) return;

          // Don't emit error for posts loading failure, just show empty posts
          if (state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: [], // Empty posts list
              ));
            }
          } else if (state is UserProfilePhotosLoaded) {
            // If coming from photos tab, preserve profile and show empty posts
            final currentState = state as UserProfilePhotosLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: [], // Empty posts list
              ));
            }
          } else if (state is UserProfilePostsLoaded) {
            // If already in posts state, just show empty
            final currentState = state as UserProfilePostsLoaded;
            if (!isClosed) {
              emit(UserProfilePostsLoaded(
                userProfile: currentState.userProfile,
                posts: [], // Empty posts list
              ));
            }
          } else {
            if (!isClosed) {
              emit(UserProfileError(error));
            }
          }
        },
      );
    } catch (e) {
      if (isClosed) return;

      // Don't emit error for posts loading failure, just show empty posts
      if (state is UserProfileLoaded) {
        final currentState = state as UserProfileLoaded;
        if (!isClosed) {
          emit(UserProfilePostsLoaded(
            userProfile: currentState.userProfile,
            posts: [], // Empty posts list
          ));
        }
      } else if (state is UserProfilePhotosLoaded) {
        // If coming from photos tab, preserve profile and show empty posts
        final currentState = state as UserProfilePhotosLoaded;
        if (!isClosed) {
          emit(UserProfilePostsLoaded(
            userProfile: currentState.userProfile,
            posts: [], // Empty posts list
          ));
        }
      } else if (state is UserProfilePostsLoaded) {
        // If already in posts state, preserve and show empty
        final currentState = state as UserProfilePostsLoaded;
        if (!isClosed) {
          emit(UserProfilePostsLoaded(
            userProfile: currentState.userProfile,
            posts: [], // Empty posts list
          ));
        }
      } else {
        if (!isClosed) {
          emit(UserProfileError(
              AppErrors.customError(message: 'Failed to load user posts: $e')));
        }
      }
    }
  }

  Future<void> loadUserPhotos(String userId,
      {int page = 1, int limit = 20}) async {
    if (isClosed) return;

    try {
      final param =
          GetUserPhotosParam(userId: userId, page: page, limit: limit);

      final result = await getUserPhotosUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (photos) {
          if (isClosed) return;

          print('🔍 Photos loaded in cubit: ${photos.length} photos');
          // Preserve the current user profile data if available
          if (state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: photos,
              ));
            }
          } else if (state is UserProfilePostsLoaded) {
            // If coming from posts tab, preserve the profile data
            final currentState = state as UserProfilePostsLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: photos,
              ));
            }
          } else if (state is UserProfilePhotosLoaded) {
            // If already in photos loaded state, preserve the profile data
            final currentState = state as UserProfilePhotosLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: photos,
              ));
            }
          } else {
            // If no profile data available, create a minimal profile for photos display
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: UserProfileEntity(
                  userId: userId,
                  username: 'Loading...',
                  firstName: 'Loading...',
                  lastName: null,
                  email: null,
                  avatar: null,
                  cover: null,
                  about: null,
                  gender: null,
                  birthday: null,
                  countryId: null,
                  website: null,
                  facebook: null,
                  google: null,
                  twitter: null,
                  instagram: null,
                  youtube: null,
                  vk: null,
                  lastSeenUnixTime: null,
                  lastSeenStatus: null,
                  isFollowing: false,
                  canFollow: false,
                  isFollowingMe: false,
                  isBlocked: false,
                  isReported: false,
                  points: 0,
                  proType: null,
                  verified: false,
                  details: null,
                  followers: [],
                  following: [],
                  likedPages: [],
                  joinedGroups: [],
                  family: [],
                ),
                photos: photos,
              ));
            }
          }
        },
        onError: (error) {
          if (isClosed) return;

          // Don't emit error for photos loading failure, just show empty photos
          if (state is UserProfileLoaded) {
            final currentState = state as UserProfileLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: [], // Empty photos list
              ));
            }
          } else if (state is UserProfilePostsLoaded) {
            // If coming from posts tab, preserve profile and show empty photos
            final currentState = state as UserProfilePostsLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: [], // Empty photos list
              ));
            }
          } else if (state is UserProfilePhotosLoaded) {
            // If already in photos state, just show empty
            final currentState = state as UserProfilePhotosLoaded;
            if (!isClosed) {
              emit(UserProfilePhotosLoaded(
                userProfile: currentState.userProfile,
                photos: [], // Empty photos list
              ));
            }
          } else {
            if (!isClosed) {
              emit(UserProfileError(error));
            }
          }
        },
      );
    } catch (e) {
      if (isClosed) return;

      // Don't emit error for photos loading failure, just show empty photos
      if (state is UserProfileLoaded) {
        final currentState = state as UserProfileLoaded;
        if (!isClosed) {
          emit(UserProfilePhotosLoaded(
            userProfile: currentState.userProfile,
            photos: [], // Empty photos list
          ));
        }
      } else if (state is UserProfilePostsLoaded) {
        // If coming from posts tab, preserve profile and show empty photos
        final currentState = state as UserProfilePostsLoaded;
        if (!isClosed) {
          emit(UserProfilePhotosLoaded(
            userProfile: currentState.userProfile,
            photos: [], // Empty photos list
          ));
        }
      } else if (state is UserProfilePhotosLoaded) {
        // If already in photos state, preserve and show empty
        final currentState = state as UserProfilePhotosLoaded;
        if (!isClosed) {
          emit(UserProfilePhotosLoaded(
            userProfile: currentState.userProfile,
            photos: [], // Empty photos list
          ));
        }
      } else {
        if (!isClosed) {
          emit(UserProfileError(AppErrors.customError(
              message: 'Failed to load user photos: $e')));
        }
      }
    }
  }

  Future<void> loadUserFollowers(String userId) async {
    if (isClosed) return;

    try {
      final param = GetUserFollowersParam(
        userId: userId,
        limit: 35,
        followersOffset: '0',
        followingOffset: '0',
      );

      final result = await getUserFollowersUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (followers) {
          if (isClosed) return;

          // ✅ Use helper to get current profile (with cache fallback)
          final currentProfile = _getCurrentProfile();

          if (currentProfile != null) {
            emit(UserProfileFollowersLoaded(
              userProfile: currentProfile,
              followers: followers,
            ));
          } else {
            // ✅ If somehow profile is still null, emit error
            emit(UserProfileError(
                AppErrors.customError(message: 'Profile data not available')));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(AppErrors.customError(
            message: 'Failed to load user followers: $e')));
      }
    }
  }

  Future<void> loadUserFollowing(String userId) async {
    if (isClosed) return;

    try {
      final param = GetUserFollowingParam(
        userId: userId,
        limit: 35,
        followersOffset: '0',
        followingOffset: '0',
      );

      final result = await getUserFollowingUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (following) {
          if (isClosed) return;

          // ✅ Use helper to get current profile (with cache fallback)
          final currentProfile = _getCurrentProfile();

          if (currentProfile != null) {
            emit(UserProfileFollowingLoaded(
              userProfile: currentProfile,
              following: following,
            ));
          } else {
            // ✅ If somehow profile is still null, emit error
            emit(UserProfileError(
                AppErrors.customError(message: 'Profile data not available')));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(AppErrors.customError(
            message: 'Failed to load user following: $e')));
      }
    }
  }

  Future<void> loadUserPages(String userId,
      {int page = 1, int limit = 20}) async {
    if (isClosed) return;

    try {
      final param = GetUserPagesParam(userId: userId, page: page, limit: limit);

      final result = await getUserPagesUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (pages) {
          if (!isClosed) {
            emit(UserProfilePagesLoaded(pages: pages));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to load user pages: $e')));
      }
    }
  }

  Future<void> loadUserGroups(String userId,
      {int page = 1, int limit = 20}) async {
    if (isClosed) return;

    try {
      final param =
          GetUserGroupsParam(userId: userId, page: page, limit: limit);

      final result = await getUserGroupsUseCase(param);

      if (isClosed) return;

      result.pick(
        onData: (groups) {
          if (!isClosed) {
            emit(UserProfileGroupsLoaded(groups: groups));
          }
        },
        onError: (error) {
          if (!isClosed) {
            emit(UserProfileError(error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(UserProfileError(
            AppErrors.customError(message: 'Failed to load user groups: $e')));
      }
    }
  }
}
