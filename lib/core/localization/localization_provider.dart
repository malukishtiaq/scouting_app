import 'package:flutter/material.dart';
import 'package:scouting_app/core/common/local_storage.dart';
import 'package:scouting_app/main.dart';

import '../constants/app/app_constants.dart';
import '../constants/shared_preference/shared_preference_keys.dart';

class LocalizationProvider extends ChangeNotifier {
  static final _instance = LocalizationProvider._internal();

  factory LocalizationProvider() => _instance;

  LocalizationProvider._internal();

  Locale _appLocale = const Locale(AppConstants.LANG_EN);

  /// To know if this first time run the application or not
  bool _firstStart = false;

  /// Get current Locale supported
  Locale get appLocal => _appLocale;

  String get currentLanguage => appLocal.languageCode;

  /// Get and set first start
  bool get firstStart => _firstStart;

  void firstStartOff() {
    /// firstStart = true not touchable from outside
    _firstStart = false;
  }

  /// Fetch app locale, called in [main]
  fetchLocale() async {
    if (!LocalStorage.isInitialized) {
      // If LocalStorage is not initialized, use default values
      _appLocale = const Locale(AppConstants.LANG_EN);
      _firstStart = true;
      return null;
    }

    var prefs = LocalStorage.sharedPreferences;
    if (prefs == null) {
      // Fallback to default values
      _appLocale = const Locale(AppConstants.LANG_EN);
      _firstStart = true;
      return null;
    }

    /// Check if the application is first start or not
    if (prefs.getBool(SharedPreferenceKeys.KEY_FIRST_START) == null) {
      /// Set first start is true
      await prefs.setBool(SharedPreferenceKeys.KEY_FIRST_START, true);
      _firstStart = true;
    }
    if (prefs.getString(SharedPreferenceKeys.KEY_LANGUAGE) == null) {
      _appLocale = const Locale(AppConstants.LANG_EN);
      await prefs.setString(
        SharedPreferenceKeys.KEY_LANGUAGE,
        AppConstants.LANG_EN,
      );
      return null;
    }
    String? languageCode = prefs.getString(SharedPreferenceKeys.KEY_LANGUAGE);
    _appLocale = Locale(languageCode ?? AppConstants.LANG_EN);

    return null;
  }

  Future<void> changeLanguage(Locale type, BuildContext context) async {
    if (!LocalStorage.isInitialized) {
      return;
    }

    var prefs = LocalStorage.sharedPreferences;
    if (prefs == null) {
      return;
    }

    if (_appLocale == type) {
      return;
    }
    _appLocale = type;

    if (type == const Locale(AppConstants.LANG_AR)) {
      await prefs.setString(
          SharedPreferenceKeys.KEY_LANGUAGE, AppConstants.LANG_AR);
    } else {
      await prefs.setString(
          SharedPreferenceKeys.KEY_LANGUAGE, AppConstants.LANG_EN);
    }
    notifyListeners();
  }
}
