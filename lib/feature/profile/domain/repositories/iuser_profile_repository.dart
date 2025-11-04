import '../../../../core/errors/app_errors.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../../../core/entities/empty_response_entity.dart';
import '../../data/request/param/user_profile_param.dart';
import '../entities/user_profile_entity.dart';
import '../entities/user_profile_photo_entity.dart' as photo_entity;
import '../../data/request/param/update_avatar_param.dart';
import '../../data/request/param/update_cover_param.dart';

abstract class IUserProfileRepository extends Repository {
  Future<Result<AppErrors, GetUserDataResponseEntity>> getUserProfile(
      GetUserProfileParam param);
  Future<Result<AppErrors, GetUserDataResponseEntity>> getUserProfileByUsername(
      GetUserProfileByUsernameParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> followUser(
      FollowUserParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> blockUser(
      BlockUserParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> reportUser(
      ReportUserParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> pokeUser(PokeUserParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> addToFamily(
      AddToFamilyParam param);
  Future<Result<AppErrors, List<UserProfilePostEntity>>> getUserPosts(
      GetUserPostsParam param);
  Future<Result<AppErrors, List<photo_entity.UserProfilePhotoEntity>>>
      getUserPhotos(GetUserPhotosParam param);
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> getUserFollowers(
      GetUserFollowersParam param);
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> getUserFollowing(
      GetUserFollowingParam param);
  Future<Result<AppErrors, List<UserProfilePageEntity>>> getUserPages(
      GetUserPagesParam param);
  Future<Result<AppErrors, List<UserProfileGroupEntity>>> getUserGroups(
      GetUserGroupsParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> stopNotify(
      StopNotifyParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> updateAvatar(
      UpdateAvatarParam param);
  Future<Result<AppErrors, EmptyResponseEntity>> updateCover(
      UpdateCoverParam param);
}
