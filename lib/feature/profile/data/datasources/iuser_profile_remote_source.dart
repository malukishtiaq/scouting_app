import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/datasources/remote_data_source.dart';
import '../../../../../core/net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../../../../../core/net/response_validators/user_profile_response_validator.dart';
import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/models/empty_response.dart';
import '../../../../mainapis.dart';
import '../request/model/user_profile_model.dart';
import '../request/model/user_profile_photo_model.dart' as photo_model;
import '../request/model/get_user_data_response_model.dart';
import '../request/param/update_avatar_param.dart';
import '../request/param/update_cover_param.dart';
import '../request/param/user_profile_param.dart';
part 'user_profile_remote_source.dart';

abstract class IUserProfileRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, GetUserDataResponseModel>> getUserProfile(
      GetUserProfileParam param);
  Future<Either<AppErrors, GetUserDataResponseModel>> getUserProfileByUsername(
      GetUserProfileByUsernameParam param);
  Future<Either<AppErrors, EmptyResponse>> followUser(FollowUserParam param);
  Future<Either<AppErrors, EmptyResponse>> blockUser(BlockUserParam param);
  Future<Either<AppErrors, EmptyResponse>> reportUser(ReportUserParam param);
  Future<Either<AppErrors, EmptyResponse>> pokeUser(PokeUserParam param);
  Future<Either<AppErrors, EmptyResponse>> addToFamily(AddToFamilyParam param);
  Future<Either<AppErrors, List<UserProfilePostModel>>> getUserPosts(
      GetUserPostsParam param);
  Future<Either<AppErrors, List<photo_model.UserProfilePhotoModel>>>
      getUserPhotos(GetUserPhotosParam param);
  Future<Either<AppErrors, List<UserProfileFollowerModel>>> getUserFollowers(
      GetUserFollowersParam param);
  Future<Either<AppErrors, List<UserProfileFollowerModel>>> getUserFollowing(
      GetUserFollowingParam param);
  Future<Either<AppErrors, List<UserProfilePageModel>>> getUserPages(
      GetUserPagesParam param);
  Future<Either<AppErrors, List<UserProfileGroupModel>>> getUserGroups(
      GetUserGroupsParam param);
  Future<Either<AppErrors, EmptyResponse>> stopNotify(StopNotifyParam param);
  Future<Either<AppErrors, EmptyResponse>> updateAvatar(
      UpdateAvatarParam param);
  Future<Either<AppErrors, EmptyResponse>> updateCover(UpdateCoverParam param);
}
