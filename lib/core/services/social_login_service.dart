import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Social Login Service - Demo Mode Implementation
/// This service provides a complete social login implementation that can be
/// easily connected to real Google/Facebook APIs when configurations are available.
class SocialLoginService {
  static const String _demoModeKey = 'social_login_demo_mode';
  static const String _lastSocialLoginKey = 'last_social_login_provider';
  static const String _demoUserDataKey = 'demo_social_user_data';

  /// Check if demo mode is enabled
  static Future<bool> isDemoMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_demoModeKey) ?? true; // Default to demo mode
  }

  /// Set demo mode status
  static Future<void> setDemoMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_demoModeKey, enabled);
  }

  /// Google Sign In - Demo Mode
  static Future<SocialLoginResult> signInWithGoogle() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Demo user data for Google
      const demoUser = SocialUserData(
        provider: SocialProvider.google,
        userId: 'demo_google_12345',
        email: 'demo.user@gmail.com',
        displayName: 'Demo Google User',
        firstName: 'Demo',
        lastName: 'User',
        profilePicture: 'https://handshakes4u.com/upload/photos/d-avatar.jpg',
        accessToken: 'demo_google_access_token_12345',
        refreshToken: 'demo_google_refresh_token_12345',
        isEmailVerified: true,
        locale: 'en_US',
        timezone: 'UTC',
      );

      // Store demo user data
      await _storeDemoUserData(demoUser);
      await _setLastSocialLoginProvider(SocialProvider.google);

      return SocialLoginResult.success(demoUser);
    } catch (e) {
      return SocialLoginResult.failure(
        SocialLoginError(
          code: 'DEMO_GOOGLE_ERROR',
          message: 'Demo Google login failed: $e',
          provider: SocialProvider.google,
        ),
      );
    }
  }

  /// Facebook Sign In - Demo Mode
  static Future<SocialLoginResult> signInWithFacebook() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Demo user data for Facebook
      const demoUser = SocialUserData(
        provider: SocialProvider.facebook,
        userId: 'demo_facebook_67890',
        email: 'demo.user@facebook.com',
        displayName: 'Demo Facebook User',
        firstName: 'Demo',
        lastName: 'Facebook',
        profilePicture: 'https://handshakes4u.com/upload/photos/d-avatar.jpg',
        accessToken: 'demo_facebook_access_token_67890',
        refreshToken: 'demo_facebook_refresh_token_67890',
        isEmailVerified: true,
        locale: 'en_US',
        timezone: 'UTC',
      );

      // Store demo user data
      await _storeDemoUserData(demoUser);
      await _setLastSocialLoginProvider(SocialProvider.facebook);

      return SocialLoginResult.success(demoUser);
    } catch (e) {
      return SocialLoginResult.failure(
        SocialLoginError(
          code: 'DEMO_FACEBOOK_ERROR',
          message: 'Demo Facebook login failed: $e',
          provider: SocialProvider.facebook,
        ),
      );
    }
  }

  /// Apple Sign In - Demo Mode
  static Future<SocialLoginResult> signInWithApple() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Demo user data for Apple
      const demoUser = SocialUserData(
        provider: SocialProvider.apple,
        userId: 'demo_apple_11111',
        email: 'demo.user@icloud.com',
        displayName: 'Demo Apple User',
        firstName: 'Demo',
        lastName: 'Apple',
        profilePicture: 'https://handshakes4u.com/upload/photos/d-avatar.jpg',
        accessToken: 'demo_apple_access_token_11111',
        refreshToken: 'demo_apple_refresh_token_11111',
        isEmailVerified: true,
        locale: 'en_US',
        timezone: 'UTC',
      );

      // Store demo user data
      await _storeDemoUserData(demoUser);
      await _setLastSocialLoginProvider(SocialProvider.apple);

      return SocialLoginResult.success(demoUser);
    } catch (e) {
      return SocialLoginResult.failure(
        SocialLoginError(
          code: 'DEMO_APPLE_ERROR',
          message: 'Demo Apple login failed: $e',
          provider: SocialProvider.apple,
        ),
      );
    }
  }

  /// Sign Out from social login
  static Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_demoUserDataKey);
      await prefs.remove(_lastSocialLoginKey);
    } catch (e) {
      // Silently fail
    }
  }

  /// Get last social login provider
  static Future<SocialProvider?> getLastSocialLoginProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final providerString = prefs.getString(_lastSocialLoginKey);
    if (providerString != null) {
      return SocialProvider.values.firstWhere(
        (p) => p.name == providerString,
        orElse: () => SocialProvider.google,
      );
    }
    return null;
  }

  /// Get stored demo user data
  static Future<SocialUserData?> getDemoUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_demoUserDataKey);
    if (userDataString != null) {
      try {
        // Parse stored user data (simplified for demo)
        final data = userDataString.split('|');
        if (data.length >= 11) {
          return SocialUserData(
            provider: SocialProvider.values.firstWhere(
              (p) => p.name == data[0],
              orElse: () => SocialProvider.google,
            ),
            userId: data[1],
            email: data[2],
            displayName: data[3],
            firstName: data[4],
            lastName: data[5],
            profilePicture: data[6],
            accessToken: data[7],
            refreshToken: data[8],
            isEmailVerified: data[9] == 'true',
            locale: data[10],
            timezone: data.length > 11 ? data[11] : 'UTC',
          );
        }
      } catch (e) {
        // Return null if parsing fails
      }
    }
    return null;
  }

  /// Check if user is signed in via social login
  static Future<bool> isSignedIn() async {
    final userData = await getDemoUserData();
    return userData != null;
  }

  /// Get current user data
  static Future<SocialUserData?> getCurrentUser() async {
    return await getDemoUserData();
  }

  /// Refresh access token (demo mode - returns same token)
  static Future<String?> refreshAccessToken() async {
    final userData = await getDemoUserData();
    return userData?.accessToken;
  }

  /// Store demo user data
  static Future<void> _storeDemoUserData(SocialUserData user) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = [
      user.provider.name,
      user.userId,
      user.email,
      user.displayName,
      user.firstName,
      user.lastName,
      user.profilePicture,
      user.accessToken,
      user.refreshToken,
      user.isEmailVerified.toString(),
      user.locale,
      user.timezone,
    ].join('|');

    await prefs.setString(_demoUserDataKey, userDataString);
  }

  /// Set last social login provider
  static Future<void> _setLastSocialLoginProvider(
      SocialProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSocialLoginKey, provider.name);
  }

  /// Convert social user data to login parameters
  static Map<String, dynamic> convertToLoginParams(SocialUserData user) {
    return {
      'social_provider': user.provider.name,
      'social_user_id': user.userId,
      'social_access_token': user.accessToken,
      'email': user.email,
      'username': user.displayName,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'profile_picture': user.profilePicture,
      'is_email_verified': user.isEmailVerified,
      'locale': user.locale,
      'timezone': user.timezone,
    };
  }
}

