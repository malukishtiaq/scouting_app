import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
  // Check for Internet connection
  static Future<bool> checkConnectivity() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult != ConnectivityResult.none;
    } catch (exception) {
      displayReportResultTrack(exception);
      return false;
    }
  }

  // Check for Network Speed
  static Future<bool> checkNetworkSpeed() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        // In Flutter, we can't get exact network speed
        // But we can check connection type
        return true;
      }
      return false;
    } catch (exception) {
      displayReportResultTrack(exception);
      return false;
    }
  }

  // Check Network Type
  static Future<String?> checkTypeNetwork() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      switch (connectivityResult) {
        case ConnectivityResult.mobile:
          return "Mobile";
        case ConnectivityResult.wifi:
          return "Wifi";
        default:
          return null;
      }
    } catch (exception) {
      displayReportResultTrack(exception);
      return null;
    }
  }

  // Display Error Reports
  static void displayReportResultTrack(dynamic exception,
      {String memberName = "",
      String sourceFilePath = "",
      int sourceLineNumber = 0}) {
    try {
      if (!exception.toString().contains("com.android.okhttp") &&
          !exception.toString().contains("while sending the request")) {
        debugPrint(
            "\n ========================= ReportMode Start ========================= \n");
        debugPrint("ReportMode >> Message: ${exception.toString()}");
        debugPrint("ReportMode >> Member name: $memberName");
        debugPrint("ReportMode >> Source file path: $sourceFilePath");
        debugPrint("ReportMode >> Source line number: $sourceLineNumber");
        debugPrint(
            "\n ========================= ReportMode End ========================= \n");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Set Focus
  static void setFocusable(FocusNode focusNode) {
    try {
      if (focusNode != null) {
        focusNode.requestFocus();
      }
    } catch (e) {
      displayReportResultTrack(e);
    }
  }

  // Get Timestamp
  static String getTimestamp(DateTime value) {
    try {
      return DateTime.now().millisecondsSinceEpoch.toString();
    } catch (e) {
      displayReportResultTrack(e);
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  // App State Management
  static String appState = "Foreground";

  static void handleAppLifecycleState(AppLifecycleState state) {
    try {
      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.detached ||
          state == AppLifecycleState.inactive) {
        appState = "Background";
      } else {
        appState = "Foreground";
      }
    } catch (e) {
      displayReportResultTrack(e);
    }
  }

  static Future<void> setTheme(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isDark", isDark);
    } catch (e) {
      displayReportResultTrack(e);
    }
  }

  static Future<bool> isTabDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDark") ?? false;
  }
}
