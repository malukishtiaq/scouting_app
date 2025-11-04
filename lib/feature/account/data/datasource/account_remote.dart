part of 'iaccount_remote.dart';

@Injectable(as: IAccountRemoteSource)
class AccountRemoteSource extends IAccountRemoteSource {
  @override
  Future<Either<AppErrors, AuthResponseModel>> login(LoginParam param) async {
    return await request(
      converter: (json) =>
          AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
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
  Future<Either<AppErrors, AuthResponseModel>> resgister(
      RegisterParam param) async {
    return await request(
      converter: (json) {
        // Handle response like Xamarin - check api_status first
        final apiStatus = json["api_status"]?.toString() ?? "400";

        switch (apiStatus) {
          case "200": // Success
            return AuthResponseModel.fromJson(
                json); // Pass entire JSON like Xamarin
          case "220": // Verification required
            return AuthResponseModel.fromJson(
                json); // Pass entire JSON like Xamarin
          default: // Error
            return AuthResponseModel.fromJson(
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
  Future<Either<AppErrors, AuthResponseModel>> twoFactor(
      TwoFactorParam param) async {
    return await request(
      converter: (json) =>
          AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: 'users/two-factor', // Use a reasonable endpoint for 2FA
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, AuthResponseModel>> verifyAccount(
      VerifyAccountParam param) async {
    return await request(
      converter: (json) =>
          AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: 'verify-account/', // Account verification endpoint
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }

  @override
  Future<Either<AppErrors, AuthResponseModel>> socialLogin(
      SocialLoginParam param) async {
    return await request(
      converter: (json) =>
          AuthResponseModel.fromJson(json), // Pass entire JSON like Xamarin
      method: HttpMethod.POST,
      url: MainAPIS.apiSocialLogin, // Social login endpoint
      body: param.toMap(),
      createModelInterceptor: const PrimitiveCreateModelInterceptor(),
    );
  }
}
