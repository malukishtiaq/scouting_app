import '../../../../core/models/empty_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../core/net/response_validators/auth_response_validator.dart';
import '../../../../mainapis.dart';
import '../request/model/login_response_model.dart';
import '../request/param/login_param.dart';
import '../request/param/love_loop/delete_account_param.dart';
import '../request/param/love_loop/logout_param.dart';
import '../request/param/love_loop/register_param.dart';
import '../request/param/love_loop/replace_password_param.dart';
import '../request/param/love_loop/resend_email_param.dart';
import '../request/param/love_loop/reset_password_param.dart';
import '../request/param/love_loop/send_code_two_factor_param.dart';
import '../request/param/love_loop/two_factor_param.dart';
import '../request/param/resend_code_param.dart';
import '../request/param/social_login_param.dart';
import '../../domain/usecase/verify_account_usecase.dart';

part 'account_remote.dart';

abstract class IAccountRemoteSource extends RemoteDataSource {
  /// Login method that returns different response types based on Xamarin's logic:
  /// - AuthResponseModel: Successful login
  /// - AuthMessageModel: Pending verification (2FA)
  /// - ErrorModel: API errors
  Future<Either<AppErrors, AuthResponseModel>> login(LoginParam param);
  Future<Either<AppErrors, AuthResponseModel>> resgister(RegisterParam param);
  Future<Either<AppErrors, EmptyResponse>> deleteAccount(
      DeleteAccountParam param);
  Future<Either<AppErrors, EmptyResponse>> resetPassword(
      ResetPasswordParam param);
  Future<Either<AppErrors, EmptyResponse>> resendCode(ResendCodeParam param);
  Future<Either<AppErrors, EmptyResponse>> replacePassword(
      ReplacePasswordParam param);
  Future<Either<AppErrors, EmptyResponse>> resendEmail(ResendEmailParam param);
  Future<Either<AppErrors, EmptyResponse>> sendCodeTwoFactor(
      SendCodeTwoFactorParam param);
  Future<Either<AppErrors, AuthResponseModel>> twoFactor(TwoFactorParam param);
  Future<Either<AppErrors, AuthResponseModel>> verifyAccount(
      VerifyAccountParam param);
  Future<Either<AppErrors, AuthResponseModel>> socialLogin(
      SocialLoginParam param);
  Future<Either<AppErrors, EmptyResponse>> logout(LogoutParam param);
}
