import '../../domain/entity/login_response_entity.dart';
import '../../../../core/models/empty_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/iaccount_remote.dart';
import '../../data/request/param/love_loop/logout_param.dart';
import '../../data/request/param/love_loop/register_param.dart';
import '../../data/request/param/love_loop/replace_password_param.dart';
import '../../data/request/param/love_loop/resend_email_param.dart';
import '../../data/request/param/love_loop/reset_password_param.dart';
import '../../data/request/param/love_loop/send_code_two_factor_param.dart';
import '../../data/request/param/love_loop/two_factor_param.dart';
import '../../data/request/param/resend_code_param.dart';
import '../../data/request/param/login_param.dart';
import '../../data/request/param/love_loop/delete_account_param.dart';
import '../../data/request/param/social_login_param.dart';
import '../../data/request/param/get_me_param.dart';
import '../../data/request/param/update_profile_param.dart';
import '../../data/request/param/list_members_param.dart';
import '../../data/request/param/show_member_param.dart';
import '../../data/request/param/scouting_register_param.dart';
import '../../data/request/param/scouting_login_param.dart';
import '../../domain/usecase/verify_account_usecase.dart';
import '../entity/member_response_entity.dart';
import '../entity/auth_response_entity.dart';
import '../../../../core/background/isolate_background_service.dart';
import '../../../../di/service_locator.dart';
import '../../../../core/background/tasks_registrar.dart';
import '../../../../core/common/local_storage.dart';

part 'account_repository.dart';

abstract class IAccountRepository extends Repository {
  /// Login method that returns LoginResult union type to handle:
  /// - Successful login
  /// - Pending verification (2FA)
  /// - Error responses
  Future<Result<AppErrors, AuthResponseEntity>> login(LoginParam param);

  Future<Result<AppErrors, AuthResponseEntity>> resgister(RegisterParam param);

  Future<Result<AppErrors, EmptyResponse>> deleteAccount(
      DeleteAccountParam param);

  Future<Result<AppErrors, EmptyResponse>> resetPassword(
      ResetPasswordParam param);

  Future<Result<AppErrors, EmptyResponse>> resendCode(ResendCodeParam param);

  Future<Result<AppErrors, EmptyResponse>> replacePassword(
      ReplacePasswordParam param);

  Future<Result<AppErrors, EmptyResponse>> resendEmail(ResendEmailParam param);

  Future<Result<AppErrors, EmptyResponse>> sendCodeTwoFactor(
      SendCodeTwoFactorParam param);

  Future<Result<AppErrors, AuthResponseEntity>> twoFactor(TwoFactorParam param);

  Future<Result<AppErrors, AuthResponseEntity>> verifyAccount(
      VerifyAccountParam param);

  Future<Result<AppErrors, AuthResponseEntity>> socialLogin(
      SocialLoginParam param);

  Future<Result<AppErrors, EmptyResponse>> logout(LogoutParam param);
  
  // Member APIs (Scouting API)
  Future<Result<AppErrors, AuthResponseEntity>> memberRegister(
      ScoutingRegisterParam param);
  Future<Result<AppErrors, AuthResponseEntity>> memberLogin(ScoutingLoginParam param);
  Future<Result<AppErrors, MemberProfileEntity>> getMe(GetMeParam param);
  Future<Result<AppErrors, UpdateProfileResponseEntity>> updateProfile(
      UpdateProfileParam param);
  Future<Result<AppErrors, MembersListEntity>> listMembers(
      ListMembersParam param);
  Future<Result<AppErrors, MemberProfileEntity>> showMember(
      ShowMemberParam param);
}
