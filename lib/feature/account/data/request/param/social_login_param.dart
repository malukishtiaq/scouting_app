import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import '../../../../../core/params/base_params.dart';

/// Social Login Parameter Model
/// Used for authenticating users via social media providers
class SocialLoginParam extends BaseParams {
  final String? serverKey; // Server key for API authentication
  final String? socialProvider; // 'google', 'facebook', or 'apple'
  final String? socialUserId; // Social provider user ID
  final String? socialAccessToken; // Social provider access token
  final String? email; // User's email from social provider
  final String? username; // User's display name from social provider
  final String? firstName; // User's first name from social provider
  final String? lastName; // User's last name from social provider
  final String? profilePicture; // User's profile picture URL
  final bool? isEmailVerified; // Whether email is verified by social provider
  final String? locale; // User's locale from social provider
  final String? timezone; // User's timezone
  final String? androidNDeviceId; // Android device ID for notifications
  final String? androidMDeviceId; // Android device ID for messages
  final String? deviceType; // Device type (phone, web, etc.)

  SocialLoginParam({
    this.serverKey,
    this.socialProvider,
    this.socialUserId,
    this.socialAccessToken,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.isEmailVerified,
    this.locale,
    this.timezone,
    this.androidNDeviceId,
    this.androidMDeviceId,
    this.deviceType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (serverKey.isNotEmptyNorNull) 'server_key': serverKey,
        if (socialProvider.isNotEmptyNorNull) 'social_provider': socialProvider,
        if (socialUserId.isNotEmptyNorNull) 'social_user_id': socialUserId,
        if (socialAccessToken.isNotEmptyNorNull)
          'social_access_token': socialAccessToken,
        if (email.isNotEmptyNorNull) 'email': email,
        if (username.isNotEmptyNorNull) 'username': username,
        if (firstName.isNotEmptyNorNull) 'first_name': firstName,
        if (lastName.isNotEmptyNorNull) 'last_name': lastName,
        if (profilePicture.isNotEmptyNorNull) 'profile_picture': profilePicture,
        if (isEmailVerified != null)
          'is_email_verified': isEmailVerified! ? 1 : 0,
        if (locale.isNotEmptyNorNull) 'locale': locale,
        if (timezone.isNotEmptyNorNull) 'timezone': timezone,
        if (androidNDeviceId.isNotEmptyNorNull)
          'android_n_device_id': androidNDeviceId,
        if (androidMDeviceId.isNotEmptyNorNull)
          'android_m_device_id': androidMDeviceId,
        if (deviceType.isNotEmptyNorNull) 'device_type': deviceType,
      };

  /// Create from social user data
  factory SocialLoginParam.fromSocialUserData(
    Map<String, dynamic> socialUserData, {
    String? serverKey,
    String? androidNDeviceId,
    String? androidMDeviceId,
    String? deviceType,
  }) {
    return SocialLoginParam(
      serverKey: serverKey,
      socialProvider: socialUserData['social_provider'],
      socialUserId: socialUserData['social_user_id'],
      socialAccessToken: socialUserData['social_access_token'],
      email: socialUserData['email'],
      username: socialUserData['username'],
      firstName: socialUserData['first_name'],
      lastName: socialUserData['last_name'],
      profilePicture: socialUserData['profile_picture'],
      isEmailVerified: socialUserData['is_email_verified'] ?? false,
      locale: socialUserData['locale'],
      timezone: socialUserData['timezone'],
      androidNDeviceId: androidNDeviceId,
      androidMDeviceId: androidMDeviceId,
      deviceType: deviceType,
    );
  }

  /// Create for Google login
  factory SocialLoginParam.forGoogle({
    required String serverKey,
    required String socialUserId,
    required String socialAccessToken,
    required String email,
    required String username,
    String? firstName,
    String? lastName,
    String? profilePicture,
    bool? isEmailVerified,
    String? locale,
    String? timezone,
    String? androidNDeviceId,
    String? androidMDeviceId,
    String? deviceType,
  }) {
    return SocialLoginParam(
      serverKey: serverKey,
      socialProvider: 'google',
      socialUserId: socialUserId,
      socialAccessToken: socialAccessToken,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profilePicture: profilePicture,
      isEmailVerified: isEmailVerified,
      locale: locale,
      timezone: timezone,
      androidNDeviceId: androidNDeviceId,
      androidMDeviceId: androidMDeviceId,
      deviceType: deviceType,
    );
  }

  /// Create for Facebook login
  factory SocialLoginParam.forFacebook({
    required String serverKey,
    required String socialUserId,
    required String socialAccessToken,
    required String email,
    required String username,
    String? firstName,
    String? lastName,
    String? profilePicture,
    bool? isEmailVerified,
    String? locale,
    String? timezone,
    String? androidNDeviceId,
    String? androidMDeviceId,
    String? deviceType,
  }) {
    return SocialLoginParam(
      serverKey: serverKey,
      socialProvider: 'facebook',
      socialUserId: socialUserId,
      socialAccessToken: socialAccessToken,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profilePicture: profilePicture,
      isEmailVerified: isEmailVerified,
      locale: locale,
      timezone: timezone,
      androidNDeviceId: androidNDeviceId,
      androidMDeviceId: androidMDeviceId,
      deviceType: deviceType,
    );
  }

  /// Create for Apple login
  factory SocialLoginParam.forApple({
    required String serverKey,
    required String socialUserId,
    required String socialAccessToken,
    required String email,
    required String username,
    String? firstName,
    String? lastName,
    String? profilePicture,
    bool? isEmailVerified,
    String? locale,
    String? timezone,
    String? androidNDeviceId,
    String? androidMDeviceId,
    String? deviceType,
  }) {
    return SocialLoginParam(
      serverKey: serverKey,
      socialProvider: 'apple',
      socialUserId: socialUserId,
      socialAccessToken: socialAccessToken,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profilePicture: profilePicture,
      isEmailVerified: isEmailVerified,
      locale: locale,
      timezone: timezone,
      androidNDeviceId: androidNDeviceId,
      androidMDeviceId: androidMDeviceId,
      deviceType: deviceType,
    );
  }
}
