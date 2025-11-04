import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/domain/entity/login_response_entity.dart';

/// New API Success Response - represents successful login
class AuthResponseModel extends BaseModel<AuthResponseEntity> {
  final int apiStatus; // API status (200)
  final String?
      message; // API message (e.g., registration success/verify prompt)
  final String? timezone; // User's timezone
  final String? accessToken; // Access token for authentication
  final String? userId; // User ID
  final String? userPlatform; // Platform (phone, web, etc.)
  final bool? membership; // Premium membership status

  AuthResponseModel({
    required this.apiStatus,
    this.message,
    this.timezone,
    this.accessToken,
    this.userId,
    this.userPlatform,
    this.membership,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      apiStatus: json["api_status"] ?? 400,
      message: json["message"],
      timezone: json["timezone"],
      accessToken: json["access_token"],
      userId: json["user_id"]?.toString(),
      userPlatform: json["user_platform"],
      membership: json["membership"] ?? false,
    );
  }

  @override
  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      apiStatus: apiStatus,
      message: message,
      timezone: timezone,
      accessToken: accessToken,
      userId: userId,
      userPlatform: userPlatform,
      membership: membership,
    );
  }
}

/// 2FA Response Model - represents pending verification (like Xamarin's AuthMessageObject)
class AuthMessageModel extends BaseModel<AuthMessageEntity> {
  final String? status; // API status (200)
  final String? message; // API message
  final String? userId; // User ID for pending verification

  AuthMessageModel({
    this.status,
    this.message,
    this.userId,
  });

  factory AuthMessageModel.fromJson(Map<String, dynamic> json) {
    return AuthMessageModel(
      status: json["api_status"]?.toString(),
      message: json["message"],
      userId: json["user_id"]?.toString(),
    );
  }

  @override
  AuthMessageEntity toEntity() {
    return AuthMessageEntity(
      status: status,
      message: message,
      userId: userId,
    );
  }
}

/// New API Error Response - represents API errors
class ErrorModel extends BaseModel<ErrorEntity> {
  final int apiStatus; // API status (400)
  final ErrorDataModel? errors; // Error details

  ErrorModel({
    required this.apiStatus,
    this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      apiStatus: json["api_status"] ?? 400,
      errors: json["errors"] != null
          ? ErrorDataModel.fromJson(json["errors"])
          : null,
    );
  }

  /// Get specific error message based on error code
  String getSpecificErrorMessage() {
    if (errors?.errorId == null) {
      return errors?.errorText ?? 'An error occurred. Please try again.';
    }

    switch (errors!.errorId) {
      case 3:
        return 'Account verification required. Please check your email for verification code.';
      case 4:
        return 'Username not found. Please check your username and try again.';
      case 5:
        return 'Wrong password. Please check your password and try again.';
      case 6:
        return 'Account suspended. Please contact support for assistance.';
      case 7:
        return 'Too many login attempts. Please try again later.';
      case 8:
        return 'Two-factor authentication required. Please enter your verification code.';
      case 9:
        return 'Account locked. Please contact support for assistance.';
      case 10:
        return 'Maintenance mode. Please try again later.';
      default:
        return errors?.errorText ?? 'An error occurred. Please try again.';
    }
  }

  /// Check if this is a specific error type
  bool get isVerificationRequired =>
      errors?.errorId == 3 || errors?.errorId == 8;
  bool get isUsernameNotFound => errors?.errorId == 4;
  bool get isWrongPassword => errors?.errorId == 5;
  bool get isAccountSuspended => errors?.errorId == 6;
  bool get isTooManyAttempts => errors?.errorId == 7;
  bool get isAccountLocked => errors?.errorId == 9;
  bool get isMaintenanceMode => errors?.errorId == 10;

  @override
  ErrorEntity toEntity() {
    return ErrorEntity(
      apiStatus: apiStatus,
      errors: errors?.toEntity(),
    );
  }
}

/// New API Error Data - contains error information
class ErrorDataModel extends BaseModel<ErrorDataEntity> {
  final int? errorId; // Error code (4, 5, etc.)
  final String? errorText; // Error message

  ErrorDataModel({
    this.errorId,
    this.errorText,
  });

  factory ErrorDataModel.fromJson(Map<String, dynamic> json) {
    return ErrorDataModel(
      errorId: json["error_id"],
      errorText: json["error_text"],
    );
  }

  @override
  ErrorDataEntity toEntity() {
    return ErrorDataEntity(
      errorId: errorId,
      errorText: errorText,
    );
  }
}
