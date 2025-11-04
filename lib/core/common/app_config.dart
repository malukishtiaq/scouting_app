import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting_app/core/common/app_options/app_options.dart';
import 'package:scouting_app/core/common/local_storage.dart';
import 'package:scouting_app/core/constants/enums/system_type.dart';
import 'package:scouting_app/core/localization/flutter_localization.dart';
import 'package:scouting_app/core/navigation/navigation_service.dart';
import 'package:scouting_app/di/service_locator.dart';

/// This class it contain multiple core functions
/// for get device info
/// for get and set language
/// for current app theme
/// for options in application
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  final String apiKey = "";
  SystemType? _os;
  String? _currentVersion;
  late String _buildNumber;
  String? _appName;
  String? _appVersion;
  ThemeMode themeMode = ThemeMode.dark;
  bool locationPermissionGranted = false;
  final AppOptions _appOptions = AppOptions();

  BuildContext? get appContext => getIt<NavigationService>().appContext;

  Locale get appLanguage => LocalizationProvider().appLocal;

  SystemType? get os => _os;

  String? get currentVersion => _currentVersion;

  String get buildNumber => _buildNumber;

  String? get appVersion => _appVersion;

  String? get appName => _appName;

  AppOptions get appOptions => _appOptions;

  ThemeData get themeData => ThemeData.dark();

  bool isMobile() {
    try {
      final mediaQuery = appContext == null ? null : MediaQuery.of(appContext!);
      final smallestWidth = mediaQuery?.size.shortestSide;
      return smallestWidth == null ? false : smallestWidth < 600;
    } catch (e) {
      return false;
    }
  }

  bool isTablet() {
    try {
      final mediaQuery = appContext == null ? null : MediaQuery.of(appContext!);
      final smallestWidth = mediaQuery?.size.shortestSide;
      return smallestWidth == null ? false : smallestWidth < 840;
    } catch (e) {
      return false;
    }
  }

  bool isLaptop() {
    try {
      final mediaQuery = appContext == null ? null : MediaQuery.of(appContext!);
      final smallestWidth = mediaQuery?.size.shortestSide;
      return smallestWidth == null ? false : smallestWidth < 900;
    } catch (e) {
      return false;
    }
  }

  bool isScreen() {
    try {
      final mediaQuery = appContext == null ? null : MediaQuery.of(appContext!);
      final smallestWidth = mediaQuery?.size.shortestSide;
      return smallestWidth == null ? false : smallestWidth >= 900;
    } catch (e) {
      return false;
    }
  }

  bool get isLoggedIn => LocalStorage.hasToken;

  String? deviceId;

  Future<String?> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    String? device_id;
    if (kIsWeb) {
      device_id = null;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device_id = iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device_id = androidInfo.id;
    }
    return device_id;
  }

  Future<Uint8List?> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  late String mapStyle;
  bool isNativePaySupported = false;

  Future<void> initApp() async {
    /// get OS
    if (kIsWeb) {
      _os = SystemType.Web;
    } else if (Platform.isIOS) {
      _os = SystemType.IOS;
    } else if (Platform.isAndroid) {
      _os = SystemType.Android;
    }

    /// get version package info etc

    themeMode = LocalStorage.getThemeMode;

    deviceId = await _getDeviceId();
  }

  static Size screenUtilDesignSize() {
    if (AppConfig().isMobile()) return const Size(375, 812);
    if (AppConfig().isTablet()) return const Size(810, 1080);
    if (AppConfig().isLaptop()) return const Size(768, 1366);
    if (AppConfig().isScreen()) return const Size(1440, 2560);

    return const Size(375, 812);
  }

  static void clearNotificationSystemCount() {}
}