/// Social Login Provider Enum
enum SocialProvider {
  google,
  facebook,
  apple,
}

/// Social User Data Model
class SocialUserData {
  final SocialProvider provider;
  final String userId;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final String accessToken;
  final String refreshToken;
  final bool isEmailVerified;
  final String locale;
  final String timezone;

  const SocialUserData({
    required this.provider,
    required this.userId,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.accessToken,
    required this.refreshToken,
    required this.isEmailVerified,
    required this.locale,
    required this.timezone,
  });

  /// Get provider display name
  String get providerDisplayName {
    switch (provider) {
      case SocialProvider.google:
        return 'Google';
      case SocialProvider.facebook:
        return 'Facebook';
      case SocialProvider.apple:
        return 'Apple';
    }
  }

  /// Get provider icon
  IconData get providerIcon {
    switch (provider) {
      case SocialProvider.google:
        return Icons.g_mobiledata;
      case SocialProvider.facebook:
        return Icons.facebook;
      case SocialProvider.apple:
        return Icons.apple;
    }
  }

  /// Get provider color
  Color get providerColor {
    switch (provider) {
      case SocialProvider.google:
        return const Color(0xFF4285F4);
      case SocialProvider.facebook:
        return const Color(0xFF1877F2);
      case SocialProvider.apple:
        return Colors.black;
    }
  }
}

/// Social Login Result
class SocialLoginResult {
  final bool isSuccess;
  final SocialUserData? user;
  final SocialLoginError? error;

  const SocialLoginResult._({
    required this.isSuccess,
    this.user,
    this.error,
  });

  factory SocialLoginResult.success(SocialUserData user) {
    return SocialLoginResult._(isSuccess: true, user: user);
  }

  factory SocialLoginResult.failure(SocialLoginError error) {
    return SocialLoginResult._(isSuccess: false, error: error);
  }
}

/// Social Login Error
class SocialLoginError {
  final String code;
  final String message;
  final SocialProvider provider;

  const SocialLoginError({
    required this.code,
    required this.message,
    required this.provider,
  });

  /// Get user-friendly error message
  String get userFriendlyMessage {
    switch (code) {
      case 'DEMO_GOOGLE_ERROR':
        return 'Google login is currently in demo mode. Please try again.';
      case 'DEMO_FACEBOOK_ERROR':
        return 'Facebook login is currently in demo mode. Please try again.';
      case 'DEMO_APPLE_ERROR':
        return 'Apple login is currently in demo mode. Please try again.';
      default:
        return message;
    }
  }
}
