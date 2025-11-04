part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

class UserProfileLoading extends UserProfileState {
  const UserProfileLoading();
}

class UserProfileLoaded extends UserProfileState {
  final UserProfileEntity userProfile;

  const UserProfileLoaded({required this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileError extends UserProfileState {
  final AppErrors error;

  const UserProfileError(this.error);

  @override
  List<Object?> get props => [error];
}

class UserProfilePostsLoaded extends UserProfileState {
  final UserProfileEntity userProfile;
  final List<UserProfilePostEntity> posts;

  const UserProfilePostsLoaded({
    required this.userProfile,
    required this.posts,
  });

  @override
  List<Object?> get props => [userProfile, posts];
}

class UserProfilePhotosLoaded extends UserProfileState {
  final UserProfileEntity userProfile;
  final List<photo_entity.UserProfilePhotoEntity> photos;

  const UserProfilePhotosLoaded({
    required this.userProfile,
    required this.photos,
  });

  @override
  List<Object?> get props => [userProfile, photos];
}

class UserProfileFollowersLoaded extends UserProfileState {
  final UserProfileEntity userProfile;
  final List<UserProfileFollowerEntity> followers;

  const UserProfileFollowersLoaded({
    required this.userProfile,
    required this.followers,
  });

  @override
  List<Object?> get props => [userProfile, followers];
}

class UserProfileFollowingLoaded extends UserProfileState {
  final UserProfileEntity userProfile;
  final List<UserProfileFollowerEntity> following;

  const UserProfileFollowingLoaded({
    required this.userProfile,
    required this.following,
  });

  @override
  List<Object?> get props => [userProfile, following];
}

class UserProfilePagesLoaded extends UserProfileState {
  final List<UserProfilePageEntity> pages;

  const UserProfilePagesLoaded({required this.pages});

  @override
  List<Object?> get props => [pages];
}

class UserProfileGroupsLoaded extends UserProfileState {
  final List<UserProfileGroupEntity> groups;

  const UserProfileGroupsLoaded({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class UserProfilePokeSuccess extends UserProfileState {
  final String message;

  const UserProfilePokeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UserProfileAddToFamilySuccess extends UserProfileState {
  final String message;

  const UserProfileAddToFamilySuccess(this.message);

  @override
  List<Object?> get props => [message];
}
