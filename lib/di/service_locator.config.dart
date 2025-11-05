// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../core/background/api/background_api.dart' as _i699;
import '../core/background/generic_background_service.dart' as _i821;
import '../core/background/integration_test.dart' as _i505;
import '../core/background/isolate_background_service.dart' as _i81;
import '../core/background/tasks_registrar.dart' as _i788;
import '../core/background/test_generic_service.dart' as _i166;
import '../core/data/cache/generic_cache_service.dart' as _i798;
import '../core/data/db/db_provider.dart' as _i591;
import '../core/navigation/navigation_service.dart' as _i796;
import '../core/navigation/route_generator.dart' as _i45;
import '../core/net/http_client.dart' as _i1004;
import '../core/providers/session_data.dart' as _i1028;
import '../core/services/auth_service.dart' as _i377;
import '../core/services/background_chat_service.dart' as _i822;
import '../core/services/notification_analytics_service.dart' as _i3;
import '../core/services/notification_preferences_service.dart' as _i975;
import '../core/services/notification_service.dart' as _i570;
import '../core/services/referral_sharing_service.dart' as _i142;
import '../core/socket/socket_service.dart' as _i593;
import '../core/socket/socket_service_interface.dart' as _i740;
import '../feature/account/data/datasource/iaccount_remote.dart' as _i494;
import '../feature/account/domain/repository/iaccount_repository.dart' as _i462;
import '../feature/account/domain/usecase/get_me_usecase.dart' as _i1043;
import '../feature/account/domain/usecase/list_members_usecase.dart' as _i813;
import '../feature/account/domain/usecase/member_login_usecase.dart' as _i267;
import '../feature/account/domain/usecase/member_register_usecase.dart'
    as _i314;
import '../feature/account/domain/usecase/show_member_usecase.dart' as _i741;
import '../feature/account/domain/usecase/update_profile_usecase.dart' as _i672;
import '../feature/comments/data/datasource/icomments_remote.dart' as _i753;
import '../feature/comments/domain/repository/comments_repository.dart'
    as _i1000;
import '../feature/comments/domain/repository/icomments_repository.dart'
    as _i141;
import '../feature/comments/domain/usecase/create_comment_usecase.dart'
    as _i234;
import '../feature/comments/domain/usecase/get_post_comments_usecase.dart'
    as _i109;
import '../feature/comments/domain/usecase/get_user_comments_usecase.dart'
    as _i597;
import '../feature/likes/data/datasource/ilikes_remote.dart' as _i591;
import '../feature/likes/domain/repository/ilikes_repository.dart' as _i1020;
import '../feature/likes/domain/repository/likes_repository.dart' as _i548;
import '../feature/likes/domain/usecase/get_post_likes_usecase.dart' as _i805;
import '../feature/likes/domain/usecase/get_user_likes_usecase.dart' as _i779;
import '../feature/likes/domain/usecase/toggle_like_usecase.dart' as _i686;
import '../feature/player_stats/data/datasources/iplayer_remote_datasource.dart'
    as _i495;
import '../feature/player_stats/domain/repositories/iplayer_repository.dart'
    as _i834;
import '../feature/posts/data/datasources/iposts_remote_datasource.dart'
    as _i177;
import '../feature/posts/data/datasources/posts_remote_datasource.dart'
    as _i524;
import '../feature/posts/domain/repositories/iposts_repository.dart' as _i53;
import '../feature/posts/domain/repositories/posts_repository.dart' as _i663;
import '../feature/posts/domain/usecase/get_post_by_id_usecase.dart' as _i316;
import '../feature/posts/domain/usecase/get_posts_usecase.dart' as _i805;
import '../feature/posts/presentation/cubit/posts_cubit.dart' as _i319;
import '../feature/profile/data/datasources/iuser_profile_remote_source.dart'
    as _i228;
import '../feature/profile/domain/repositories/iuser_profile_repository.dart'
    as _i17;
import '../feature/profile/domain/repositories/user_profile_repository.dart'
    as _i517;
import '../feature/profile/domain/usecases/get_user_profile_usecase.dart'
    as _i714;
