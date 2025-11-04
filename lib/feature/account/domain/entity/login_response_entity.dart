// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/entities/base_entity.dart';

/// New API Success Response - represents successful login
class AuthResponseEntity extends BaseEntity {
  final int apiStatus; // API status (200)
  final String?
      message; // API message (e.g., registration success/verify prompt)
  final String? timezone; // User's timezone
  final String? accessToken; // Access token for authentication
  final String? userId; // User ID
  final String? userPlatform; // Platform (phone, web, etc.)
  final bool? membership; // Premium membership status

  AuthResponseEntity({
    required this.apiStatus,
    this.message,
    this.timezone,
    this.accessToken,
    this.userId,
    this.userPlatform,
    this.membership,
  });

  @override
  List<Object?> get props => [
        apiStatus,
        message,
        timezone,
        accessToken,
        userId,
        userPlatform,
        membership
      ];
}

/// 2FA Response Entity - represents pending verification (like Xamarin's AuthMessageObject)
class AuthMessageEntity extends BaseEntity {
  final String? status; // API status (200)
  final String? message; // API message
  final String? userId; // User ID for pending verification

  AuthMessageEntity({
    this.status,
    this.message,
    this.userId,
  });

  @override
  List<Object?> get props => [status, message, userId];
}

/// New API Error Response - represents API errors
class ErrorEntity extends BaseEntity {
  final int apiStatus; // API status (400)
  final ErrorDataEntity? errors; // Error details

  ErrorEntity({
    required this.apiStatus,
    this.errors,
  });

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
  List<Object?> get props => [apiStatus, errors];
}

/// New API Error Data - contains error information
class ErrorDataEntity extends BaseEntity {
  final int? errorId; // Error code (4, 5, etc.)
  final String? errorText; // Error message

  ErrorDataEntity({
    this.errorId,
    this.errorText,
  });

  @override
  List<Object?> get props => [errorId, errorText];
}
