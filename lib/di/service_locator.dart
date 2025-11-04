import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

import '../core/background/isolate_background_service.dart';
import '../core/data/db/db_provider.dart';
import '../core/data/repositories/job_state_repository.dart';
import '../core/services/session_service.dart';
import '../core/data/repositories/settings_repository.dart';
import '../core/data/repositories/gifts_repository.dart';
import '../core/data/repositories/profile_repository.dart';
import '../core/data/repositories/contacts_repository.dart';
import '../core/data/repositories/pins_repository.dart';
import '../core/data/repositories/community_repository.dart';
import '../core/data/repositories/articles_repository.dart';
import '../core/services/settings_service.dart';
import '../core/services/location_service.dart';
import '../core/data/cache/generic_cache_service.dart';
// Settings feature imports
import '../feature/settings/domain/repositories/settings_repository.dart'
    as feature_settings;
import '../feature/settings/domain/repositories/isettings_repository.dart';
import '../feature/settings/data/datasources/isettings_remote_source.dart';
import '../feature/settings/data/datasources/settings_remote_source.dart';
import '../feature/settings/domain/usecases/get_user_preferences_usecase.dart';
import '../feature/settings/domain/usecases/save_user_preferences_usecase.dart';
import '../feature/settings/domain/usecases/update_general_settings_usecase.dart';
import '../feature/settings/domain/usecases/update_privacy_settings_usecase.dart';
import '../feature/settings/domain/usecases/update_notification_settings_usecase.dart';
import '../feature/settings/presentation/state/settings_cubit.dart';
import '../feature/profile/domain/usecases/get_user_profile_usecase.dart';
import '../feature/profile/domain/usecases/update_avatar_usecase.dart';
import '../feature/profile/domain/usecases/update_cover_usecase.dart';
import '../feature/profile/domain/repositories/iuser_profile_repository.dart';
import '../core/services/gifts_service.dart';
import '../core/services/user_service.dart';
import '../core/services/community_service.dart';
import '../core/services/chat_service.dart';
import '../core/services/articles_service.dart';
import '../core/services/cache_service.dart';
// Socket service imports
// Ads services imports removed - handled by @lazySingleton annotations
import '../feature/video_player_service/services/video_player_service_provider.dart';
// AI Content feature imports - handled by @injectable annotations in getIt.init()
// Notifications feature imports

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureInjection() async {
  print('🚀 Starting configureInjection...');

  // Initialize all injectable dependencies FIRST using the generated extension method
  getIt.init();
  print('✅ Injectable dependencies initialized');

  // Core background and DB scaffolding - register these FIRST
  // Note: IsolateBackgroundService and DbProvider are now handled by injectable annotations
  getIt.registerLazySingleton<IJobStateRepository>(
      () => JobStateRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<SessionService>(() => SessionService(
        isolateService: getIt<IsolateBackgroundService>(),
        dbProvider: getIt<DbProvider>(),
      ));

  // Core data repositories
  getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<GiftsRepository>(
      () => GiftsRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<ContactsRepository>(
      () => ContactsRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<PinsRepository>(
      () => PinsRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<CommunityRepository>(
      () => CommunityRepository(getIt<DbProvider>()));
  getIt.registerLazySingleton<ArticlesRepository>(
      () => ArticlesRepository(getIt<DbProvider>()));

  // Core services
  getIt.registerLazySingleton<SettingsService>(
      () => SettingsService(getIt<SettingsRepository>()));
  getIt.registerLazySingleton<GiftsService>(
      () => GiftsService(getIt<GiftsRepository>()));
  getIt.registerLazySingleton<UserService>(() =>
      UserService(getIt<ProfileRepository>(), getIt<ContactsRepository>()));
  getIt.registerLazySingleton<CommunityService>(
      () => CommunityService(getIt<CommunityRepository>()));
  getIt.registerLazySingleton<ChatService>(
      () => ChatService(getIt<PinsRepository>()));
  getIt.registerLazySingleton<ArticlesService>(
      () => ArticlesService(getIt<ArticlesRepository>()));
  getIt.registerLazySingleton<CacheService>(() => CacheService());

  // Location service - create Dio instance directly since it's not in GetIt
  if (!getIt.isRegistered<LocationService>()) {
    getIt.registerLazySingleton<LocationService>(
        () => LocationService(dio: Dio()));
  }

  // Notification services and use cases are auto-registered via @singleton/@injectable annotations

  // Ads services - All registered via @lazySingleton annotations in getIt.init()

  // NewsFeed Cache Services are registered via injectable in getIt.init()

  // Generic Cache Service - Register manually since build_runner may not have been run
  if (!getIt.isRegistered<GenericCacheService>()) {
    getIt.registerLazySingleton<GenericCacheService>(
        () => GenericCacheService(getIt<DbProvider>()));
  }

  // Register Video Player Service
  VideoPlayerServiceProvider.register();

  // Settings feature registrations
  getIt.registerLazySingleton<ISettingsRemoteSource>(
      () => SettingsRemoteSource());
  getIt.registerLazySingleton<ISettingsRepository>(() =>
      feature_settings.SettingsRepository(getIt<ISettingsRemoteSource>()));

  // Settings use cases
  getIt.registerLazySingleton<GetUserPreferencesUseCase>(
      () => GetUserPreferencesUseCase(getIt<ISettingsRepository>()));
  getIt.registerLazySingleton<SaveUserPreferencesUseCase>(
      () => SaveUserPreferencesUseCase(getIt<ISettingsRepository>()));
  getIt.registerLazySingleton<UpdateGeneralSettingsUseCase>(
      () => UpdateGeneralSettingsUseCase(getIt<ISettingsRepository>()));
  getIt.registerLazySingleton<UpdatePrivacySettingsUseCase>(
      () => UpdatePrivacySettingsUseCase(getIt<ISettingsRepository>()));
  getIt.registerLazySingleton<UpdateNotificationSettingsUseCase>(
      () => UpdateNotificationSettingsUseCase(getIt<ISettingsRepository>()));

  // Following use cases - All registered via @singleton annotations

  // Settings cubit
  getIt.registerLazySingleton<SettingsCubit>(() => SettingsCubit(
        getUserPreferencesUseCase: getIt<GetUserPreferencesUseCase>(),
        saveUserPreferencesUseCase: getIt<SaveUserPreferencesUseCase>(),
        updatePrivacySettingsUseCase: getIt<UpdatePrivacySettingsUseCase>(),
        updateNotificationSettingsUseCase:
            getIt<UpdateNotificationSettingsUseCase>(),
        updateGeneralSettingsUseCase: getIt<UpdateGeneralSettingsUseCase>(),
      ));

  // My Profile cubit dependencies - register manually if not auto-registered
  if (!getIt.isRegistered<GetUserProfileUseCase>()) {
    getIt.registerLazySingleton<GetUserProfileUseCase>(
        () => GetUserProfileUseCase(getIt<IUserProfileRepository>()));
  }
  if (!getIt.isRegistered<UpdateAvatarUseCase>()) {
    getIt.registerLazySingleton<UpdateAvatarUseCase>(
        () => UpdateAvatarUseCase(getIt<IUserProfileRepository>()));
  }
  if (!getIt.isRegistered<UpdateCoverUseCase>()) {
    getIt.registerLazySingleton<UpdateCoverUseCase>(
        () => UpdateCoverUseCase(getIt<IUserProfileRepository>()));
  }

  // My Profile cubit is auto-registered via @injectable annotation

  // All feature registrations are now handled by the generated code
}

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
