import 'package:injectable/injectable.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/results/result.dart';
import '../../../../../core/entities/empty_response_entity.dart';
import '../../data/datasources/iuser_profile_remote_source.dart';
import '../../data/request/param/user_profile_param.dart';
import '../entities/user_profile_entity.dart';
import '../entities/user_profile_photo_entity.dart' as photo_entity;
import '../../data/request/param/update_avatar_param.dart';
import '../../data/request/param/update_cover_param.dart';
import 'iuser_profile_repository.dart';

@Injectable(as: IUserProfileRepository)
class UserProfileRepository extends IUserProfileRepository {
  UserProfileRepository(this.remoteSource);
  final IUserProfileRemoteSource remoteSource;

  @override
  Future<Result<AppErrors, GetUserDataResponseEntity>> getUserProfile(
      GetUserProfileParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.getUserProfile(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, GetUserDataResponseEntity>> getUserProfileByUsername(
      GetUserProfileByUsernameParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.getUserProfileByUsername(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> followUser(
      FollowUserParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.followUser(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> blockUser(
      BlockUserParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.blockUser(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> reportUser(
      ReportUserParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.reportUser(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> pokeUser(
      PokeUserParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.pokeUser(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> addToFamily(
      AddToFamilyParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.addToFamily(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<UserProfilePostEntity>>> getUserPosts(
      GetUserPostsParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserPosts(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<photo_entity.UserProfilePhotoEntity>>>
      getUserPhotos(GetUserPhotosParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserPhotos(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> getUserFollowers(
      GetUserFollowersParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserFollowers(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> getUserFollowing(
      GetUserFollowingParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserFollowing(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<UserProfilePageEntity>>> getUserPages(
      GetUserPagesParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserPages(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, List<UserProfileGroupEntity>>> getUserGroups(
      GetUserGroupsParam param) async {
    try {
      return executeForList(
        remoteResult: await remoteSource.getUserGroups(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> stopNotify(
      StopNotifyParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.stopNotify(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> updateAvatar(
      UpdateAvatarParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.updateAvatar(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> updateCover(
      UpdateCoverParam param) async {
    try {
      return execute(
        remoteResult: await remoteSource.updateCover(param),
      );
    } catch (e) {
      return Result(
          error: AppErrors.customError(message: 'Repository error: $e'));
    }
  }
}
