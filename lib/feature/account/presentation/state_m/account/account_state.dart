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
    ScoutingRegisterParam param,
  ) = RegisterError;

  const factory AccountState.loginSuccess(
    AuthResponseEntity accountEntity,
  ) = LoginSuccessState;

  const factory AccountState.userRegisteredSuccess(
      AuthResponseEntity accountEntity) = UserRegisteredSuccessState;

  const factory AccountState.profileUpdateSuccess() = ProfileUpdateSuccessState;

  const factory AccountState.showDeleteData() = ShowDeleteDataState;
  const factory AccountState.showDeleteAccount() = ShowDeleteAccountState;

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
}
