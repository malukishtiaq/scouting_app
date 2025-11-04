import 'package:injectable/injectable.dart';
import '../common/local_storage.dart';
import '../providers/session_data.dart';
import '../../di/service_locator.dart';
import '../../feature/profile/domain/usecases/get_user_profile_usecase.dart';
import '../../feature/profile/data/request/param/user_profile_param.dart';
import '../socket/socket_service_interface.dart';
import '../../app_settings.dart';
import 'background_chat_service.dart';

@singleton
class AuthService {
  final ISocketService _socketService;

  AuthService(this._socketService);

  /// Check if user has valid stored credentials and auto-login
  Future<bool> tryAutoLogin() async {
    try {
      // Check if we have a stored token
      final storedToken = LocalStorage.authToken;
      final storedUserId = LocalStorage.memberID;

      if (storedToken == null || storedToken.isEmpty || storedUserId <= 0) {
        return false;
      }

      // Set session data immediately for UI responsiveness
      final sessionData = getIt<SessionData>();
      sessionData.token = storedToken;
      sessionData.userId = storedUserId;

      // Fetch user profile data in background - don't await
      _fetchAndStoreUserProfile(storedUserId).catchError((e) {
        print('Background user profile fetch failed: $e');
      });

      // Connect socket if using Socket.IO (like Xamarin) - do in background
      if (AppSettings.connectionType == SocketConnectionType.socket) {
        print('🔌 Auto-login: Connecting to socket server...');
        _initializeSocket(storedToken, storedUserId).catchError((e) {
          print('⚠️ Auto-login socket connection failed: $e');
          // Don't fail login if socket fails - it's optional
        });
      } else {
        // Start background polling service for API mode (like Xamarin)
        print('🔄 Auto-login: Starting background polling service...');
        final backgroundService = getIt<BackgroundChatService>();
        backgroundService.startPolling().catchError((e) {
          print('⚠️ Auto-login background polling failed: $e');
          // Don't fail login if polling fails - it's optional
        });
      }

      // Validate token with server (optional - can be done in background)
      // For now, we'll trust the stored token
      // TODO: Implement server-side token validation

      return true;
    } catch (e) {
      // If anything fails, clear invalid data and return false
      await clearSession();
      return false;
    }
  }

  /// Validate token with server (for future implementation)
  Future<bool> validateTokenWithServer(String token) async {
    try {
      // This would call a validate token API endpoint
      // For now, we'll assume tokens are valid if they exist
      //
      // final validateParam = ValidateTokenParam(accessToken: token);
      // final result = await getIt<ValidateTokenUsecase>()(validateParam);
      //
      // return result.isRight();

      return true; // Placeholder
    } catch (e) {
      return false;
    }
  }

  /// Check if user is currently logged in
  bool get isLoggedIn {
    final sessionData = getIt<SessionData>();
    final hasSessionToken = sessionData.token?.isNotEmpty ?? false;
    final hasStoredToken = LocalStorage.hasToken;

    return hasSessionToken && hasStoredToken;
  }

  /// Clear all session data and stored credentials
  Future<void> clearSession() async {
    try {
      // Disconnect socket if using Socket.IO (like Xamarin)
      if (AppSettings.connectionType == SocketConnectionType.socket) {
        print('🔌 Disconnecting socket on logout...');
        await _socketService.disconnect();
      }

      // Clear session data
      final sessionData = getIt<SessionData>();
      sessionData.token = null;
      sessionData.userId = null;

      // Clear stored data
      await LocalStorage.deleteToken();
      await LocalStorage.deleteMemberId();

      // Clear smart lock credentials
      // await SmartLockService.clearStoredCredentials();
    } catch (e) {
      // Log error but don't throw - logout should always succeed
      print('Error clearing session: $e');
    }
  }

  /// Setup session after successful login
  Future<void> setupSession({
    required String accessToken,
    required int userId,
  }) async {
    try {
      // Set session data
      final sessionData = getIt<SessionData>();
      sessionData.token = accessToken;
      sessionData.userId = userId;

      // Persist to storage
      await LocalStorage.persistToken(accessToken);
      await LocalStorage.persistMemberId(userId);

      // Fetch user profile data and store in session
      await _fetchAndStoreUserProfile(userId);

      // Login to OneSignal (matches Xamarin OneSignal.Login)
      try {
        print('🔔 Logging in to OneSignal...');
      } catch (e) {
        print('⚠️ OneSignal not available: $e');
        // Continue - OneSignal is optional
      }

      // Connect socket if using Socket.IO (like Xamarin)
      if (AppSettings.connectionType == SocketConnectionType.socket) {
        print('🔌 Connecting to socket server on login...');
        await _initializeSocket(accessToken, userId);
      } else {
        // Start background polling service for API mode (like Xamarin)
        print('🔄 Starting background polling service...');
        final backgroundService = getIt<BackgroundChatService>();
        await backgroundService.startPolling();
      }
    } catch (e) {
      print('Error setting up session: $e');
      rethrow;
    }
  }

  /// Initialize socket connection (like Xamarin's InitStart)
  Future<void> _initializeSocket(String accessToken, int userId) async {
    try {
      // Connect to socket server
      await _socketService.connect();

      // Wait longer for connection to establish
      await Future.delayed(const Duration(milliseconds: 2000));

      // Check connection status with retries
      int retryCount = 0;
      const maxRetries = 3;

      while (!_socketService.isConnected && retryCount < maxRetries) {
        retryCount++;
        print('🔄 Socket connection attempt $retryCount/$maxRetries...');
        await Future.delayed(const Duration(milliseconds: 1000));
      }

      // Join socket room with username and access token
      if (_socketService.isConnected) {
        final sessionData = getIt<SessionData>();
        final username = sessionData.userProfile?.username ?? userId.toString();

        await _socketService.join(username, accessToken);
        print('✅ Socket connected and joined successfully');
      } else {
        print(
            '⚠️ Socket connection failed after $maxRetries attempts - will retry later');
      }
    } catch (e) {
      print('❌ Socket initialization error: $e');
      // Don't throw - socket is optional, login should still succeed
    }
  }

  /// Fetch user profile data and store in session
  Future<void> _fetchAndStoreUserProfile(int userId) async {
    try {
      final getUserProfileUseCase = getIt<GetUserProfileUseCase>();
      final param = GetUserProfileParam(userId: userId.toString());

      final result = await getUserProfileUseCase(param);

      result.pick(
        onData: (response) {
          // Store user profile in session data
          final sessionData = getIt<SessionData>();
          sessionData.userProfile = response.userData;
          print('✅ User profile loaded: ${response.userData.username}');
        },
        onError: (error) {
          print('❌ Failed to load user profile: $error');
          // Don't throw error - session setup should still succeed
        },
      );
    } catch (e) {
      print('❌ Error fetching user profile: $e');
      // Don't throw error - session setup should still succeed
    }
  }

  /// Get current user ID
  int? get currentUserId {
    final sessionData = getIt<SessionData>();
    return sessionData.userId ?? LocalStorage.memberID;
  }

  /// Get current access token
  String? get currentToken {
    final sessionData = getIt<SessionData>();
    return sessionData.token ?? LocalStorage.authToken;
  }

  /// Get current username
  String? get currentUsername {
    final sessionData = getIt<SessionData>();
    return sessionData.userProfile?.username ?? sessionData.userId?.toString();
  }
}
