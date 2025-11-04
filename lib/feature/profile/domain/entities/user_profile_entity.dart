import '../../../../core/entities/base_entity.dart';

class UserProfileEntity extends BaseEntity {
  final String? userId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? cover;
  final String? about;
  final String? gender;
  final String? birthday;
  final String? countryId;
  final String? website;
  final String? facebook;
  final String? google;
  final String? twitter;
  final String? instagram;
  final String? youtube;
  final String? vk;
  final int? lastSeenUnixTime;
  final String? lastSeenStatus;
  final bool? isFollowing;
  final bool? canFollow;
  final bool? isFollowingMe;
  final bool? isBlocked;
  final bool? isReported;
  final int? points;
  final String? proType;
  final bool? verified;
  final String? balance;
  final String? wallet;
  final UserProfileDetailsEntity? details;
  final List<UserProfileFollowerEntity> followers;
  final List<UserProfileFollowerEntity> following;
  final List<UserProfilePageEntity> likedPages;
  final List<UserProfileGroupEntity> joinedGroups;
  final List<UserProfileFollowerEntity> family;

  UserProfileEntity({
    this.userId,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.cover,
    this.about,
    this.gender,
    this.birthday,
    this.countryId,
    this.website,
    this.facebook,
    this.google,
    this.twitter,
    this.instagram,
    this.youtube,
    this.vk,
    this.lastSeenUnixTime,
    this.lastSeenStatus,
    this.isFollowing,
    this.canFollow,
    this.isFollowingMe,
    this.isBlocked,
    this.isReported,
    this.points,
    this.proType,
    this.verified,
    this.balance,
    this.wallet,
    this.details,
    this.followers = const [],
    this.following = const [],
    this.likedPages = const [],
    this.joinedGroups = const [],
    this.family = const [],
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        firstName,
        lastName,
        avatar,
        cover,
        about,
        gender,
        birthday,
        countryId,
        website,
        facebook,
        google,
        twitter,
        instagram,
        youtube,
        vk,
        lastSeenUnixTime,
        lastSeenStatus,
        isFollowing,
        canFollow,
        isFollowingMe,
        isBlocked,
        isReported,
        points,
        proType,
        verified,
        balance,
        wallet,
        details,
        followers,
        following,
        likedPages,
        joinedGroups,
        family,
      ];

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username ?? 'Unknown User';
  }

  String get displayName {
    return fullName;
  }

  bool get isOnline {
    if (lastSeenStatus == null) return false;
    return lastSeenStatus!.toLowerCase() == 'online';
  }

  String get lastSeenText {
    if (isOnline) return 'Online';
    if (lastSeenUnixTime == null) return 'Last seen recently';

    final lastSeen =
        DateTime.fromMillisecondsSinceEpoch(lastSeenUnixTime! * 1000);
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) return 'Last seen just now';
    if (difference.inMinutes < 60)
      return 'Last seen ${difference.inMinutes}m ago';
    if (difference.inHours < 24) return 'Last seen ${difference.inHours}h ago';
    if (difference.inDays < 7) return 'Last seen ${difference.inDays}d ago';
    return 'Last seen ${lastSeen.day}/${lastSeen.month}/${lastSeen.year}';
  }
}

class UserProfileDetailsEntity extends BaseEntity {
  final int? followersCount;
  final int? followingCount;
  final int? postCount;
  final int? likesCount;
  final int? groupsCount;

  UserProfileDetailsEntity({
    this.followersCount,
    this.followingCount,
    this.postCount,
    this.likesCount,
    this.groupsCount,
  });

  @override
  List<Object?> get props => [
        followersCount,
        followingCount,
        postCount,
        likesCount,
        groupsCount,
      ];
}

class UserProfilePostEntity extends BaseEntity {
  final String? postId;
  final String? userId;
  final String? postText;
  final String? postFile;
  final String? postFileFull;
  final String? postTime;
  final int? postLikes;
  final int? postComments;
  final int? postShares;
  final bool? isLiked;
  final String? postType;
  final List<String>? postImages;
  final UserProfilePublisherEntity? publisher; // ✅ Publisher information

  UserProfilePostEntity({
    this.postId,
    this.userId,
    this.postText,
    this.postFile,
    this.postFileFull,
    this.postTime,
    this.postLikes,
    this.postComments,
    this.postShares,
    this.isLiked,
    this.postType,
    this.postImages,
    this.publisher, // ✅ Publisher information
  });

  @override
  List<Object?> get props => [
        postId,
        userId,
        postText,
        postFile,
        postFileFull,
        postTime,
        postLikes,
        postComments,
        postShares,
        isLiked,
        postType,
        postImages,
        publisher, // ✅ Publisher information
      ];

  String get timeAgo {
    if (postTime == null) return 'Unknown time';

    try {
      final postDateTime = DateTime.parse(postTime!);
      final now = DateTime.now();
      final difference = now.difference(postDateTime);

      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
      if (difference.inHours < 24) return '${difference.inHours}h ago';
      if (difference.inDays < 7) return '${difference.inDays}d ago';
      return '${postDateTime.day}/${postDateTime.month}/${postDateTime.year}';
    } catch (e) {
      return 'Unknown time';
    }
  }

