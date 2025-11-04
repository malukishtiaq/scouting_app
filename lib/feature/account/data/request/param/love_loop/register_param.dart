import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

/// Register Parameter Model - matches Xamarin CreateAccountAsync exactly
class RegisterParam extends BaseParams {
  final String? serverKey; // Server key for API authentication
  final String? email; // User's email address
  final String? username; // Username for registration
  final String? firstName; // User's first name
  final String? lastName; // User's last name
  final String? password; // User's password
  final String? confirmPassword; // Password confirmation
  final String? gender; // User's gender (male/female)
  final String? phoneNum; // Phone number (conditional)
  final String? ref; // Referral code
  final String? androidNDeviceId; // Android device ID
  final String? androidMDeviceId; // Android device message ID
  final String? deviceType; // Device type (phone, web, etc.)

  RegisterParam({
    this.serverKey,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNum,
    this.ref,
    this.androidNDeviceId,
    this.androidMDeviceId,
    this.deviceType,
  });

  @override
  Map<String, dynamic> toMap() => {
        if (serverKey.isNotEmptyNorNull) 'server_key': serverKey,
        if (email.isNotEmptyNorNull) 'email': email,
        if (username.isNotEmptyNorNull) 'username': username,
        if (firstName.isNotEmptyNorNull) 'first_name': firstName,
        if (lastName.isNotEmptyNorNull) 'last_name': lastName,
        if (password.isNotEmptyNorNull) 'password': password,
        if (confirmPassword.isNotEmptyNorNull) 'confirm_password': confirmPassword,
        if (gender.isNotEmptyNorNull) 'gender': gender,
        if (phoneNum.isNotEmptyNorNull) 'phone_num': phoneNum,
        if (ref.isNotEmptyNorNull) 'ref': ref,
        if (androidNDeviceId.isNotEmptyNorNull) 'android_n_device_id': androidNDeviceId,
        if (androidMDeviceId.isNotEmptyNorNull) 'android_m_device_id': androidMDeviceId,
        if (deviceType.isNotEmptyNorNull) 'device_type': deviceType,
      };

  /// Create from form data with proper sanitization (like Xamarin)
  factory RegisterParam.fromFormData({
    required String serverKey,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String gender,
    String? phoneNum,
    String? ref,
    String? androidNDeviceId,
    String? androidMDeviceId,
    String? deviceType,
  }) {
    return RegisterParam(
      serverKey: serverKey,
      email: email.replaceAll(' ', ''), // Remove spaces like Xamarin
      username: username.replaceAll(' ', ''), // Remove spaces like Xamarin
      firstName: firstName.replaceAll(' ', ''), // Remove spaces like Xamarin
      lastName: lastName.replaceAll(' ', ''), // Remove spaces like Xamarin
      password: password,
      confirmPassword: confirmPassword,
      gender: gender,
      phoneNum: phoneNum,
      ref: ref,
      androidNDeviceId: androidNDeviceId,
      androidMDeviceId: androidMDeviceId,
      deviceType: deviceType ?? 'phone',
    );
  }
}
