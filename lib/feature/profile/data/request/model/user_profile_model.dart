import '../../../../../core/models/base_model.dart';
import '../../../../../core/common/type_validators.dart';
import '../../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends BaseModel<UserProfileEntity> {
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
  final UserProfileDetailsModel? details;
  final List<UserProfileFollowerModel> followers;
  final List<UserProfileFollowerModel> following;
  final List<UserProfilePageModel> likedPages;
  final List<UserProfileGroupModel> joinedGroups;
  final List<UserProfileFollowerModel> family;

  UserProfileModel({
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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      username:
          stringV(json["username"]).isEmpty ? null : stringV(json["username"]),
      email: stringV(json["email"]).isEmpty ? null : stringV(json["email"]),
      firstName: stringV(json["first_name"]).isEmpty
          ? null
          : stringV(json["first_name"]),
      lastName: stringV(json["last_name"]).isEmpty
          ? null
          : stringV(json["last_name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      cover: stringV(json["cover"]).isEmpty ? null : stringV(json["cover"]),
      about: stringV(json["about"]).isEmpty ? null : stringV(json["about"]),
      gender: stringV(json["gender"]).isEmpty ? null : stringV(json["gender"]),
      birthday:
          stringV(json["birthday"]).isEmpty ? null : stringV(json["birthday"]),
      countryId: stringV(json["country_id"]).isEmpty
          ? null
          : stringV(json["country_id"]),
      website:
          stringV(json["website"]).isEmpty ? null : stringV(json["website"]),
      facebook:
          stringV(json["facebook"]).isEmpty ? null : stringV(json["facebook"]),
      google: stringV(json["google"]).isEmpty ? null : stringV(json["google"]),
      twitter:
          stringV(json["twitter"]).isEmpty ? null : stringV(json["twitter"]),
      instagram: stringV(json["instagram"]).isEmpty
          ? null
          : stringV(json["instagram"]),
      youtube:
          stringV(json["youtube"]).isEmpty ? null : stringV(json["youtube"]),
      vk: stringV(json["vk"]).isEmpty ? null : stringV(json["vk"]),
      lastSeenUnixTime: numV<int>(json["lastseen_unix_time"]),
      lastSeenStatus: stringV(json["lastseen_status"]).isEmpty
          ? null
          : stringV(json["lastseen_status"]),
      isFollowing:
          json["is_following"] != null ? boolV(json["is_following"]) : null,
      canFollow: json["can_follow"] != null ? boolV(json["can_follow"]) : null,
      isFollowingMe: json["is_following_me"] != null
          ? boolV(json["is_following_me"])
          : null,
      isBlocked: json["is_blocked"] != null ? boolV(json["is_blocked"]) : null,
      isReported:
          json["is_reported"] != null ? boolV(json["is_reported"]) : null,
      points: numV<int>(json["points"]),
      proType:
          stringV(json["pro_type"]).isEmpty ? null : stringV(json["pro_type"]),
      verified: json["verified"] != null ? boolV(json["verified"]) : null,
      balance:
          stringV(json["balance"]).isEmpty ? null : stringV(json["balance"]),
      wallet: stringV(json["wallet"]).isEmpty ? null : stringV(json["wallet"]),
      details: json["details"] != null && json["details"] is Map
          ? UserProfileDetailsModel.fromJson(json["details"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
      "cover": cover,
      "about": about,
      "gender": gender,
      "birthday": birthday,
      "country_id": countryId,
      "website": website,
      "facebook": facebook,
      "google": google,
      "twitter": twitter,
      "instagram": instagram,
      "youtube": youtube,
      "vk": vk,
      "lastseen_unix_time": lastSeenUnixTime,
      "lastseen_status": lastSeenStatus,
      "is_following": isFollowing,
      "can_follow": canFollow,
      "is_following_me": isFollowingMe,
      "is_blocked": isBlocked,
      "is_reported": isReported,
      "points": points,
      "pro_type": proType,
      "verified": verified,
      "balance": balance,
      "wallet": wallet,
      "details": details?.toJson(),
      "followers": followers.map((f) => f.toJson()).toList(),
      "following": following.map((f) => f.toJson()).toList(),
      "liked_pages": likedPages.map((p) => p.toJson()).toList(),
      "joined_groups": joinedGroups.map((g) => g.toJson()).toList(),
      "family": family.map((f) => f.toJson()).toList(),
    };
  }

  @override
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      userId: userId,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      cover: cover,
      about: about,
      gender: gender,
      birthday: birthday,
      countryId: countryId,
      website: website,
      facebook: facebook,
      google: google,
      twitter: twitter,
      instagram: instagram,
      youtube: youtube,
      vk: vk,
      lastSeenUnixTime: lastSeenUnixTime,
      lastSeenStatus: lastSeenStatus,
      isFollowing: isFollowing,
      canFollow: canFollow,
      isFollowingMe: isFollowingMe,
      isBlocked: isBlocked,
      isReported: isReported,
      points: points,
      proType: proType,
      verified: verified,
      details: details?.toEntity(),
      followers: followers.map((f) => f.toEntity()).toList(),
      following: following.map((f) => f.toEntity()).toList(),
      likedPages: likedPages.map((p) => p.toEntity()).toList(),
      joinedGroups: joinedGroups.map((g) => g.toEntity()).toList(),
      family: family.map((f) => f.toEntity()).toList(),
      wallet: wallet,
    );
  }
}

class UserProfileDetailsModel extends BaseModel<UserProfileDetailsEntity> {
  final int? followersCount;
  final int? followingCount;
  final int? postCount;
  final int? likesCount;
  final int? groupsCount;

  UserProfileDetailsModel({
    this.followersCount,
    this.followingCount,
    this.postCount,
    this.likesCount,
    this.groupsCount,
  });

  factory UserProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDetailsModel(
      followersCount: numV<int>(json["followers_count"]),
      followingCount: numV<int>(json["following_count"]),
      postCount: numV<int>(json["post_count"]),
      likesCount: numV<int>(json["likes_count"]),
      groupsCount: numV<int>(json["groups_count"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "followers_count": followersCount,
      "following_count": followingCount,
      "post_count": postCount,
      "likes_count": likesCount,
      "groups_count": groupsCount,
    };
  }

  @override
  UserProfileDetailsEntity toEntity() {
    return UserProfileDetailsEntity(
      followersCount: followersCount,
      followingCount: followingCount,
      postCount: postCount,
      likesCount: likesCount,
      groupsCount: groupsCount,
    );
  }
}

class UserProfilePostModel extends BaseModel<UserProfilePostEntity> {
  final String? id;
  final String? postId;
  final String? userId;
  final String? recipientId;
  final String? postText;
  final String? pageId;
  final String? groupId;
  final String? eventId;
  final String? pageEventId;
  final String? postLink;
  final String? postLinkTitle;
  final String? postLinkImage;
  final String? postLinkContent;
  final String? postVimeo;
  final String? postDailymotion;
  final String? postFacebook;
  final String? postFile;
  final String? postFileName;
  final String? postFileThumb;
  final String? postYoutube;
  final String? postVine;
  final String? postSoundCloud;
  final String? postPlaytube;
  final String? postDeepsound;
  final String? postMap;
  final String? postShare;
  final String? postPrivacy;
  final String? postType;
  final String? postFeeling;
  final String? postListening;
  final String? postTraveling;
  final String? postWatching;
  final String? postPlaying;
  final String? postPhoto;
  final String? time;
  final String? registered;
  final String? albumName;
  final String? multiImage;
  final String? multiImagePost;
  final String? boosted;
  final String? productId;
  final String? pollId;
  final String? blogId;
  final String? forumId;
  final String? threadId;
  final String? videoViews;
  final String? postRecord;
  final String? postSticker;
  final String? sharedFrom;
  final String? postUrl;
  final String? parentId;
  final String? cache;
  final String? commentsStatus;
  final String? blur;
  final String? colorId;
  final String? jobId;
  final String? offerId;
  final String? fundRaiseId;
  final String? fundId;
  final String? active;
  final String? streamName;
  final String? agoraToken;
  final String? liveTime;
  final String? liveEnded;
  final String? agoraResourceId;
  final String? agoraSid;
  final String? sendNotify;
  final String? video240p;
  final String? video360p;
  final String? video480p;
  final String? video720p;
  final String? video1080p;
  final String? video2048p;
  final String? video4096p;
  final String? processing;
  final String? aiPost;
  final String? videoTitle;
  final String? isReel;
  final String? blurUrl;
  final UserProfilePublisherModel? publisher;
  final int? limitComments;
  final bool? limitedComments;
  final bool? isGroupPost;
  final bool? groupRecipientExists;
  final bool? groupAdmin;
  final List<dynamic>? mentionsUsers;
  final int? postIsPromoted;
  final String? postTextAPI;
  final String? originalText;
  final String? postTime;
  final int? page;
  final String? url;
  final String? seoId;
  final String? viaType;
  final bool? recipientExists;
  final String? recipient;
  final bool? admin;
  final String? postShareCount;
  final bool? isPostSaved;
  final bool? isPostReported;
  final int? isPostBoosted;
  final bool? isLiked;
  final bool? isWondered;
  final String? postComments;
  final String? postShares;
  final String? postLikes;
  final String? postWonders;
  final bool? isPostPinned;
  final List<dynamic>? getPostComments;
  final List<dynamic>? photoAlbum;
  final List<dynamic>? options;
  final int? votedId;
  final String? postFileFull;
  final UserProfileReactionModel? reaction;
  final List<dynamic>? job;
  final List<dynamic>? offer;
  final List<dynamic>? fund;
  final List<dynamic>? fundData;
  final List<dynamic>? forum;
  final List<dynamic>? thread;
  final bool? isStillLive;
  final int? liveSubUsers;
  final bool? haveNextImage;
  final bool? havePreImage;
  final bool? isMonetizedPost;
  final int? canNotSeeMonetized;
  final UserProfileBlogModel? blog;
  final List<String>? tagsArray;
  final String? categoryLink;
  final String? categoryName;
  final bool? isPostAdmin;
  final dynamic sharedInfo;
  final dynamic userData;
  final List<String>? postImages;

  UserProfilePostModel({
    this.id,
    this.postId,
    this.userId,
    this.recipientId,
    this.postText,
    this.pageId,
    this.groupId,
    this.eventId,
    this.pageEventId,
    this.postLink,
    this.postLinkTitle,
    this.postLinkImage,
    this.postLinkContent,
    this.postVimeo,
    this.postDailymotion,
    this.postFacebook,
    this.postFile,
    this.postFileName,
    this.postFileThumb,
    this.postYoutube,
    this.postVine,
    this.postSoundCloud,
    this.postPlaytube,
    this.postDeepsound,
    this.postMap,
    this.postShare,
    this.postPrivacy,
    this.postType,
    this.postFeeling,
    this.postListening,
    this.postTraveling,
    this.postWatching,
    this.postPlaying,
    this.postPhoto,
    this.time,
    this.registered,
    this.albumName,
    this.multiImage,
    this.multiImagePost,
    this.boosted,
    this.productId,
    this.pollId,
    this.blogId,
    this.forumId,
    this.threadId,
    this.videoViews,
    this.postRecord,
    this.postSticker,
    this.sharedFrom,
    this.postUrl,
    this.parentId,
    this.cache,
    this.commentsStatus,
    this.blur,
    this.colorId,
    this.jobId,
    this.offerId,
    this.fundRaiseId,
    this.fundId,
    this.active,
    this.streamName,
    this.agoraToken,
    this.liveTime,
    this.liveEnded,
    this.agoraResourceId,
    this.agoraSid,
    this.sendNotify,
    this.video240p,
    this.video360p,
    this.video480p,
    this.video720p,
    this.video1080p,
    this.video2048p,
    this.video4096p,
    this.processing,
    this.aiPost,
    this.videoTitle,
    this.isReel,
    this.blurUrl,
    this.publisher,
    this.limitComments,
    this.limitedComments,
    this.isGroupPost,
    this.groupRecipientExists,
    this.groupAdmin,
    this.mentionsUsers,
    this.postIsPromoted,
    this.postTextAPI,
    this.originalText,
    this.postTime,
    this.page,
    this.url,
    this.seoId,
    this.viaType,
    this.recipientExists,
    this.recipient,
    this.admin,
    this.postShareCount,
    this.isPostSaved,
    this.isPostReported,
    this.isPostBoosted,
    this.isLiked,
    this.isWondered,
    this.postComments,
    this.postShares,
    this.postLikes,
    this.postWonders,
    this.isPostPinned,
    this.getPostComments,
    this.photoAlbum,
    this.options,
    this.votedId,
    this.postFileFull,
    this.reaction,
    this.job,
    this.offer,
    this.fund,
    this.fundData,
    this.forum,
    this.thread,
    this.isStillLive,
    this.liveSubUsers,
    this.haveNextImage,
    this.havePreImage,
    this.isMonetizedPost,
    this.canNotSeeMonetized,
    this.blog,
    this.tagsArray,
    this.categoryLink,
    this.categoryName,
    this.isPostAdmin,
    this.sharedInfo,
    this.userData,
    this.postImages,
  });

  factory UserProfilePostModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePostModel(
      id: stringV(json["id"]).isEmpty ? null : stringV(json["id"]),
      postId:
          stringV(json["post_id"]).isEmpty ? null : stringV(json["post_id"]),
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      recipientId: stringV(json["recipient_id"]).isEmpty
          ? null
          : stringV(json["recipient_id"]),
      postText:
          stringV(json["postText"]).isEmpty ? null : stringV(json["postText"]),
      pageId:
          stringV(json["page_id"]).isEmpty ? null : stringV(json["page_id"]),
      groupId:
          stringV(json["group_id"]).isEmpty ? null : stringV(json["group_id"]),
      eventId:
          stringV(json["event_id"]).isEmpty ? null : stringV(json["event_id"]),
      pageEventId: stringV(json["page_event_id"]).isEmpty
          ? null
          : stringV(json["page_event_id"]),
      postLink:
          stringV(json["postLink"]).isEmpty ? null : stringV(json["postLink"]),
      postLinkTitle: stringV(json["postLinkTitle"]).isEmpty
          ? null
          : stringV(json["postLinkTitle"]),
      postLinkImage: stringV(json["postLinkImage"]).isEmpty
          ? null
          : stringV(json["postLinkImage"]),
      postLinkContent: stringV(json["postLinkContent"]).isEmpty
          ? null
          : stringV(json["postLinkContent"]),
      postVimeo: stringV(json["postVimeo"]).isEmpty
          ? null
          : stringV(json["postVimeo"]),
      postDailymotion: stringV(json["postDailymotion"]).isEmpty
          ? null
          : stringV(json["postDailymotion"]),
      postFacebook: stringV(json["postFacebook"]).isEmpty
          ? null
          : stringV(json["postFacebook"]),
      postFile:
          stringV(json["postFile"]).isEmpty ? null : stringV(json["postFile"]),
      postFileName: stringV(json["postFileName"]).isEmpty
          ? null
          : stringV(json["postFileName"]),
      postFileThumb: stringV(json["postFileThumb"]).isEmpty
          ? null
          : stringV(json["postFileThumb"]),
      postYoutube: stringV(json["postYoutube"]).isEmpty
          ? null
          : stringV(json["postYoutube"]),
      postVine:
          stringV(json["postVine"]).isEmpty ? null : stringV(json["postVine"]),
      postSoundCloud: stringV(json["postSoundCloud"]).isEmpty
          ? null
          : stringV(json["postSoundCloud"]),
      postPlaytube: stringV(json["postPlaytube"]).isEmpty
          ? null
          : stringV(json["postPlaytube"]),
      postDeepsound: stringV(json["postDeepsound"]).isEmpty
          ? null
          : stringV(json["postDeepsound"]),
      postMap:
          stringV(json["postMap"]).isEmpty ? null : stringV(json["postMap"]),
      postShare: stringV(json["postShare"]).isEmpty
          ? null
          : stringV(json["postShare"]),
      postPrivacy: stringV(json["postPrivacy"]).isEmpty
          ? null
          : stringV(json["postPrivacy"]),
      postType:
          stringV(json["postType"]).isEmpty ? null : stringV(json["postType"]),
      postFeeling: stringV(json["postFeeling"]).isEmpty
          ? null
          : stringV(json["postFeeling"]),
      postListening: stringV(json["postListening"]).isEmpty
          ? null
          : stringV(json["postListening"]),
      postTraveling: stringV(json["postTraveling"]).isEmpty
          ? null
          : stringV(json["postTraveling"]),
      postWatching: stringV(json["postWatching"]).isEmpty
          ? null
          : stringV(json["postWatching"]),
      postPlaying: stringV(json["postPlaying"]).isEmpty
          ? null
          : stringV(json["postPlaying"]),
      postPhoto: stringV(json["postPhoto"]).isEmpty
          ? null
          : stringV(json["postPhoto"]),
      time: stringV(json["time"]).isEmpty ? null : stringV(json["time"]),
      registered: stringV(json["registered"]).isEmpty
          ? null
          : stringV(json["registered"]),
      albumName: stringV(json["album_name"]).isEmpty
          ? null
          : stringV(json["album_name"]),
      multiImage: stringV(json["multi_image"]).isEmpty
          ? null
          : stringV(json["multi_image"]),
      multiImagePost: stringV(json["multi_image_post"]).isEmpty
          ? null
          : stringV(json["multi_image_post"]),
      boosted:
          stringV(json["boosted"]).isEmpty ? null : stringV(json["boosted"]),
      productId: stringV(json["product_id"]).isEmpty
          ? null
          : stringV(json["product_id"]),
      pollId:
          stringV(json["poll_id"]).isEmpty ? null : stringV(json["poll_id"]),
      blogId:
          stringV(json["blog_id"]).isEmpty ? null : stringV(json["blog_id"]),
      forumId:
          stringV(json["forum_id"]).isEmpty ? null : stringV(json["forum_id"]),
      threadId: stringV(json["thread_id"]).isEmpty
          ? null
          : stringV(json["thread_id"]),
      videoViews: stringV(json["videoViews"]).isEmpty
          ? null
          : stringV(json["videoViews"]),
      postRecord: stringV(json["postRecord"]).isEmpty
          ? null
          : stringV(json["postRecord"]),
      postSticker: stringV(json["postSticker"]).isEmpty
          ? null
          : stringV(json["postSticker"]),
      sharedFrom:
          json["shared_from"] != null ? stringV(json["shared_from"]) : null,
      postUrl:
          stringV(json["post_url"]).isEmpty ? null : stringV(json["post_url"]),
      parentId: stringV(json["parent_id"]).isEmpty
          ? null
          : stringV(json["parent_id"]),
      cache: stringV(json["cache"]).isEmpty ? null : stringV(json["cache"]),
      commentsStatus: stringV(json["comments_status"]).isEmpty
          ? null
          : stringV(json["comments_status"]),
      blur: stringV(json["blur"]).isEmpty ? null : stringV(json["blur"]),
      colorId:
          stringV(json["color_id"]).isEmpty ? null : stringV(json["color_id"]),
      jobId: stringV(json["job_id"]).isEmpty ? null : stringV(json["job_id"]),
      offerId:
          stringV(json["offer_id"]).isEmpty ? null : stringV(json["offer_id"]),
      fundRaiseId: stringV(json["fund_raise_id"]).isEmpty
          ? null
          : stringV(json["fund_raise_id"]),
      fundId:
          stringV(json["fund_id"]).isEmpty ? null : stringV(json["fund_id"]),
      active: stringV(json["active"]).isEmpty ? null : stringV(json["active"]),
      streamName: stringV(json["stream_name"]).isEmpty
          ? null
          : stringV(json["stream_name"]),
      agoraToken: stringV(json["agora_token"]).isEmpty
          ? null
          : stringV(json["agora_token"]),
      liveTime: stringV(json["live_time"]).isEmpty
          ? null
          : stringV(json["live_time"]),
      liveEnded: stringV(json["live_ended"]).isEmpty
          ? null
          : stringV(json["live_ended"]),
      agoraResourceId: stringV(json["agora_resource_id"]).isEmpty
          ? null
          : stringV(json["agora_resource_id"]),
      agoraSid: stringV(json["agora_sid"]).isEmpty
          ? null
          : stringV(json["agora_sid"]),
      sendNotify: stringV(json["send_notify"]).isEmpty
          ? null
          : stringV(json["send_notify"]),
      video240p: stringV(json["240p"]).isEmpty ? null : stringV(json["240p"]),
      video360p: stringV(json["360p"]).isEmpty ? null : stringV(json["360p"]),
      video480p: stringV(json["480p"]).isEmpty ? null : stringV(json["480p"]),
      video720p: stringV(json["720p"]).isEmpty ? null : stringV(json["720p"]),
      video1080p:
          stringV(json["1080p"]).isEmpty ? null : stringV(json["1080p"]),
      video2048p:
          stringV(json["2048p"]).isEmpty ? null : stringV(json["2048p"]),
      video4096p:
          stringV(json["4096p"]).isEmpty ? null : stringV(json["4096p"]),
      processing: stringV(json["processing"]).isEmpty
          ? null
          : stringV(json["processing"]),
      aiPost:
          stringV(json["ai_post"]).isEmpty ? null : stringV(json["ai_post"]),
      videoTitle: stringV(json["videoTitle"]).isEmpty
          ? null
          : stringV(json["videoTitle"]),
      isReel:
          stringV(json["is_reel"]).isEmpty ? null : stringV(json["is_reel"]),
      blurUrl:
          stringV(json["blur_url"]).isEmpty ? null : stringV(json["blur_url"]),
      publisher: json["publisher"] != null && json["publisher"] is Map
          ? UserProfilePublisherModel.fromJson(json["publisher"])
          : null,
      limitComments: numV<int>(json["limit_comments"]),
      limitedComments: json["limited_comments"] != null
          ? boolV(json["limited_comments"])
          : null,
      isGroupPost:
          json["is_group_post"] != null ? boolV(json["is_group_post"]) : null,
      groupRecipientExists: json["group_recipient_exists"] != null
          ? boolV(json["group_recipient_exists"])
          : null,
      groupAdmin:
          json["group_admin"] != null ? boolV(json["group_admin"]) : null,
      mentionsUsers:
          json["mentions_users"] != null && json["mentions_users"] is List
              ? json["mentions_users"] as List<dynamic>?
              : null,
      postIsPromoted: numV<int>(json["post_is_promoted"]),
      postTextAPI: stringV(json["postText_API"]).isEmpty
          ? null
          : stringV(json["postText_API"]),
      originalText: stringV(json["Orginaltext"]).isEmpty
          ? null
          : stringV(json["Orginaltext"]),
      postTime: stringV(json["post_time"]).isEmpty
          ? null
          : stringV(json["post_time"]),
      page: numV<int>(json["page"]),
      url: stringV(json["url"]).isEmpty ? null : stringV(json["url"]),
      seoId: stringV(json["seo_id"]).isEmpty ? null : stringV(json["seo_id"]),
      viaType:
          stringV(json["via_type"]).isEmpty ? null : stringV(json["via_type"]),
      recipientExists: json["recipient_exists"] != null
          ? boolV(json["recipient_exists"])
          : null,
      recipient: stringV(json["recipient"]).isEmpty
          ? null
          : stringV(json["recipient"]),
      admin: json["admin"] != null ? boolV(json["admin"]) : null,
      postShareCount: stringV(json["post_share"]).isEmpty
          ? null
          : stringV(json["post_share"]),
      isPostSaved:
          json["is_post_saved"] != null ? boolV(json["is_post_saved"]) : null,
      isPostReported: json["is_post_reported"] != null
          ? boolV(json["is_post_reported"])
          : null,
      isPostBoosted: numV<int>(json["is_post_boosted"]),
      isLiked: json["is_liked"] != null ? boolV(json["is_liked"]) : null,
      isWondered:
          json["is_wondered"] != null ? boolV(json["is_wondered"]) : null,
      postComments: stringV(json["post_comments"]).isEmpty
          ? null
          : stringV(json["post_comments"]),
      postShares: stringV(json["post_shares"]).isEmpty
          ? null
          : stringV(json["post_shares"]),
      postLikes: stringV(json["post_likes"]).isEmpty
          ? null
          : stringV(json["post_likes"]),
      postWonders: stringV(json["post_wonders"]).isEmpty
          ? null
          : stringV(json["post_wonders"]),
      isPostPinned:
          json["is_post_pinned"] != null ? boolV(json["is_post_pinned"]) : null,
      getPostComments:
          json["get_post_comments"] != null && json["get_post_comments"] is List
              ? json["get_post_comments"] as List<dynamic>?
              : null,
      photoAlbum: json["photo_album"] != null && json["photo_album"] is List
          ? json["photo_album"] as List<dynamic>?
          : null,
      options: json["options"] != null && json["options"] is List
          ? json["options"] as List<dynamic>?
          : null,
      votedId: numV<int>(json["voted_id"]),
      postFileFull: stringV(json["postFile_full"]).isEmpty
          ? null
          : stringV(json["postFile_full"]),
      reaction: json["reaction"] != null && json["reaction"] is Map
          ? UserProfileReactionModel.fromJson(json["reaction"])
          : null,
      job: json["job"] != null && json["job"] is List
          ? json["job"] as List<dynamic>?
          : null,
      offer: json["offer"] != null && json["offer"] is List
          ? json["offer"] as List<dynamic>?
          : null,
      fund: json["fund"] != null && json["fund"] is List
          ? json["fund"] as List<dynamic>?
          : null,
      fundData: json["fund_data"] != null && json["fund_data"] is List
          ? json["fund_data"] as List<dynamic>?
          : null,
      forum: json["forum"] != null && json["forum"] is List
          ? json["forum"] as List<dynamic>?
          : null,
      thread: json["thread"] != null && json["thread"] is List
          ? json["thread"] as List<dynamic>?
          : null,
      isStillLive:
          json["is_still_live"] != null ? boolV(json["is_still_live"]) : null,
      liveSubUsers: numV<int>(json["live_sub_users"]),
      haveNextImage: json["have_next_image"] != null
          ? boolV(json["have_next_image"])
          : null,
      havePreImage:
          json["have_pre_image"] != null ? boolV(json["have_pre_image"]) : null,
      isMonetizedPost: json["is_monetized_post"] != null
          ? boolV(json["is_monetized_post"])
          : null,
      canNotSeeMonetized: numV<int>(json["can_not_see_monetized"]),
      blog: json["blog"] != null && json["blog"] is Map
          ? UserProfileBlogModel.fromJson(json["blog"])
          : null,
      tagsArray: json["tags_array"] != null && json["tags_array"] is List
          ? (json["tags_array"] as List<dynamic>)
              .map((e) => stringV(e))
              .toList()
          : null,
      categoryLink: stringV(json["category_link"]).isEmpty
          ? null
          : stringV(json["category_link"]),
      categoryName: stringV(json["category_name"]).isEmpty
          ? null
          : stringV(json["category_name"]),
      isPostAdmin:
          json["is_post_admin"] != null ? boolV(json["is_post_admin"]) : null,
      sharedInfo: json["shared_info"],
      userData: json["user_data"],
      postImages: json["post_images"] != null && json["post_images"] is List
          ? (json["post_images"] as List<dynamic>)
              .map((e) => stringV(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "post_id": postId,
      "user_id": userId,
      "post_text": postText,
      "post_file": postFile,
      "post_file_full": postFileFull,
      "post_time": postTime,
      "post_likes": postLikes,
      "post_comments": postComments,
      "post_shares": postShares,
      "is_liked": isLiked,
      "post_type": postType,
      "post_images": postImages,
    };
  }

  @override
  UserProfilePostEntity toEntity() {
    return UserProfilePostEntity(
      postId: postId,
      userId: userId,
      postText: postText,
      postFile: postFile,
      postFileFull: postFileFull,
      postTime: time ??
          postTime, // ✅ Use "time" field (UNIX timestamp), fallback to postTime
      postLikes: postLikes != null ? int.tryParse(postLikes!) : null,
      postComments: postComments != null ? int.tryParse(postComments!) : null,
      postShares: postShares != null ? int.tryParse(postShares!) : null,
      isLiked: isLiked,
      postType: postType,
      postImages: postImages,
      publisher: publisher?.toEntity(), // ✅ Pass publisher entity
    );
  }
}

class UserProfilePhotoModel extends BaseModel<UserProfilePhotoEntity> {
  final String? photoId;
  final String? photoUrl;
  final String? thumbnailUrl;
  final String? photoTime;
  final String? photoType;

  UserProfilePhotoModel({
    this.photoId,
    this.photoUrl,
    this.thumbnailUrl,
    this.photoTime,
    this.photoType,
  });

  factory UserProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePhotoModel(
      photoId:
          stringV(json["photo_id"]).isEmpty ? null : stringV(json["photo_id"]),
      photoUrl: stringV(json["photo_url"]).isEmpty
          ? null
          : stringV(json["photo_url"]),
      thumbnailUrl: stringV(json["thumbnail_url"]).isEmpty
          ? null
          : stringV(json["thumbnail_url"]),
      photoTime: stringV(json["photo_time"]).isEmpty
          ? null
          : stringV(json["photo_time"]),
      photoType: stringV(json["photo_type"]).isEmpty
          ? null
          : stringV(json["photo_type"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "photo_id": photoId,
      "photo_url": photoUrl,
      "thumbnail_url": thumbnailUrl,
      "photo_time": photoTime,
      "photo_type": photoType,
    };
  }

  @override
  UserProfilePhotoEntity toEntity() {
    return UserProfilePhotoEntity(
      photoId: photoId,
      photoUrl: photoUrl,
      thumbnailUrl: thumbnailUrl,
      photoTime: photoTime,
      photoType: photoType,
    );
  }
}

class UserProfilePageModel extends BaseModel<UserProfilePageEntity> {
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

  UserProfilePageModel({
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

  factory UserProfilePageModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePageModel(
      pageId:
          stringV(json["page_id"]).isEmpty ? null : stringV(json["page_id"]),
      pageName: stringV(json["page_name"]).isEmpty
          ? null
          : stringV(json["page_name"]),
      pageTitle: stringV(json["page_title"]).isEmpty
          ? null
          : stringV(json["page_title"]),
      pageDescription: stringV(json["page_description"]).isEmpty
          ? null
          : stringV(json["page_description"]),
      pageCategory: stringV(json["page_category"]).isEmpty
          ? null
          : stringV(json["page_category"]),
      pageCover: stringV(json["page_cover"]).isEmpty
          ? null
          : stringV(json["page_cover"]),
      pagePicture: stringV(json["page_picture"]).isEmpty
          ? null
          : stringV(json["page_picture"]),
      pageLikes: numV<int>(json["page_likes"]),
      isLiked: json["is_liked"] != null ? boolV(json["is_liked"]) : null,
      isAdmin: json["is_admin"] != null ? boolV(json["is_admin"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "page_id": pageId,
      "page_name": pageName,
      "page_title": pageTitle,
      "page_description": pageDescription,
      "page_category": pageCategory,
      "page_cover": pageCover,
      "page_picture": pagePicture,
      "page_likes": pageLikes,
      "is_liked": isLiked,
      "is_admin": isAdmin,
    };
  }

  @override
  UserProfilePageEntity toEntity() {
    return UserProfilePageEntity(
      pageId: pageId,
      pageName: pageName,
      pageTitle: pageTitle,
      pageDescription: pageDescription,
      pageCategory: pageCategory,
      pageCover: pageCover,
      pagePicture: pagePicture,
      pageLikes: pageLikes,
      isLiked: isLiked,
      isAdmin: isAdmin,
    );
  }
}

class UserProfileGroupModel extends BaseModel<UserProfileGroupEntity> {
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

  UserProfileGroupModel({
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

  factory UserProfileGroupModel.fromJson(Map<String, dynamic> json) {
    return UserProfileGroupModel(
      groupId:
          stringV(json["group_id"]).isEmpty ? null : stringV(json["group_id"]),
      groupName: stringV(json["group_name"]).isEmpty
          ? null
          : stringV(json["group_name"]),
      groupTitle: stringV(json["group_title"]).isEmpty
          ? null
          : stringV(json["group_title"]),
      groupDescription: stringV(json["group_description"]).isEmpty
          ? null
          : stringV(json["group_description"]),
      groupCategory: stringV(json["group_category"]).isEmpty
          ? null
          : stringV(json["group_category"]),
      groupCover: stringV(json["group_cover"]).isEmpty
          ? null
          : stringV(json["group_cover"]),
      groupPicture: stringV(json["group_picture"]).isEmpty
          ? null
          : stringV(json["group_picture"]),
      groupMembers: numV<int>(json["group_members"]),
      isJoined: json["is_joined"] != null ? boolV(json["is_joined"]) : null,
      isAdmin: json["is_admin"] != null ? boolV(json["is_admin"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "group_id": groupId,
      "group_name": groupName,
      "group_title": groupTitle,
      "group_description": groupDescription,
      "group_category": groupCategory,
      "group_cover": groupCover,
      "group_picture": groupPicture,
      "group_members": groupMembers,
      "is_joined": isJoined,
      "is_admin": isAdmin,
    };
  }

  @override
  UserProfileGroupEntity toEntity() {
    return UserProfileGroupEntity(
      groupId: groupId,
      groupName: groupName,
      groupTitle: groupTitle,
      groupDescription: groupDescription,
      groupCategory: groupCategory,
      groupCover: groupCover,
      groupPicture: groupPicture,
      groupMembers: groupMembers,
      isJoined: isJoined,
      isAdmin: isAdmin,
    );
  }
}

class UserProfileFollowerModel extends BaseModel<UserProfileFollowerEntity> {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final bool? isFollowing;
  final bool? isFollowingMe;
  final String? lastSeenStatus;

  UserProfileFollowerModel({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.isFollowing,
    this.isFollowingMe,
    this.lastSeenStatus,
  });

  factory UserProfileFollowerModel.fromJson(Map<String, dynamic> json) {
    return UserProfileFollowerModel(
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      username:
          stringV(json["username"]).isEmpty ? null : stringV(json["username"]),
      firstName: stringV(json["first_name"]).isEmpty
          ? null
          : stringV(json["first_name"]),
      lastName: stringV(json["last_name"]).isEmpty
          ? null
          : stringV(json["last_name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      isFollowing:
          json["is_following"] != null ? boolV(json["is_following"]) : null,
      isFollowingMe: json["is_following_me"] != null
          ? boolV(json["is_following_me"])
          : null,
      lastSeenStatus: stringV(json["lastseen_status"]).isEmpty
          ? null
          : stringV(json["lastseen_status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
      "is_following": isFollowing,
      "is_following_me": isFollowingMe,
      "lastseen_status": lastSeenStatus,
    };
  }

  @override
  UserProfileFollowerEntity toEntity() {
    return UserProfileFollowerEntity(
      userId: userId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      isFollowing: isFollowing,
      isFollowingMe: isFollowingMe,
      lastSeenStatus: lastSeenStatus,
    );
  }
}

class UserProfilePublisherModel extends BaseModel<UserProfilePublisherEntity> {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? verified;

  UserProfilePublisherModel({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.verified,
  });

  factory UserProfilePublisherModel.fromJson(Map<String, dynamic> json) {
    return UserProfilePublisherModel(
      userId:
          stringV(json["user_id"]).isEmpty ? null : stringV(json["user_id"]),
      username:
          stringV(json["username"]).isEmpty ? null : stringV(json["username"]),
      firstName: stringV(json["first_name"]).isEmpty
          ? null
          : stringV(json["first_name"]),
      lastName: stringV(json["last_name"]).isEmpty
          ? null
          : stringV(json["last_name"]),
      avatar: stringV(json["avatar"]).isEmpty ? null : stringV(json["avatar"]),
      verified:
          stringV(json["verified"]).isEmpty ? null : stringV(json["verified"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
      "verified": verified,
    };
  }

  @override
  UserProfilePublisherEntity toEntity() {
    return UserProfilePublisherEntity(
      userId: userId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      verified: verified,
    );
  }
}

class UserProfileReactionModel extends BaseModel<UserProfileReactionEntity> {
  final String? reaction;
  final String? count;

  UserProfileReactionModel({
    this.reaction,
    this.count,
  });

  factory UserProfileReactionModel.fromJson(Map<String, dynamic> json) {
    return UserProfileReactionModel(
      reaction:
          stringV(json["reaction"]).isEmpty ? null : stringV(json["reaction"]),
      count: stringV(json["count"]).isEmpty ? null : stringV(json["count"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reaction": reaction,
      "count": count,
    };
  }

  @override
  UserProfileReactionEntity toEntity() {
    return UserProfileReactionEntity(
      reaction: reaction,
      count: count,
    );
  }
}

class UserProfileBlogModel extends BaseModel<UserProfileBlogEntity> {
  final String? blogId;
  final String? blogTitle;
  final String? blogDescription;
  final String? blogThumbnail;
  final String? blogTime;

  UserProfileBlogModel({
    this.blogId,
    this.blogTitle,
    this.blogDescription,
    this.blogThumbnail,
    this.blogTime,
  });

  factory UserProfileBlogModel.fromJson(Map<String, dynamic> json) {
    return UserProfileBlogModel(
      blogId:
          stringV(json["blog_id"]).isEmpty ? null : stringV(json["blog_id"]),
      blogTitle: stringV(json["blog_title"]).isEmpty
          ? null
          : stringV(json["blog_title"]),
      blogDescription: stringV(json["blog_description"]).isEmpty
          ? null
          : stringV(json["blog_description"]),
      blogThumbnail: stringV(json["blog_thumbnail"]).isEmpty
          ? null
          : stringV(json["blog_thumbnail"]),
      blogTime: stringV(json["blog_time"]).isEmpty
          ? null
          : stringV(json["blog_time"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "blog_id": blogId,
      "blog_title": blogTitle,
      "blog_description": blogDescription,
      "blog_thumbnail": blogThumbnail,
      "blog_time": blogTime,
    };
  }

  @override
  UserProfileBlogEntity toEntity() {
    return UserProfileBlogEntity(
      blogId: blogId,
      blogTitle: blogTitle,
      blogDescription: blogDescription,
      blogThumbnail: blogThumbnail,
      blogTime: blogTime,
    );
  }
}