  /// Get user's display name (first name + last name)
  String get publisherName {
    if (publisher == null) return 'Unknown User';
    final firstName = publisher!.firstName ?? '';
    final lastName = publisher!.lastName ?? '';
    if (firstName.isEmpty && lastName.isEmpty) {
      return publisher!.username ?? 'Unknown User';
    }
    return '$firstName $lastName'.trim();
  }

  /// Get user's avatar URL
  String? get publisherAvatar => publisher?.avatar;

  /// Is the publisher verified?
  bool get isPublisherVerified => publisher?.verified == '1';
}

class UserProfilePhotoEntity extends BaseEntity {
  final String? photoId;
  final String? photoUrl;
  final String? thumbnailUrl;
  final String? photoTime;
  final String? photoType;

  UserProfilePhotoEntity({
    this.photoId,
    this.photoUrl,
    this.thumbnailUrl,
    this.photoTime,
    this.photoType,
  });

  @override
  List<Object?> get props => [
        photoId,
        photoUrl,
        thumbnailUrl,
        photoTime,
        photoType,
      ];
}

class UserProfilePageEntity extends BaseEntity {
  final String? pageId;
  final String? pageName;
  final String? pageTitle;
  final String? pageDescription;
  final String? pageCategory;
  final String? pageCover;
  final String? pagePicture;
  final int? pageLikes;
  final bool? isLiked;
  final bool? isAdmin;

  UserProfilePageEntity({
    this.pageId,
    this.pageName,
    this.pageTitle,
    this.pageDescription,
    this.pageCategory,
    this.pageCover,
    this.pagePicture,
    this.pageLikes,
    this.isLiked,
    this.isAdmin,
  });

  @override
  List<Object?> get props => [
        pageId,
        pageName,
        pageTitle,
        pageDescription,
        pageCategory,
        pageCover,
        pagePicture,
        pageLikes,
        isLiked,
        isAdmin,
      ];
}

class UserProfileGroupEntity extends BaseEntity {
  final String? groupId;
  final String? groupName;
  final String? groupTitle;
  final String? groupDescription;
  final String? groupCategory;
  final String? groupCover;
  final String? groupPicture;
  final int? groupMembers;
  final bool? isJoined;
  final bool? isAdmin;

  UserProfileGroupEntity({
    this.groupId,
    this.groupName,
    this.groupTitle,
    this.groupDescription,
    this.groupCategory,
    this.groupCover,
    this.groupPicture,
    this.groupMembers,
    this.isJoined,
    this.isAdmin,
  });

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        groupTitle,
        groupDescription,
        groupCategory,
        groupCover,
        groupPicture,
        groupMembers,
        isJoined,
        isAdmin,
      ];
}

class UserProfileFollowerEntity extends BaseEntity {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final bool? isFollowing;
  final bool? isFollowingMe;
  final String? lastSeenStatus;

  UserProfileFollowerEntity({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.isFollowing,
    this.isFollowingMe,
    this.lastSeenStatus,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        avatar,
        isFollowing,
        isFollowingMe,
        lastSeenStatus,
      ];

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username ?? 'Unknown User';
  }
}

class UserProfilePublisherEntity extends BaseEntity {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? verified;

  UserProfilePublisherEntity({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.verified,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        avatar,
        verified,
      ];
}

class UserProfileReactionEntity extends BaseEntity {
  final String? reaction;
  final String? count;

  UserProfileReactionEntity({
    this.reaction,
    this.count,
  });

  @override
  List<Object?> get props => [
        reaction,
        count,
      ];
}

class UserProfileBlogEntity extends BaseEntity {
  final String? blogId;
  final String? blogTitle;
  final String? blogDescription;
  final String? blogThumbnail;
  final String? blogTime;

  UserProfileBlogEntity({
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogThumbnail,
    this.blogTime,
  });

  @override
  List<Object?> get props => [
        blogId,
        blogTitle,
        blogDescription,
        blogThumbnail,
        blogTime,
      ];
}

class GetUserDataResponseEntity extends BaseEntity {
  final int apiStatus;
  final UserProfileEntity userData;
  final List<UserProfileFollowerEntity> followers;
  final List<UserProfileFollowerEntity> following;
  final List<UserProfilePageEntity> likedPages;
  final List<UserProfileGroupEntity> joinedGroups;
  final List<UserProfileFollowerEntity> family;

  GetUserDataResponseEntity({
    required this.apiStatus,
    required this.userData,
    required this.followers,
    required this.following,
    required this.likedPages,
    required this.joinedGroups,
    required this.family,
  });

  @override
  List<Object?> get props => [
        apiStatus,
        userData,
        followers,
        following,
        likedPages,
        joinedGroups,
        family,
      ];
}
