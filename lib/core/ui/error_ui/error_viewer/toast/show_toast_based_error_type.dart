import 'package:flutter/material.dart';
import 'package:scouting_app/core/errors/app_errors.dart';
import 'package:scouting_app/localization/app_localization.dart';
import '../error_viewer.dart';
import 'errv_toast_options.dart';

void showToastBasedErrorType(
  BuildContext context,
  AppErrors error,
  VoidCallback callback, {
  ErrVToastOptions errVToastOptions = const ErrVToastOptions(),
}) {
  error.map(
    connectionError: (error) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    internalServerError: (error) {
      ErrorViewer.showInternalServerError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    internalServerWithDataError: (error) {
      if (error.message == null) {
        ErrorViewer.showUnexpectedError(
          context,
          errorViewerOptions: errVToastOptions,
          message: error.message,
          callback: callback,
        );
      } else {
        ErrorViewer.showCustomError(
          context,
          error.message!,
          errorViewerOptions: errVToastOptions,
          callback: callback,
        );
      }
    },
    accountNotVerifiedError: (error) {
      ErrorViewer.showAccountNotVerifiedError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    badRequestError: (error) {
      ErrorViewer.showBadRequestError(
        context,
        error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    cancelError: (error) {
      ErrorViewer.showCancelError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    conflictError: (error) {
      ErrorViewer.showConflictError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
      );
    },
    customError: (error) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    forbiddenError: (error) {
      ErrorViewer.showForbiddenError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
      );
    },
    formatError: (error) {
      ErrorViewer.showFormatError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    loginRequiredError: (error) {
      ErrorViewer.showCustomError(
        context,
        "loginErrorRequired".tr,
        errorViewerOptions: errVToastOptions,
      );
    },
    netError: (error) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        message: error.message,
      );
    },
    notFoundError: (error) {
      ErrorViewer.showNotFoundError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
        url: error.requestedUrlPath,
      );
    },
    responseError: (error) {
      ErrorViewer.showCustomError(
        context,
        "An error aquire in response",
        errorViewerOptions: errVToastOptions,
      );
    },
    screenNotImplementedError: (error) {
      ErrorViewer.showCustomError(
        context,
        "screen Not ImplementedError",
        errorViewerOptions: errVToastOptions,
      );
    },
    socketError: (error) {
      ErrorViewer.showSocketError(
        context,
        callback,
        errorViewerOptions: errVToastOptions,
        message: error.message,
      );
    },
    timeoutError: (error) {
      ErrorViewer.showTimeoutError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
      );
    },
    unauthorizedError: (error) {
      ErrorViewer.showUnauthorizedError(
        context,
        message: error.message,
        errorViewerOptions: errVToastOptions,
        callback: callback,
      );
    },
    unknownError: (error) {
      ErrorViewer.showUnknownError(
        context,
        errorViewerOptions: errVToastOptions,
        message: error.message,
        callback: callback,
      );
    },
  );
}
