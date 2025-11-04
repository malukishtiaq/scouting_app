import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/common/utils/utils.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/errors/app_errors.dart';
// duplicate import removed
import '../../../../../core/providers/session_data.dart';
import '../../../../../core/common/local_storage.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../mainapis.dart';
import '../../../data/request/param/love_loop/delete_account_param.dart';
import '../../../data/request/param/login_param.dart';
import '../../../data/request/param/love_loop/register_param.dart';
import '../../../data/request/param/love_loop/replace_password_param.dart';
import '../../../data/request/param/love_loop/reset_password_param.dart';
import '../../../data/request/param/love_loop/two_factor_param.dart';
import '../../../domain/entity/login_response_entity.dart';
import '../../../domain/usecase/delete_account_usecase.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/replace_password_usecase.dart';
import '../../../domain/usecase/reset_password_usecase.dart';
import '../../../domain/usecase/resend_email_usecase.dart';
import '../../../data/request/param/love_loop/resend_email_param.dart';
import '../../../domain/usecase/resgister_usecase.dart';
import '../../../domain/usecase/two_factor_usecase.dart';
import '../../../domain/usecase/verify_account_usecase.dart';
import '../../../domain/usecase/social_login_usecase.dart';
import '../../../data/request/param/social_login_param.dart';
import '../../screen/login/login_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_cubit.freezed.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit([this.param = const LoginScreenParam()])
      : super(const AccountState.accountInit()) {
    usernameController.text = '';
    passwordController.text = '';

    isFaceIdEnabled = false;
    isNotificationEnabled = false;
  }

  // fields
  final LoginScreenParam param;

  ///form section
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordKey = GlobalKey<FormFieldState<String>>();
  final passwordFocusNode = FocusNode();

  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final usernameKey = GlobalKey<FormFieldState<String>>();

  bool _isShowPassword = true;
  bool get isShowPassword => _isShowPassword;
  set isShowPassword(bool value) {
    _isShowPassword = value;
    emit(AccountState.passwordVisibilityChanged(value));
  }

  bool _isShowConfirmPassword = false;
  bool get isShowConfirmPassword => _isShowConfirmPassword;
  set isShowConfirmPassword(bool value) {
    _isShowConfirmPassword = value;
    emit(AccountState.confirmPasswordVisibilityChanged(value));
  }

  bool _isNotificationEnabled = false;
  bool get isNotificationEnabled => _isNotificationEnabled;
  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    emit(AccountState.notificationToggelled(value));
  }

  bool _isFaceIdEnabled = false;
  bool get isFaceIdEnabled => _isFaceIdEnabled;
  set isFaceIdEnabled(bool value) {
    _isFaceIdEnabled = value;
    emit(AccountState.faceidToggelled(value));
  }

  String _profilePictureUrl = "";
  String get profilePictureUrl => _profilePictureUrl;
  set profilePictureUrl(String value) {
    _profilePictureUrl = value;
    emit(AccountState.profilePictureUrl(value));
  }

  XFile? _profilePicture;
  XFile? get profilePicture => _profilePicture;
  set profilePicture(XFile? value) {
    _profilePicture = value;
    emit(AccountState.newProfilePicture(value));
  }

  void loginLoveLoop(LoginParam param) async {
    emit(const AccountState.accountLoading());

    try {
      // Get OneSignal player ID for notifications

      // Create LoginParam with new API structure
      final loginParam = LoginParam(
        serverKey: MainAPIS.serverKey,
        timezone: DateTime.now().timeZoneName, // User's timezone
        username: param.username, // Username from form (already sanitized)
        password: param.password, // Password from form
        deviceType: 'phone', // Device type
      );

      final result = await getIt<LoginUsecase>()(loginParam);

      result.pick(
        onData: (data) async {
          // Setup session data and emit success
          _setupSessionData(data);
          emit(AccountState.loginSuccess(data));
        },
        onError: (error) {
          // Enhanced error handling with specific error codes
          emit(AccountState.accountError(error, () => loginLoveLoop(param)));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        const AppErrors.customError(message: 'Login failed. Please try again.'),
        () => loginLoveLoop(param),
      ));
    }
  }

  /// Handle 2FA verification (like Xamarin's TwoFactorAsync)
  void verifyTwoFactor(String code) async {
    emit(const AccountState.accountLoading());

    try {
      final sessionData = getIt<SessionData>();

      // Get OneSignal player ID for notifications
      // Create TwoFactorParam following Xamarin's structure
      final twoFactorParam = TwoFactorParam(
        userId: sessionData.userId?.toString(),
        code: code,
        deviceType: 'phone',
      );

      final result = await getIt<TwoFactorUseCase>()(twoFactorParam);

      result.pick(
        onData: (data) async {
          // 2FA verification successful - setup session and navigate to main
          _setupSessionData(data);
          emit(AccountState.loginSuccess(data));
        },
        onError: (error) {
          // Handle 2FA verification errors
          emit(AccountState.accountError(error, () => verifyTwoFactor(code)));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        const AppErrors.customError(
            message: '2FA verification failed. Please try again.'),
        () => verifyTwoFactor(code),
      ));
    }
  }

  /// Handle account verification after registration (like Xamarin's verification flow)
  void verifyAccount(String userId, String code, String typeCode) async {
    emit(const AccountState.accountLoading());

    try {
      // Create VerifyAccountParam
      final verifyParam = VerifyAccountParam(
        userId: userId,
        code: code,
        typeCode: typeCode,
      );

      final result = await getIt<VerifyAccountUseCase>()(verifyParam);

      result.pick(
        onData: (data) async {
          // Account verification successful - setup session and navigate to main
          _setupSessionData(data);
          emit(AccountState.loginSuccess(data));
        },
        onError: (error) {
          // Handle verification errors
          emit(AccountState.accountError(
              error, () => verifyAccount(userId, code, typeCode)));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        const AppErrors.customError(
            message: 'Account verification failed. Please try again.'),
        () => verifyAccount(userId, code, typeCode),
      ));
    }
  }

  /// Enhanced error handling with specific error messages
  String _getSpecificErrorMessage(AppErrors error) {
    if (error is CustomError) {
      final errorMessage = error.message.toLowerCase();

      // Handle specific error codes from API
      if (errorMessage.contains('error_id') ||
          errorMessage.contains('error_text')) {
        // Parse error from API response
        return _parseApiErrorMessage(errorMessage);
      }

      // Handle common error patterns
      if (errorMessage.contains('username not found') ||
          errorMessage.contains('user not found')) {
        return 'Username not found. Please check your username and try again.';
      }

      if (errorMessage.contains('wrong password') ||
          errorMessage.contains('incorrect password')) {
        return 'Wrong password. Please check your password and try again.';
      }

      if (errorMessage.contains('account suspended') ||
          errorMessage.contains('banned')) {
        return 'Your account has been suspended. Please contact support.';
      }

      if (errorMessage.contains('too many attempts')) {
        return 'Too many login attempts. Please try again later.';
      }

      if (errorMessage.contains('verification required') ||
          errorMessage.contains('2fa')) {
        return 'Two-factor authentication required. Please enter your verification code.';
      }
    }

    // Default error message
    return 'Login failed. Please check your credentials and try again.';
  }

  /// Parse API error messages for specific error codes
  String _parseApiErrorMessage(String errorMessage) {
    try {
      // Try to extract error code and text from API response
      if (errorMessage.contains('"error_id":"4"') ||
          errorMessage.contains('"error_id":4')) {
        return 'Username not found. Please check your username and try again.';
      }

      if (errorMessage.contains('"error_id":"5"') ||
          errorMessage.contains('"error_id":5')) {
        return 'Wrong password. Please check your password and try again.';
      }

      if (errorMessage.contains('"error_id":"3"') ||
          errorMessage.contains('"error_id":3')) {
        return 'Account verification required. Please check your email.';
      }

      // Extract error text if available
      final errorTextMatch =
          RegExp(r'"error_text":"([^"]+)"').firstMatch(errorMessage);
      if (errorTextMatch != null) {
        return errorTextMatch.group(1) ?? 'Login failed. Please try again.';
      }

      return 'Login failed. Please check your credentials and try again.';
    } catch (e) {
      return 'Login failed. Please try again.';
    }
  }

  void resgister(RegisterParam param) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ResgisterUsecase>()(param);

    result.pick(
      onData: (data) async {
        _setupSessionData(data);
        emit(AccountState.userRegisteredSuccess(data));
      },
      onError: (error) {
        emit(AccountState.registerError(error, () => resgister(param), param));
      },
    );
  }

  void _setupSessionData(AuthResponseEntity data) async {
    try {
      final accessToken = data.accessToken;
      final userId = int.tryParse(data.userId ?? '0') ?? 0;

      if (accessToken?.isNotEmpty == true && userId > 0) {
        // Use AuthService for consistent session management
        final authService = getIt<AuthService>();
        await authService.setupSession(
          accessToken: accessToken!,
          userId: userId,
        );
      }
    } catch (e) {
      print('Error setting up session: $e');
      // Fallback to direct storage if AuthService fails
      getIt<SessionData>().token = data.accessToken;
      getIt<SessionData>().userId = int.tryParse(data.userId ?? '0') ?? 0;
      if ((data.accessToken ?? '').isNotEmpty) {
        LocalStorage.persistToken(data.accessToken!);
      }
    }
  }

  void showDeleteAccount() {
    emit(const AccountState.showDeleteAccount());
  }

  void showDeleteData() {
    emit(const AccountState.showDeleteData());
  }

  void cancelDeleteData() {
    emit(const AccountState.accountInit());
  }

  void deleteAccount() async {
    emit(const AccountState.accountLoading());

    final result = await getIt<DeleteAccountUsecase>()(DeleteAccountParam());

    result.pick(
      onData: (data) {
        if (data.status == AppConstants.SUCCESSFUL) {
          Utils.logout();
        }
        emit(const AccountState.accountInit());
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => deleteAccount()));
      },
    );
  }

  void toggleShowPassword() {
    isShowPassword = !isShowPassword;
  }

  void toggleNotification() {
    isNotificationEnabled = !isNotificationEnabled;
  }

  void toggleFaceId() {
    isFaceIdEnabled = !isFaceIdEnabled;
  }

  void deleteNewProfilePicture() {
    profilePicture = null;
  }

  void resetPassword(String email) async {
    // Step 1: Send reset email (WoWonder: api/send-reset-password-email)
    emit(const AccountState.accountLoading());

    final result =
        await getIt<ResendEmailUseCase>()(ResendEmailParam(email: email));

    result.pick(
      onData: (data) {
        // Signal UI to navigate to verification next
        emit(AccountState.resetPasswordSuccess(email));
      },
      onError: (error) {
        emit(AccountState.accountError(error, () => resetPassword(email)));
      },
    );
  }

  /// Confirm password reset using email code (WoWonder ResetPasswordAsync)
  void confirmResetPassword(
      String email, String code, String newPassword) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ResetPasswordUseCase>()(
      ResetPasswordParam(email: email, code: code, newPassword: newPassword),
    );

    result.pick(
      onData: (data) {
        emit(const AccountState.replacePasswordSuccess("Password updated"));
      },
      onError: (error) {
        emit(AccountState.accountError(
            error, () => confirmResetPassword(email, code, newPassword)));
      },
    );
  }

  void replacePassword(String email, String code, String newPassword) async {
    emit(const AccountState.accountLoading());

    final result = await getIt<ReplacePasswordUseCase>()(
      ReplacePasswordParam(
        currentPassword: null,
        newPassword: newPassword,
      ),
    );

    result.pick(
      onData: (data) {
        emit(AccountState.replacePasswordSuccess("Password updated"));
      },
      onError: (error) {
        emit(AccountState.accountError(
            error, () => replacePassword(email, code, newPassword)));
      },
    );
  }

  /// Social Login Method
  void socialLogin(SocialLoginParam param) async {
    emit(const AccountState.accountLoading());

    try {
      final result = await getIt<SocialLoginUseCase>()(param);

      result.pick(
        onData: (data) async {
          _setupSessionData(data);
          emit(AccountState.socialLoginSuccess(data));
        },
        onError: (error) {
          emit(AccountState.socialLoginError(error, () => socialLogin(param)));
        },
      );
    } catch (e) {
      emit(AccountState.accountError(
        CustomError(message: 'Social login failed: $e'),
        () => socialLogin(param),
      ));
    }
  }
}
