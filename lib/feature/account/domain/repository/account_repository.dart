part of 'iaccount_repository.dart';

@Injectable(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final IAccountRemoteSource remoteDataSource;

  AccountRepository(this.remoteDataSource);

  @override
  Future<Result<AppErrors, AuthResponseEntity>> login(LoginParam param) async {
    final result = execute(
      remoteResult: await remoteDataSource.login(param),
    );

    // Cast the result to the correct type
    final authResult = Result<AppErrors, AuthResponseEntity>(
      data: result.data as AuthResponseEntity?,
      error: result.error,
    );

    // If login is successful, trigger background services immediately
    if (authResult.hasDataOnly) {
      try {
        // Re-enabled: Background services for normal operation
        _triggerBackgroundServices();
        print('✅ Background services started after successful login');
      } catch (e) {
        // Don't fail login if background services fail to start
        print('⚠️ Background services failed to start: $e');
      }
    }

    return authResult;
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
  Future<Result<AppErrors, AuthResponseEntity>> resgister(
      RegisterParam param) async {
    return execute(
      remoteResult: await remoteDataSource.resgister(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteAccount(
      DeleteAccountParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.deleteAccount(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> resetPassword(
      ResetPasswordParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.resetPassword(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> resendCode(
      ResendCodeParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.resendCode(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> replacePassword(
      ReplacePasswordParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.replacePassword(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> resendEmail(
      ResendEmailParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.resendEmail(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> sendCodeTwoFactor(
      SendCodeTwoFactorParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.sendCodeTwoFactor(param),
    );
  }

  @override
  Future<Result<AppErrors, AuthResponseEntity>> twoFactor(
      TwoFactorParam param) async {
    return execute(
      remoteResult: await remoteDataSource.twoFactor(param),
    );
  }

  @override
  Future<Result<AppErrors, AuthResponseEntity>> verifyAccount(
      VerifyAccountParam param) async {
    return execute(
      remoteResult: await remoteDataSource.verifyAccount(param),
    );
  }

  @override
  Future<Result<AppErrors, AuthResponseEntity>> socialLogin(
      SocialLoginParam param) async {
    return execute(
      remoteResult: await remoteDataSource.socialLogin(param),
    );
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> logout(LogoutParam param) async {
    return executeForNoEntity(
      remoteResult: await remoteDataSource.logout(param),
    );
  }
}