import '../feature/profile/domain/usecases/update_avatar_usecase.dart' as _i855;
import '../feature/profile/domain/usecases/update_cover_usecase.dart' as _i13;
import '../feature/profile/presentation/cubit/user_profile_cubit.dart'
    as _i1042;
import '../feature/reels/data/datasources/ireels_remote_datasource.dart'
    as _i737;
import '../feature/reels/data/datasources/reels_remote_datasource.dart'
    as _i914;
import '../feature/reels/domain/repositories/ireels_repository.dart' as _i864;
import '../feature/reels/domain/repositories/reels_repository.dart' as _i989;
import '../feature/reels/domain/usecase/get_more_reels_usecase.dart' as _i966;
import '../feature/reels/domain/usecase/get_reels_usecase.dart' as _i850;
import '../feature/reels/presentation/cubit/reels_cubit.dart' as _i23;
import '../feature/scouting_posts/data/datasource/iscouting_posts_remote.dart'
    as _i462;
import '../feature/scouting_posts/domain/repository/iscouting_posts_repository.dart'
    as _i524;
import '../feature/scouting_posts/domain/repository/scouting_posts_repository.dart'
    as _i142;
import '../feature/scouting_posts/domain/usecase/get_post_by_id_usecase.dart'
    as _i338;
import '../feature/scouting_posts/domain/usecase/get_posts_usecase.dart'
    as _i622;
import '../feature/settings/presentation/state_m/my_profile/my_profile_cubit.dart'
    as _i525;
