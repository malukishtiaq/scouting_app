import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/auth_service.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final AuthService _authService;

  SplashCubit(this._authService) : super(const SplashInitial());

  /// Check for existing login and navigate accordingly
  Future<void> checkAutoLogin() async {
    try {
      emit(const SplashLoading('Checking login status...'));

      // Try to auto-login with stored credentials immediately
      final isLoggedIn = await _authService.tryAutoLogin();

      if (isLoggedIn) {
        emit(const SplashLoading('Welcome back!'));
        // Navigate to home immediately
        emit(const SplashNavigateToHome());
      } else {
        emit(const SplashLoading('Please sign in'));
        // Navigate to login immediately
        emit(const SplashNavigateToLogin());
      }
    } catch (e) {
      emit(SplashError('Failed to check login status: ${e.toString()}'));

      // Auto-retry after error - reduced delay
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const SplashNavigateToLogin());
    }
  }

  /// Handle logout from any screen
  Future<void> logout() async {
    try {
      emit(const SplashLoading('Signing out...'));

      await _authService.clearSession();

      // Navigate to login
      emit(const SplashNavigateToLogin());
    } catch (e) {
      emit(SplashError('Failed to sign out: ${e.toString()}'));
    }
  }
}
