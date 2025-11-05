import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../core/net/response_validators/auth_response_validator.dart';
import '../../../../mainapis.dart';
import '../request/model/auth_response_model.dart';
import '../request/param/get_me_param.dart';
import '../request/param/update_profile_param.dart';
import '../request/param/list_members_param.dart';
import '../request/param/show_member_param.dart';
import '../request/param/scouting_register_param.dart';
import '../request/param/scouting_login_param.dart';
import '../request/model/member_response_model.dart';

part 'account_remote.dart';

abstract class IAccountRemoteSource extends RemoteDataSource {
  // ========== SCOUTING API ==========
  
  /// Register new member
  /// POST /api/members/register
  Future<Either<AppErrors, AuthResponseModel>> memberRegister(
      ScoutingRegisterParam param);
  
  /// Login member
  /// POST /api/members/login
  Future<Either<AppErrors, AuthResponseModel>> memberLogin(
      ScoutingLoginParam param);
  
  /// Get current user profile
  /// GET /api/me
  Future<Either<AppErrors, MemberProfileModel>> getMe(GetMeParam param);
  
  /// Update user profile
  /// POST /api/profile
  Future<Either<AppErrors, UpdateProfileResponseModel>> updateProfile(
      UpdateProfileParam param);
  
  /// List all members
  /// GET /api/members
  Future<Either<AppErrors, MembersListModel>> listMembers(
      ListMembersParam param);
  
  /// Show specific member
  /// GET /api/members/{user_id}
  Future<Either<AppErrors, MemberProfileModel>> showMember(
      ShowMemberParam param);
}
