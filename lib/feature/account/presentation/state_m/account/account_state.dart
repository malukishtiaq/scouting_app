part of 'account_cubit.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState.accountInit() = AccountInit;
  const factory AccountState.accountLoading() = AccountLoading;
  const factory AccountState.accountError(
    AppErrors error,
    VoidCallback callback,
  ) = AccountError;

  const factory AccountState.registerError(
    AppErrors error,
    VoidCallback callback,
    RegisterParam param,
  ) = RegisterError;

  const factory AccountState.loginSuccess(
    AuthResponseEntity accountEntity,
  ) = LoginSuccessState;

  const factory AccountState.userRegisteredSuccess(
      AuthResponseEntity accountEntity) = UserRegisteredSuccessState;

  const factory AccountState.profileUpdateSuccess() = ProfileUpdateSuccessState;

  const factory AccountState.resetPasswordSuccess(String email) =
      ResetPasswordSuccessState;

  const factory AccountState.replacePasswordSuccess(String message) =
      ReplacePasswordSuccessState;

  const factory AccountState.voucherRedeemedSuccess() =
      VoucherRedeemedSuccessState;

  const factory AccountState.accountDeletedSuccess() =
      AccountDeletedSuccessState;

  const factory AccountState.showDeleteData() = ShowDeleteDataState;
  const factory AccountState.showDeleteAccount() = ShowDeleteAccountState;

  const factory AccountState.socialMediaSuccess() =
      SocialGmailLoginRequestSuccessState;

  const factory AccountState.socialFBLoginRequestSuccess() =
      SocialFBLoginRequestSuccessState;

  const factory AccountState.socialLinkedInLoginRequestSuccess() =
      SocialLinkedInLoginRequestSuccessState;

  const factory AccountState.socialAppleLoginRequestSuccess() =
      SocialAppleLoginRequestSuccessState;

  const factory AccountState.passwordVisibilityChanged(bool value) =
      PasswordVisibilityChanged;

  const factory AccountState.confirmPasswordVisibilityChanged(bool value) =
      ConfirmPasswordVisibilityChanged;

  const factory AccountState.notificationToggelled(bool value) =
      NotificationToggelled;

  const factory AccountState.faceidToggelled(bool value) = FaceIdToggelled;

  const factory AccountState.profilePictureUrl(String value) =
      ProfilePictureUrl;

  const factory AccountState.newProfilePicture(XFile? value) =
      NewProfilePicture;

  const factory AccountState.linkedInLoginSuccess() = LinkedInLoginSuccess;

  const factory AccountState.socialLoginSuccess(
    AuthResponseEntity accountEntity,
  ) = SocialLoginSuccessState;

  const factory AccountState.socialLoginError(
    AppErrors error,
    VoidCallback callback,
  ) = SocialLoginErrorState;
}
