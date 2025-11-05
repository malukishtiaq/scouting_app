part of 'iaccount_repository.dart';

@Injectable(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final IAccountRemoteSource remoteDataSource;

  AccountRepository(this.remoteDataSource);

  // ========== SCOUTING API ==========

  @override
  Future<Result<AppErrors, AuthResponseEntity>> memberRegister(
      ScoutingRegisterParam param) async {
    return execute<AuthResponseModel, AuthResponseEntity>(
      remoteResult: await remoteDataSource.memberRegister(param),
    );
  }

  @override
  Future<Result<AppErrors, AuthResponseEntity>> memberLogin(
      ScoutingLoginParam param) async {
    final result = execute<AuthResponseModel, AuthResponseEntity>(
      remoteResult: await remoteDataSource.memberLogin(param),
    );

    // If login is successful, trigger background services immediately
    if (result.hasDataOnly) {
      try {
        // Re-enabled: Background services for normal operation
        _triggerBackgroundServices();
        print('✅ Background services started after successful login');
      } catch (e) {
        // Don't fail login if background services fail to start
        print('⚠️ Background services failed to start: $e');
      }
    }

    return result;
  }

  /// Trigger background services in isolate after successful login
  void _triggerBackgroundServices() {
    // Use a microtask to ensure this runs after the current execution
    // and doesn't block the login response
    Future.microtask(() async {
      try {
        // Access the service through the global getIt instance
        final isolateService = getIt<IsolateBackgroundService>();

        print(
            '🚀 Login successful! Starting background services in isolates...');

        // In development mode, stop existing isolates before starting new ones
        // This ensures fresh isolates on hot reload
        isolateService.stopAllIsolates();

        // Add a small delay to ensure isolates are fully stopped
        await Future.delayed(const Duration(milliseconds: 100));

        // Start all background services immediately (non-blocking)
        isolateService.startCoreServicesInitialization();
        // Newsfeed background service is now handled by the repository method
        isolateService.startTrendingServicesInitialization();

        // Register periodic background tasks (including chat list sync)
        try {
          final registrar = getIt<BackgroundTasksRegistrar>();
          final userId = LocalStorage.memberID.toString();
          await registrar.registerCoreTasks(userId);
        } catch (e) {
          print('⚠️ Failed to register background tasks: $e');
        }

        print('✅ All background services started successfully!');
      } catch (e) {
        print('❌ Failed to start background services: $e');
      }
    });
  }

  @override
  Future<Result<AppErrors, MemberProfileEntity>> getMe(GetMeParam param) async {
    return execute(
      remoteResult: await remoteDataSource.getMe(param),
    );
  }

  @override
  Future<Result<AppErrors, UpdateProfileResponseEntity>> updateProfile(
      UpdateProfileParam param) async {
    return execute(
      remoteResult: await remoteDataSource.updateProfile(param),
    );
  }

  @override
  Future<Result<AppErrors, MembersListEntity>> listMembers(
      ListMembersParam param) async {
    return execute(
      remoteResult: await remoteDataSource.listMembers(param),
    );
  }

  @override
  Future<Result<AppErrors, MemberProfileEntity>> showMember(
      ShowMemberParam param) async {
    return execute(
      remoteResult: await remoteDataSource.showMember(param),
    );
  }
}
