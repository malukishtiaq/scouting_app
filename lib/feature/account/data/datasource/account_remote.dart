part of 'iaccount_remote.dart';

@Injectable(as: IAccountRemoteSource)
class AccountRemoteSource extends IAccountRemoteSource {
  // ========== SCOUTING API ==========

  @override
  Future<Either<AppErrors, AuthResponseModel>> memberRegister(
      ScoutingRegisterParam param) async {
    return await request<AuthResponseModel>(
      converter: (json) => AuthResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiMemberRegister,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Register doesn't need auth token
      responseValidator: AuthResponseValidator(),
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, AuthResponseModel>> memberLogin(
      ScoutingLoginParam param) async {
    return await request<AuthResponseModel>(
      converter: (json) => AuthResponseModel.fromJson(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiMemberLogin,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Login doesn't need auth token
      responseValidator: AuthResponseValidator(),
      enableLogging: true,
    );
  }

  @override
  Future<Either<AppErrors, MemberProfileModel>> getMe(GetMeParam param) async {
    return await request(
      converter: (json) => MemberProfileModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiMemberMe,
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }

  @override
  Future<Either<AppErrors, UpdateProfileResponseModel>> updateProfile(
      UpdateProfileParam param) async {
    // If avatar file is provided, use upload method (multipart/form-data)
    if (param.avatarPath != null && param.avatarPath!.isNotEmpty) {
      return await requestUploadFile(
        converter: (json) => UpdateProfileResponseModel.fromJson(json),
        url: MainAPIS.apiMemberUpdate,
        fileKey: 'avatar', // Field name for avatar file
        filePath: param.avatarPath!,
        data: param.toMap(), // Other form fields
        withAuthentication: true, // Requires authentication
        enableLogging: true,
      );
    } else {
      // No file upload, use regular request
      return await request(
        converter: (json) => UpdateProfileResponseModel.fromJson(json),
        method: HttpMethod.POST,
        url: MainAPIS.apiMemberUpdate,
        body: param.toMap(),
        createModelInterceptor: const PrimitiveCreateModelInterceptor(),
        withAuthentication: true, // Requires authentication
        enableLogging: true,
        params: param, // Pass params for cache invalidation
      );
    }
  }

  @override
  Future<Either<AppErrors, MembersListModel>> listMembers(
      ListMembersParam param) async {
    return await request(
      converter: (json) => MembersListModel.fromJson(json),
      method: HttpMethod.GET,
      url: MainAPIS.apiMemberList,
      queryParameters: param.toMap(), // Pass page as query parameter
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }

  @override
  Future<Either<AppErrors, MemberProfileModel>> showMember(
      ShowMemberParam param) async {
    return await request(
      converter: (json) => MemberProfileModel.fromJson(json),
      method: HttpMethod.GET,
      url: '${MainAPIS.apiMemberShow}/${param.userId}',
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: true, // Requires authentication
      enableLogging: false,
      params: param, // Pass params for caching
    );
  }
}
