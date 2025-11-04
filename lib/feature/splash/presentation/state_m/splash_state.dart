part of 'splash_cubit.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  final String message;

  const SplashLoading(this.message);
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);
}

class SplashNavigateToLogin extends SplashState {
  const SplashNavigateToLogin();
}

class SplashNavigateToHome extends SplashState {
  const SplashNavigateToHome();
}
