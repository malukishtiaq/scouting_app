import '../../domain/entity/auth_response_entity.dart';
import '../../data/request/model/auth_response_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/datasource/iaccount_remote.dart';
import '../../data/request/param/get_me_param.dart';
import '../../data/request/param/update_profile_param.dart';
import '../../data/request/param/list_members_param.dart';
import '../../data/request/param/show_member_param.dart';
import '../../data/request/param/scouting_register_param.dart';
import '../../data/request/param/scouting_login_param.dart';
import '../entity/member_response_entity.dart';
import '../../../../core/background/isolate_background_service.dart';
import '../../../../di/service_locator.dart';
import '../../../../core/background/tasks_registrar.dart';
import '../../../../core/common/local_storage.dart';

part 'account_repository.dart';

abstract class IAccountRepository extends Repository {
  // ========== SCOUTING API ==========
  
  /// Register new member
  /// POST /api/members/register
  Future<Result<AppErrors, AuthResponseEntity>> memberRegister(
      ScoutingRegisterParam param);
  
  /// Login member
  /// POST /api/members/login
  Future<Result<AppErrors, AuthResponseEntity>> memberLogin(ScoutingLoginParam param);
  
  /// Get current user profile
  /// GET /api/me
  Future<Result<AppErrors, MemberProfileEntity>> getMe(GetMeParam param);
  
  /// Update user profile
  /// POST /api/profile
  Future<Result<AppErrors, UpdateProfileResponseEntity>> updateProfile(
      UpdateProfileParam param);
  
  /// List all members
  /// GET /api/members
  Future<Result<AppErrors, MembersListEntity>> listMembers(
      ListMembersParam param);
  
  /// Show specific member
  /// GET /api/members/{user_id}
  Future<Result<AppErrors, MemberProfileEntity>> showMember(
      ShowMemberParam param);
}
