import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'dialog/errv_dialog_options.dart';
import 'dialog/show_dialog_based_error_type.dart';
import 'dialog/show_error_dialog.dart';
import 'errv_options.dart';
import 'snack_bar/errv_snack_bar_options.dart';
import 'snack_bar/show_error_snackbar.dart';
import 'snack_bar/show_snackbar_based_error_type.dart';
import 'toast/errv_toast_options.dart';
import 'toast/show_error_toast.dart';
import 'toast/show_toast_based_error_type.dart';

class ErrorViewer {
  static showError({
    required BuildContext context,
    required AppErrors error,
    required VoidCallback callback,
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showSnakBarBasedErrorType(
        context,
        error,
        callback,
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showToastBasedErrorType(
        context,
        error,
        callback,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showDialogBasedErrorType(
        context,
        error,
        callback,
        errVDialogOptions: errorViewerOptions,
      );
    }
  }

  static void showCancelError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: "Operation has been cancelled",
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: "Operation has been cancelled",
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: "Operation has been cancelled",
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showAccountNotVerifiedError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: "Account Not Verified",
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: "Account Not Verified",
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: "Account Not Verified",
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showInternalServerError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message:
            'The server encountered an internal error or misconfigurtion and was unable to complete your request.',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message:
            'The server encountered an internal error or misconfigurtion and was unable to complete your request.',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message:
            'The server encountered an internal error or misconfigurtion and was unable to complete your request.',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showFormatError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'An error has occurred. Please try again later',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'An error has occurred. Please try again later',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'An error has occurred. Please try again later',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showConnectionError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVDialogOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Please check your internet connection',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Please check your internet connection',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Please check your internet connection',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showCustomError(
    BuildContext context,
    String message, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: message,
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: message,
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: message,
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnexpectedError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'An error has occurred. Please try again later',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'An error has occurred. Please try again later',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'An error has occurred. Please try again later',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnauthorizedError(
    BuildContext context, {
    String? message,
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Unauthorized${message.isEmptyOrNull ? "" : ", $message"}',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Unauthorized${message.isEmptyOrNull ? "" : ", $message"}',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Unauthorized${message.isEmptyOrNull ? "" : ", $message"}',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }

    // Utils.logout();
  }

  static void showBadRequestError(
    BuildContext context,
    String? message, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: message ?? 'Bad Request',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: message ?? 'Bad Request',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: message ?? 'Bad Request',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showForbiddenError(
    BuildContext context, {
    String? message,
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Forbidden${message ?? ""}',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Forbidden${message ?? ""}',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Forbidden${message ?? ""}',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }

    // Utils.logout();
  }

  static void showNotFoundError(
    BuildContext context, {
    required url,
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: '$url not Found',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: '$url not Found',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: '$url not Found',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showConflictError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Conflict Error',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Conflict Error',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Conflict Error',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showTimeoutError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Connection time out',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Connection time out',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Connection time out',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showUnknownError(
    BuildContext context, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
    VoidCallback? callback,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions) {
      showErrorSnackBar(
        message: 'Unknown error occurred, please try again',
        errVSnackBarOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVToastOptions) {
      showErrorToast(
        message: 'Unknown error occurred, please try again',
        context: context,
        errVToastOptions: errorViewerOptions,
      );
    } else if (errorViewerOptions is ErrVDialogOptions) {
      showCustomErrorDialog(
        context: context,
        message: 'Unknown error occurred, please try again',
        callback: callback,
        errVDialogOptions: errorViewerOptions,
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }

  static void showSocketError(
    BuildContext context,
    VoidCallback callback, {
    ErrorViewerOptions errorViewerOptions = const ErrVSnackBarOptions(),
    String? message,
  }) {
    if (errorViewerOptions is ErrVSnackBarOptions ||
        errorViewerOptions is ErrVToastOptions ||
        errorViewerOptions is ErrVDialogOptions) {
      ErrVDialogOptions? errVDialogOptions;

      if (errorViewerOptions is ErrVDialogOptions) {
        errVDialogOptions = errorViewerOptions;
      }

      showCustomErrorDialog(
        context: context,
        message: 'Please check your internet connection',
        callback: callback,
        errVDialogOptions: errVDialogOptions ?? const ErrVDialogOptions(),
      );
    } else {
      throw Exception("Error viewer options must be defined");
    }
  }
}
