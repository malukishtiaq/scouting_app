import 'package:scouting_app/mainapis.dart';

import '../../../../../core/params/base_params.dart';

class GetUserProfileParam extends BaseParams {
  final String userId;
  final String? username;
  final String fetch;

  GetUserProfileParam({
    required this.userId,
    this.username,
    this.fetch =
        "user_data,followers,following,liked_pages,joined_groups,family",
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      if (username != null) 'username': username,
      'fetch': fetch,
    };
  }
}

class GetUserProfileByUsernameParam extends BaseParams {
  final String username;
  final String fetch;

  GetUserProfileByUsernameParam({
    required this.username,
    this.fetch =
        "user_data,followers,following,liked_pages,joined_groups,family",
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'username': username,
      'fetch': fetch,
    };
  }
}

class FollowUserParam extends BaseParams {
  final String userId;

  FollowUserParam({
    required this.userId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
    };
  }
}

class BlockUserParam extends BaseParams {
  final String userId;
  final bool blockAction;

  BlockUserParam({
    required this.userId,
    required this.blockAction,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'block_action': blockAction ? '1' : '0',
    };
  }
}

class ReportUserParam extends BaseParams {
  final String userId;
  final String? text;

  ReportUserParam({
    required this.userId,
    this.text,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      if (text != null) 'text': text,
    };
  }
}

class PokeUserParam extends BaseParams {
  final String userId;

  PokeUserParam({
    required this.userId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
    };
  }
}

class AddToFamilyParam extends BaseParams {
  final String userId;
  final String type;

  AddToFamilyParam({
    required this.userId,
    required this.type,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'type': type,
    };
  }
}

class GetUserPostsParam extends BaseParams {
  final String userId;
  final int page;
  final int limit;
  final String afterPostId; // Changed from page to afterPostId (like Xamarin)

  GetUserPostsParam({
    required this.userId,
    this.page = 1,
    this.limit = 20,
    this.afterPostId = "0", // Default to "0" like Xamarin
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'type': 'get_user_posts', // Correct type parameter like Xamarin
      'limit': limit.toString(),
      'after_post_id': afterPostId, // Use after_post_id like Xamarin
      'id': userId, // Use 'id' parameter like Xamarin
    };
  }
}

class GetUserPhotosParam extends BaseParams {
  final String userId;
  final int page;
  final int limit;

  GetUserPhotosParam({
    required this.userId,
    this.page = 1,
    this.limit = 20,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'page': page,
      'limit': limit,
      'type': 'photos', // Add type parameter for API compatibility
    };
  }
}

class GetUserFollowersParam extends BaseParams {
  final String userId;
  final int limit;
  final String followersOffset;
  final String followingOffset;

  GetUserFollowersParam({
    required this.userId,
    this.limit = 35,
    this.followersOffset = '0',
    this.followingOffset = '0',
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'type': 'followers', // ✅ Changed from 'fetch' to 'type' to match Xamarin API
      'limit': limit.toString(),
      'followers_offset': followersOffset,
      'following_offset': followingOffset,
    };
  }
}

class GetUserFollowingParam extends BaseParams {
  final String userId;
  final int limit;
  final String followersOffset;
  final String followingOffset;

  GetUserFollowingParam({
    required this.userId,
    this.limit = 35,
    this.followersOffset = '0',
    this.followingOffset = '0',
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'type': 'following', // ✅ Changed from 'fetch' to 'type' to match Xamarin API
      'limit': limit.toString(),
      'followers_offset': followersOffset,
      'following_offset': followingOffset,
    };
  }
}

class GetUserPagesParam extends BaseParams {
  final String userId;
  final int page;
  final int limit;

  GetUserPagesParam({
    required this.userId,
    this.page = 1,
    this.limit = 20,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'fetch': 'liked_pages',
      'page': page,
      'limit': limit,
    };
  }
}

class GetUserGroupsParam extends BaseParams {
  final String userId;
  final int page;
  final int limit;

  GetUserGroupsParam({
    required this.userId,
    this.page = 1,
    this.limit = 20,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
      'fetch': 'joined_groups',
      'page': page,
      'limit': limit,
    };
  }
}

class StopNotifyParam extends BaseParams {
  final String userId;

  StopNotifyParam({
    required this.userId,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'server_key': MainAPIS.serverKey,
      'user_id': userId,
    };
  }
}
