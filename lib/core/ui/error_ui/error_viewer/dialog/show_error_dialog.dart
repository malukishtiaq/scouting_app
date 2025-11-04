import 'package:flutter/material.dart';
import 'package:scouting_app/core/ui/dialogs/custom_dialogs.dart';
import 'package:scouting_app/core/ui/error_ui/error_viewer/dialog/errv_dialog_options.dart';
import 'package:scouting_app/localization/app_localization.dart';

void showCustomErrorDialog({
  required BuildContext context,
  String? message,
  VoidCallback? callback,
  required ErrVDialogOptions errVDialogOptions,
}) {
  showCustomConfirmCancelDialog(
    mainContext: context,
    content: message ?? "",
    title: errVDialogOptions.title ?? "oopsErrorMessage".tr,
    onConfirm: errVDialogOptions.confirmOptions?.onBtnPressed ??
        (dContext) {
          Navigator.pop(dContext);
          if (callback != null) callback();
        },
    // onCancel: (dContext) async => await SystemNavigator.pop(),
    onCancel: errVDialogOptions.cancelOptions?.onBtnPressed ??
        (dContext) async => Navigator.pop(dContext),
    confirmText: errVDialogOptions.confirmOptions?.buttonText ?? "retry".tr,
    cancelText: errVDialogOptions.cancelOptions?.buttonText ?? "cancel".tr,
    isDismissible: false,
  );
}
