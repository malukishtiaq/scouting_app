import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preference/shared_preference_keys.dart';

class LocalStorage {
  static SharedPreferences? _sp;
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      _sp = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  static SharedPreferences? get sharedPreferences => _sp;

  /// Check if LocalStorage is initialized
  static bool get isInitialized => _isInitialized;

  /// Safely get SharedPreferences instance
  static SharedPreferences get _safeSp {
    if (!_isInitialized || _sp == null) {
      throw StateError(
          'LocalStorage not initialized. Call LocalStorage.init() first.');
    }
    return _sp!;
  }

  /// deleteToken
  static Future<void> deleteToken() async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(SharedPreferenceKeys.KEY_TOKEN);
    }
  }

  /// deleteMemberId
  static Future<void> deleteMemberId() async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(SharedPreferenceKeys.MEMBER_ID);
    }
  }

  static Future<void> deleteLoginResponse() async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(SharedPreferenceKeys.MEMBER);
    }
  }

  /// deleteFcmToken
  static Future<void> deleteFcmToken() async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(SharedPreferenceKeys.KEY_FIREBASE_TOKEN);
    }
  }

  /// deleteFcmToken
  static Future<void> deleteOldFcmToken() async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(SharedPreferenceKeys.KEY_OLD_FIREBASE_TOKEN);
    }
  }

  /// persistToken
  static Future<void> persistToken(String token) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setString(SharedPreferenceKeys.KEY_TOKEN, token);
    }
  }

  /// persistMemberId
  static Future<void> persistMemberId(int id) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setInt(SharedPreferenceKeys.MEMBER_ID, id);
    }
  }

  // /// persistMemberId
  // /// static Future<void> persistLoginResponse(UserInfoEntity member) async {
  // ///   await _sp.setString(SharedPreferenceKeys.MEMBER, member.toJson());
  // /// }

  /// persist OldFcmToken
  static Future<void> persistOldFcmToken(String token) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setString(SharedPreferenceKeys.KEY_OLD_FIREBASE_TOKEN, token);
    }
  }

  /// persistFcmToken
  static Future<void> persistFcmToken(String token) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setString(SharedPreferenceKeys.KEY_FIREBASE_TOKEN, token);
    }
  }

  /// read authToken
  /// if returns null that means there's no token saved or LocalStorage not initialized
  static String? get authToken {
    if (!_isInitialized || _sp == null) {
      return null;
    }
    return _sp!.getString(SharedPreferenceKeys.KEY_TOKEN);
  }

  /// read memberID
  /// if returns 0 that means there's no member id saved or LocalStorage not initialized
  static int get memberID {
    if (!_isInitialized || _sp == null) {
      return 0;
    }
    return _sp!.getInt(SharedPreferenceKeys.MEMBER_ID) ?? 0;
  }

  /// read fcmToken
  /// if returns null that means there's no fcm token saved or LocalStorage not initialized
  static String? get fcmToken {
    if (!_isInitialized || _sp == null) {
      return null;
    }
    return _sp!.getString(SharedPreferenceKeys.KEY_FIREBASE_TOKEN);
  }

  /// check if hasToken or not
  static bool get hasToken {
    if (!_isInitialized || _sp == null) {
      return false;
    }
    String? token = _sp!.getString(SharedPreferenceKeys.KEY_TOKEN);
    return token != null && token.isNotEmpty;
  }

  /// check if hasMemberID or not
  static bool get hasMemberID {
    if (!_isInitialized || _sp == null) {
      return false;
    }
    int memberID = _sp!.getInt(SharedPreferenceKeys.MEMBER_ID) ?? 0;
    return memberID > 0;
  }

  /// check if hasFcmToken or not
  static bool get hasFcmToken {
    if (!_isInitialized || _sp == null) {
      return false;
    }
    String? token = _sp!.getString(SharedPreferenceKeys.KEY_FIREBASE_TOKEN);
    return token != null && token.isNotEmpty;
  }

  /// Persist Theme Mode
  static Future<void> persistThemeMode(ThemeMode theme) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setInt(SharedPreferenceKeys.KEY_APP_THEME, theme.index);
    }
  }

  /// Get APP Theme Mode
  static ThemeMode get getThemeMode {
    if (!_isInitialized || _sp == null) {
      return ThemeMode.light;
    }
    int? themeIndex = _sp!.getInt(SharedPreferenceKeys.KEY_APP_THEME);
    if (themeIndex == null) return ThemeMode.light;
    return ThemeMode.values[themeIndex];
  }

  // static UserInfoEntity? get loginResponse {
  //   String member = _sp.getString(SharedPreferenceKeys.MEMBER) ?? '';
  //   if (member == '') return null;
  //   return UserInfoEntity.fromJson(member);
  // }

  // Skip login screens
  static Future<void> persistSkipLogin(bool skip) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setBool(SharedPreferenceKeys.KEY_SKIP_LOGIN, skip);
    }
  }

  static bool get skipLogin {
    if (!_isInitialized || _sp == null) {
      return false;
    }
    return _sp!.getBool(SharedPreferenceKeys.KEY_SKIP_LOGIN) ?? false;
  }

  // Skip login screens
  static Future<void> persistMapInfo(bool seen) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setBool(SharedPreferenceKeys.KEY_MAP_INFO, seen);
    }
  }

  static bool get mapInfoSeen {
    if (!_isInitialized || _sp == null) {
      return false;
    }
    return _sp!.getBool(SharedPreferenceKeys.KEY_MAP_INFO) ?? false;
  }

  static bool get firstStart {
    if (!_isInitialized || _sp == null) {
      return true;
    }
    return _sp!.getBool(SharedPreferenceKeys.KEY_FIRST_START) ?? true;
  }

  static Future<void> persistFirstStart(bool value) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setBool(SharedPreferenceKeys.KEY_FIRST_START, value);
    }
  }

  static Future<void> deleteKeys(List<String> keys) async {
    if (_isInitialized && _sp != null) {
      await Future.wait(
        keys.map(
          (e) => _sp!.remove(e),
        ),
      );
    }
  }

  /// Generic string storage methods
  static Future<void> setString(String key, String value) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setString(key, value);
    }
  }

  static Future<String?> getString(String key) async {
    if (!_isInitialized || _sp == null) {
      return null;
    }
    return _sp!.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    if (_isInitialized && _sp != null) {
      await _sp!.setBool(key, value);
    }
  }

  static Future<bool?> getBool(String key) async {
    if (!_isInitialized || _sp == null) {
      return null;
    }
    return _sp!.getBool(key);
  }

  static Future<void> remove(String key) async {
    if (_isInitialized && _sp != null) {
      await _sp!.remove(key);
    }
  }
}
