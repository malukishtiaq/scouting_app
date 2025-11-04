part of 'iuser_profile_remote_source.dart';

@Injectable(as: IUserProfileRemoteSource)
class UserProfileRemoteSource extends IUserProfileRemoteSource {
  @override
  Future<Either<AppErrors, GetUserDataResponseModel>> getUserProfile(
      GetUserProfileParam param) async {
    return await request(
      converter: (json) => GetUserDataResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetUserData,
      body: param.toMap(),
      withAuthentication: true,
      enableLogging: true, // ✅ Enable logging to debug the issue
      responseValidator: UserProfileResponseValidator(), // ✅ Use proper validator
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, GetUserDataResponseModel>> getUserProfileByUsername(
      GetUserProfileByUsernameParam param) async {
    return await request(
      converter: (json) => GetUserDataResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetUserDataByUsername,
      body: param.toMap(),
      withAuthentication: true,
      enableLogging: true, // ✅ Enable logging to debug
      responseValidator: UserProfileResponseValidator(), // ✅ Use proper validator
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> followUser(
      FollowUserParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiFollowUser,
      body: param.toMap(),
      withAuthentication: true,
      enableLogging: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> blockUser(
      BlockUserParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiBlockUser,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> reportUser(
      ReportUserParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiReportUser,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> pokeUser(PokeUserParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiPoke, // Correct Xamarin API: /api/poke
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> addToFamily(
      AddToFamilyParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS
          .apiGift, // Correct Xamarin API: /api/gift (AddToFamily uses Gift API)
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, List<UserProfilePostModel>>> getUserPosts(
      GetUserPostsParam param) async {
    return await listRequest(
      converter: (json) => UserProfilePostModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetPost,
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      params: param, // ✅ Enable automatic caching for user posts (30-min TTL)
    );
  }

  @override
  Future<Either<AppErrors, List<photo_model.UserProfilePhotoModel>>>
      getUserPhotos(GetUserPhotosParam param) async {
    return await listRequest(
      converter: (json) => photo_model.UserProfilePhotoModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetUserAlbums,
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      params: param, // ✅ Enable automatic caching for user photos (60-min TTL)
    );
  }

  @override
  Future<Either<AppErrors, List<UserProfileFollowerModel>>> getUserFollowers(
      GetUserFollowersParam param) async {
    return await listRequest(
      converter: (json) => UserProfileFollowerModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetFriends, // ✅ Changed from apiGetUserData to apiGetFriends
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      params: param, // ✅ Enable automatic caching for user followers
    );
  }

  @override
  Future<Either<AppErrors, List<UserProfileFollowerModel>>> getUserFollowing(
      GetUserFollowingParam param) async {
    return await listRequest(
      converter: (json) => UserProfileFollowerModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetFriends, // ✅ Changed from apiGetUserData to apiGetFriends
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      params: param, // ✅ Enable automatic caching for user following
    );
  }

  @override
  Future<Either<AppErrors, List<UserProfilePageModel>>> getUserPages(
      GetUserPagesParam param) async {
    return await listRequest(
      converter: (json) => UserProfilePageModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetUserData,
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, List<UserProfileGroupModel>>> getUserGroups(
      GetUserGroupsParam param) async {
    return await listRequest(
      converter: (json) => UserProfileGroupModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiGetUserData,
      body: param.toMap(),
      withAuthentication: true,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> stopNotify(
      StopNotifyParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiStopNotify,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateAvatar(
      UpdateAvatarParam param) async {
    // If file is provided, use requestUploadFile
    if (param.avatarPath != null && param.avatarPath!.isNotEmpty) {
      return await requestUploadFile(
        converter: (json) => EmptyResponse.fromMap(json),
        url: MainAPIS.apiUpdateUserData,
        fileKey: 'avatar', // Form field name for avatar (from Xamarin code)
        filePath: param.avatarPath!, // Path to the file
        data: param.toMap(), // Additional form fields
        withAuthentication: true,
        createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      );
    } else {
      // No file, use regular request
      return await request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        url: MainAPIS.apiUpdateUserData,
        body: param.toMap(),
        withAuthentication: true,
        isFormData: true,
        createModelInterceptor: const PrimitiveCreateModelInterceptor(),
        params: param, // ✅ CRITICAL: MUST pass params for cache invalidation!
      );
    }
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateCover(
      UpdateCoverParam param) async {
    // If file is provided, use requestUploadFile
    if (param.coverPath != null && param.coverPath!.isNotEmpty) {
      return await requestUploadFile(
        converter: (json) => EmptyResponse.fromMap(json),
        url: MainAPIS.apiUpdateUserData,
        fileKey: 'cover', // Form field name for cover (from Xamarin code)
        filePath: param.coverPath!, // Path to the file
        data: param.toMap(), // Additional form fields
        withAuthentication: true,
        createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      );
    } else {
      // No file, use regular request
      return await request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        url: MainAPIS.apiUpdateUserData,
        body: param.toMap(),
        withAuthentication: true,
        isFormData: true,
        createModelInterceptor: const PrimitiveCreateModelInterceptor(),
        params: param, // ✅ CRITICAL: MUST pass params for cache invalidation!
      );
    }
  }
}
