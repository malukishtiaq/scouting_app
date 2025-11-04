import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:scouting_app/export_files.dart';
import 'package:scouting_app/core/constants/shared_preference/shared_preference_keys.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app/core/common/local_storage.dart';
import '../../../di/service_locator.dart';
import '../../navigation/navigation_service.dart';
import '../../ui/widgets/restart_widget.dart';
import '../../services/account_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  /// Find if any widget has focus in the given [context] and unfocus it
  static void unFocus(BuildContext context) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
  }

  static Future<void> launchURL(Uri url, mode) async {
    if (await canLaunchUrl(url)) {
      try {
        final platformLaunchMode = !kIsWeb && Platform.isIOS
            ? LaunchMode.externalApplication
            : LaunchMode.externalNonBrowserApplication;

        await launchUrl(
          url,
          mode: mode ?? platformLaunchMode,
        );
      } catch (e) {
        // showToast("errorOccurred".tr);
      }
    } else {
      // showToast("errorOccurred".tr);
    }
  }

  static void share({
    required BuildContext context,
    required Uri link,
  }) {
    try {
      // final box = context.findRenderObject() as RenderBox?;

      // Share.share(
      //   link.toString(),
      //   sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      // );
    } catch (e) {
      // showToast("errorOccurred".tr);
    }
  }

  static Future<void> logout() async {
    // Clear skip login flag
    await LocalStorage.persistSkipLogin(false);

    // Clear all user data from shared preferences
    await LocalStorage.deleteKeys(SharedPreferenceKeys.REMOVE_KEYS_ON_LOGOUT);

    // Clear account service data (website URL, server key, account type)
    await AccountService().clearAccountType();

    // Clear Firebase token if available
    // await FireBaseMessagingWrapper().deleteFirebaseToken();

    // Restart the app to clear all state
    RestartWidget.restartApp(getIt<NavigationService>().appContext!);
  }
}
