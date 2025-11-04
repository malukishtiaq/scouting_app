import 'package:injectable/injectable.dart';
import '../../../../core/entities/empty_response_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/results/result.dart';
import '../entities/user_profile_entity.dart';
import '../entities/user_profile_photo_entity.dart' as photo_entity;
import '../repositories/iuser_profile_repository.dart';
import '../../data/request/param/user_profile_param.dart';

@singleton
class GetUserProfileUseCase
    extends UseCase<GetUserDataResponseEntity, GetUserProfileParam> {
  final IUserProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Result<AppErrors, GetUserDataResponseEntity>> call(
      GetUserProfileParam param) async {
    return await repository.getUserProfile(param);
  }
}

@singleton
class GetUserProfileByUsernameUseCase
    extends UseCase<GetUserDataResponseEntity, GetUserProfileByUsernameParam> {
  final IUserProfileRepository repository;

  GetUserProfileByUsernameUseCase(this.repository);

  @override
  Future<Result<AppErrors, GetUserDataResponseEntity>> call(
      GetUserProfileByUsernameParam param) async {
    return await repository.getUserProfileByUsername(param);
  }
}

@singleton
class FollowUserUseCase extends UseCase<EmptyResponseEntity, FollowUserParam> {
  final IUserProfileRepository repository;

  FollowUserUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      FollowUserParam param) async {
    return await repository.followUser(param);
  }
}

@singleton
class BlockUserUseCase extends UseCase<EmptyResponseEntity, BlockUserParam> {
  final IUserProfileRepository repository;

  BlockUserUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      BlockUserParam param) async {
    return await repository.blockUser(param);
  }
}

@singleton
class ReportUserUseCase extends UseCase<EmptyResponseEntity, ReportUserParam> {
  final IUserProfileRepository repository;

  ReportUserUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      ReportUserParam param) async {
    return await repository.reportUser(param);
  }
}

@singleton
class PokeUserUseCase extends UseCase<EmptyResponseEntity, PokeUserParam> {
  final IUserProfileRepository repository;

  PokeUserUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      PokeUserParam param) async {
    return await repository.pokeUser(param);
  }
}

@singleton
class AddToFamilyUseCase
    extends UseCase<EmptyResponseEntity, AddToFamilyParam> {
  final IUserProfileRepository repository;

  AddToFamilyUseCase(this.repository);

  @override
  Future<Result<AppErrors, EmptyResponseEntity>> call(
      AddToFamilyParam param) async {
    return await repository.addToFamily(param);
  }
}

@singleton
class GetUserPostsUseCase
    extends UseCase<List<UserProfilePostEntity>, GetUserPostsParam> {
  final IUserProfileRepository repository;

  GetUserPostsUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<UserProfilePostEntity>>> call(
      GetUserPostsParam param) async {
    return await repository.getUserPosts(param);
  }
}

@singleton
class GetUserPhotosUseCase extends UseCase<
    List<photo_entity.UserProfilePhotoEntity>, GetUserPhotosParam> {
  final IUserProfileRepository repository;

  GetUserPhotosUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<photo_entity.UserProfilePhotoEntity>>> call(
      GetUserPhotosParam param) async {
    return await repository.getUserPhotos(param);
  }
}

@singleton
class GetUserFollowersUseCase
    extends UseCase<List<UserProfileFollowerEntity>, GetUserFollowersParam> {
  final IUserProfileRepository repository;

  GetUserFollowersUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> call(
      GetUserFollowersParam param) async {
    return await repository.getUserFollowers(param);
  }
}

@singleton
class GetUserFollowingUseCase
    extends UseCase<List<UserProfileFollowerEntity>, GetUserFollowingParam> {
  final IUserProfileRepository repository;

  GetUserFollowingUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<UserProfileFollowerEntity>>> call(
      GetUserFollowingParam param) async {
    return await repository.getUserFollowing(param);
  }
}

@singleton
class GetUserPagesUseCase
    extends UseCase<List<UserProfilePageEntity>, GetUserPagesParam> {
  final IUserProfileRepository repository;

  GetUserPagesUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<UserProfilePageEntity>>> call(
      GetUserPagesParam param) async {
    return await repository.getUserPages(param);
  }
}

@singleton
class GetUserGroupsUseCase
    extends UseCase<List<UserProfileGroupEntity>, GetUserGroupsParam> {
  final IUserProfileRepository repository;

  GetUserGroupsUseCase(this.repository);

  @override
  Future<Result<AppErrors, List<UserProfileGroupEntity>>> call(
      GetUserGroupsParam param) async {
    return await repository.getUserGroups(param);
  }
}
