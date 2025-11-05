part of 'iaccount_remote.dart';

@Injectable(as: IAccountRemoteSource)
class AccountRemoteSource extends IAccountRemoteSource {
  @override
  Future<Either<AppErrors, WoWonder.AuthResponseModel>> login(LoginParam param) async {
    return await request<WoWonder.AuthResponseModel>(
      converter: (json) =>
          WoWonder.AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: MainAPIS.apiAuth,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Login doesn't need auth token
      responseValidator: AuthResponseValidator(), // Use custom auth validator
      enableLogging:
          true, // Enable logging for login method to debug auth issues
    );
  }

  @override
  Future<Either<AppErrors, WoWonder.AuthResponseModel>> resgister(
      RegisterParam param) async {
    return await request<WoWonder.AuthResponseModel>(
      converter: (json) {
        // Handle response like Xamarin - check api_status first
        final apiStatus = json["api_status"]?.toString() ?? "400";

        switch (apiStatus) {
          case "200": // Success
            return WoWonder.AuthResponseModel.fromJson(
                json); // Pass entire JSON like Xamarin
          case "220": // Verification required
            return WoWonder.AuthResponseModel.fromJson(
                json); // Pass entire JSON like Xamarin
          default: // Error
            return WoWonder.AuthResponseModel.fromJson(
                json); // Pass entire JSON like Xamarin
        }
      },
      method: HttpMethod.POST,
      url: MainAPIS.apiCreateAccount,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Register doesn't need auth token
      responseValidator: AuthResponseValidator(), // Use custom auth validator
      enableLogging:
          false, // Disable logging for register method (default behavior)
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteAccount(
      DeleteAccountParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.DELETE,
      url: MainAPIS.apiDeleteUser,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> resetPassword(
      ResetPasswordParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiResetPassword,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> resendCode(
      ResendCodeParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiSendResetPasswordEmail,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Resend code doesn't need auth token
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> replacePassword(
      ReplacePasswordParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url:
          'users/change-password', // Use a reasonable endpoint for password change
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> logout(LogoutParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: 'users/logout',
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> resendEmail(
      ResendEmailParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: MainAPIS.apiSendResetPasswordEmail,
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
      withAuthentication: false, // Resend email doesn't need auth token
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> sendCodeTwoFactor(
      SendCodeTwoFactorParam param) async {
    return await request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: 'users/send-code-two-factor',
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, WoWonder.AuthResponseModel>> twoFactor(
      TwoFactorParam param) async {
    return await request<WoWonder.AuthResponseModel>(
      converter: (json) =>
          WoWonder.AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: 'users/two-factor', // Use a reasonable endpoint for 2FA
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, WoWonder.AuthResponseModel>> verifyAccount(
      VerifyAccountParam param) async {
    return await request<WoWonder.AuthResponseModel>(
      converter: (json) =>
          WoWonder.AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: 'verify-account/', // Account verification endpoint
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, WoWonder.AuthResponseModel>> socialLogin(
      SocialLoginParam param) async {
    return await request<WoWonder.AuthResponseModel>(
      converter: (json) =>
          WoWonder.AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: MainAPIS.apiSocialLogin, // Social login endpoint
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  // ========== MEMBER APIs (Scouting API) ==========

  @override
  Future<Either<AppErrors, Scouting.AuthResponseModel>> memberRegister(
      ScoutingRegisterParam param) async {
    return await request<Scouting.AuthResponseModel>(
      converter: (json) => Scouting.AuthResponseModel.fromJson(json),
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
  Future<Either<AppErrors, Scouting.AuthResponseModel>> memberLogin(
      ScoutingLoginParam param) async {
    return await request<Scouting.AuthResponseModel>(
      converter: (json) => Scouting.AuthResponseModel.fromJson(json),
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