import '../feature/splash/presentation/state_m/splash_cubit.dart' as _i12;
import 'modules/logger_module.dart' as _i205;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    gh.factory<_i699.NoopBackgroundApi>(() => _i699.NoopBackgroundApi());
    gh.factory<_i591.DbProvider>(() => _i591.DbProvider());
    gh.singleton<_i821.GenericBackgroundService>(
        () => _i821.GenericBackgroundService());
    gh.singleton<_i81.IsolateBackgroundService>(
        () => _i81.IsolateBackgroundService());
    gh.singleton<_i1028.SessionData>(() => _i1028.SessionData());
    gh.singleton<_i822.BackgroundChatService>(
        () => _i822.BackgroundChatService());
    gh.singleton<_i3.NotificationAnalyticsService>(
        () => _i3.NotificationAnalyticsService());
    gh.singleton<_i975.NotificationPreferencesService>(
        () => _i975.NotificationPreferencesService());
    gh.singleton<_i570.NotificationService>(() => _i570.NotificationService());
    gh.singleton<_i142.ReferralSharingService>(
        () => _i142.ReferralSharingService());
    gh.lazySingleton<_i796.NavigationService>(() => _i796.NavigationService());
    gh.lazySingleton<_i45.NavigationRoute>(() => _i45.NavigationRoute());
    gh.lazySingleton<_i1004.HttpClient>(() => _i1004.HttpClient());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.factory<_i737.IReelsRemoteSource>(() => _i914.ReelsRemoteSource());
    gh.factory<_i753.ICommentsRemoteSource>(() => _i753.CommentsRemoteSource());
    gh.factory<_i494.IAccountRemoteSource>(() => _i494.AccountRemoteSource());
    gh.factory<_i462.IScoutingPostsRemoteSource>(
        () => _i462.ScoutingPostsRemoteSource());
    gh.singleton<_i740.ISocketService>(() => _i593.SocketService(
          gh<_i974.Logger>(),
          gh<_i570.NotificationService>(),
        ));
    gh.factory<_i228.IUserProfileRemoteSource>(
        () => _i228.UserProfileRemoteSource());
    gh.factory<_i177.IPostsRemoteSource>(() => _i524.PostsRemoteSource());
    gh.factory<_i591.ILikesRemoteSource>(() => _i591.LikesRemoteSource());
    gh.singleton<_i798.GenericCacheService>(
        () => _i798.GenericCacheService(gh<_i591.DbProvider>()));
    gh.singleton<_i377.AuthService>(
        () => _i377.AuthService(gh<_i740.ISocketService>()));
    gh.factory<_i864.IReelsRepository>(
        () => _i989.ReelsRepository(gh<_i737.IReelsRemoteSource>()));
    gh.factory<_i17.IUserProfileRepository>(() =>
        _i517.UserProfileRepository(gh<_i228.IUserProfileRemoteSource>()));
    gh.singleton<_i788.BackgroundTasksRegistrar>(
        () => _i788.BackgroundTasksRegistrar(gh<_i699.NoopBackgroundApi>()));
    gh.factory<_i53.IPostsRepository>(
        () => _i663.PostsRepository(gh<_i177.IPostsRemoteSource>()));
    gh.singleton<_i714.GetUserProfileUseCase>(
        () => _i714.GetUserProfileUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserProfileByUsernameUseCase>(() =>
        _i714.GetUserProfileByUsernameUseCase(
            gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.FollowUserUseCase>(
        () => _i714.FollowUserUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.BlockUserUseCase>(
        () => _i714.BlockUserUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.ReportUserUseCase>(
        () => _i714.ReportUserUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.PokeUserUseCase>(
        () => _i714.PokeUserUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.AddToFamilyUseCase>(
        () => _i714.AddToFamilyUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserPostsUseCase>(
        () => _i714.GetUserPostsUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserPhotosUseCase>(
        () => _i714.GetUserPhotosUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserFollowersUseCase>(
        () => _i714.GetUserFollowersUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserFollowingUseCase>(
        () => _i714.GetUserFollowingUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserPagesUseCase>(
        () => _i714.GetUserPagesUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i714.GetUserGroupsUseCase>(
        () => _i714.GetUserGroupsUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i855.UpdateAvatarUseCase>(
        () => _i855.UpdateAvatarUseCase(gh<_i17.IUserProfileRepository>()));
    gh.singleton<_i13.UpdateCoverUseCase>(
        () => _i13.UpdateCoverUseCase(gh<_i17.IUserProfileRepository>()));
    gh.factory<_i834.IPlayerRepository>(
        () => _i834.PlayerRepository(gh<_i495.IPlayerRemoteDatasource>()));
    gh.singleton<_i141.ICommentsRepository>(
        () => _i1000.CommentsRepository(gh<_i753.ICommentsRemoteSource>()));
    gh.singleton<_i234.CreateCommentUsecase>(
        () => _i234.CreateCommentUsecase(gh<_i141.ICommentsRepository>()));
    gh.singleton<_i109.GetPostCommentsUsecase>(
        () => _i109.GetPostCommentsUsecase(gh<_i141.ICommentsRepository>()));
    gh.singleton<_i597.GetUserCommentsUsecase>(
        () => _i597.GetUserCommentsUsecase(gh<_i141.ICommentsRepository>()));
    gh.singleton<_i505.GenericBackgroundIntegrationTest>(() =>
        _i505.GenericBackgroundIntegrationTest(
            gh<_i821.GenericBackgroundService>()));
    gh.singleton<_i166.TestGenericService>(
        () => _i166.TestGenericService(gh<_i821.GenericBackgroundService>()));
    gh.factory<_i462.IAccountRepository>(
        () => _i462.AccountRepository(gh<_i494.IAccountRemoteSource>()));
    gh.singleton<_i1043.GetMeUsecase>(
        () => _i1043.GetMeUsecase(gh<_i462.IAccountRepository>()));
    gh.singleton<_i813.ListMembersUsecase>(
        () => _i813.ListMembersUsecase(gh<_i462.IAccountRepository>()));
    gh.singleton<_i267.MemberLoginUsecase>(
        () => _i267.MemberLoginUsecase(gh<_i462.IAccountRepository>()));
    gh.singleton<_i314.MemberRegisterUsecase>(
        () => _i314.MemberRegisterUsecase(gh<_i462.IAccountRepository>()));
    gh.singleton<_i741.ShowMemberUsecase>(
        () => _i741.ShowMemberUsecase(gh<_i462.IAccountRepository>()));
    gh.singleton<_i672.UpdateProfileUsecase>(
        () => _i672.UpdateProfileUsecase(gh<_i462.IAccountRepository>()));
    gh.factory<_i525.MyProfileCubit>(() => _i525.MyProfileCubit(
          getUserProfileUseCase: gh<_i714.GetUserProfileUseCase>(),
          updateAvatarUseCase: gh<_i855.UpdateAvatarUseCase>(),
          updateCoverUseCase: gh<_i13.UpdateCoverUseCase>(),
          authService: gh<_i377.AuthService>(),
        ));
    gh.singleton<_i524.IScoutingPostsRepository>(() =>
        _i142.ScoutingPostsRepository(gh<_i462.IScoutingPostsRemoteSource>()));
    gh.factory<_i12.SplashCubit>(
        () => _i12.SplashCubit(gh<_i377.AuthService>()));
    gh.factory<_i805.GetPostsUsecase>(
        () => _i805.GetPostsUsecase(gh<_i53.IPostsRepository>()));
    gh.factory<_i316.GetPostByIdUsecase>(
        () => _i316.GetPostByIdUsecase(gh<_i53.IPostsRepository>()));
    gh.singleton<_i966.GetMoreReelsUsecase>(
        () => _i966.GetMoreReelsUsecase(gh<_i864.IReelsRepository>()));
    gh.singleton<_i850.GetReelsUsecase>(
        () => _i850.GetReelsUsecase(gh<_i864.IReelsRepository>()));
    gh.singleton<_i1020.ILikesRepository>(
        () => _i548.LikesRepository(gh<_i591.ILikesRemoteSource>()));
    gh.factory<_i1042.UserProfileCubit>(() => _i1042.UserProfileCubit(
          getUserProfileUseCase: gh<_i714.GetUserProfileUseCase>(),
          getUserProfileByUsernameUseCase:
              gh<_i714.GetUserProfileByUsernameUseCase>(),
          followUserUseCase: gh<_i714.FollowUserUseCase>(),
          blockUserUseCase: gh<_i714.BlockUserUseCase>(),
          reportUserUseCase: gh<_i714.ReportUserUseCase>(),
          pokeUserUseCase: gh<_i714.PokeUserUseCase>(),
          addToFamilyUseCase: gh<_i714.AddToFamilyUseCase>(),
          getUserPostsUseCase: gh<_i714.GetUserPostsUseCase>(),
          getUserPhotosUseCase: gh<_i714.GetUserPhotosUseCase>(),
          getUserFollowersUseCase: gh<_i714.GetUserFollowersUseCase>(),
          getUserFollowingUseCase: gh<_i714.GetUserFollowingUseCase>(),
          getUserPagesUseCase: gh<_i714.GetUserPagesUseCase>(),
          getUserGroupsUseCase: gh<_i714.GetUserGroupsUseCase>(),
        ));
    gh.singleton<_i805.GetPostLikesUsecase>(
        () => _i805.GetPostLikesUsecase(gh<_i1020.ILikesRepository>()));
    gh.singleton<_i779.GetUserLikesUsecase>(
        () => _i779.GetUserLikesUsecase(gh<_i1020.ILikesRepository>()));
    gh.singleton<_i686.ToggleLikeUsecase>(
        () => _i686.ToggleLikeUsecase(gh<_i1020.ILikesRepository>()));
    gh.factory<_i23.ReelsCubit>(() => _i23.ReelsCubit(
          getReelsUsecase: gh<_i850.GetReelsUsecase>(),
          getMoreReelsUsecase: gh<_i966.GetMoreReelsUsecase>(),
        ));
    gh.singleton<_i622.GetPostsUsecase>(
        () => _i622.GetPostsUsecase(gh<_i524.IScoutingPostsRepository>()));
    gh.singleton<_i338.GetPostByIdUsecase>(
        () => _i338.GetPostByIdUsecase(gh<_i524.IScoutingPostsRepository>()));
    gh.factory<_i319.PostsCubit>(() => _i319.PostsCubit(
          getPostsUsecase: gh<_i805.GetPostsUsecase>(),
          getPostByIdUsecase: gh<_i316.GetPostByIdUsecase>(),
        ));
    return this;
  }
}

class _$LoggerModule extends _i205.LoggerModule {}
