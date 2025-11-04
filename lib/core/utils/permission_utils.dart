import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionUtils {
  /// Request file access permissions
  static Future<bool> requestFileAccessPermissions() async {
    try {
      // For Android 13+ (API 33+), use granular media permissions
      if (await _isAndroid13OrHigher()) {
        final permissions = [
          Permission.photos,
          Permission.videos,
          Permission.audio,
        ];

        final statuses = await permissions.request();

        // Check if all permissions are granted
        bool allGranted = statuses.values
            .every((status) => status == PermissionStatus.granted);

        if (allGranted) {
          return true;
        }

        // If not all granted, try legacy storage permission
        final storageStatus = await Permission.storage.request();
        return storageStatus == PermissionStatus.granted;
      } else {
        // For older Android versions, use storage permission
        final storageStatus = await Permission.storage.request();
        return storageStatus == PermissionStatus.granted;
      }
    } catch (e) {
      print('🔍 PermissionUtils: Error requesting permissions: $e');
      return false;
    }
  }

  /// Check if file access permissions are granted
  static Future<bool> hasFileAccessPermissions() async {
    try {
      if (await _isAndroid13OrHigher()) {
        final permissions = [
          Permission.photos,
          Permission.videos,
          Permission.audio,
        ];

        final statuses = await permissions.request();

        // Check if all permissions are granted
        return statuses.values
            .every((status) => status == PermissionStatus.granted);
      } else {
        final storageStatus = await Permission.storage.status;
        return storageStatus == PermissionStatus.granted;
      }
    } catch (e) {
      print('🔍 PermissionUtils: Error checking permissions: $e');
      return false;
    }
  }

  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      print('🔍 PermissionUtils: Error requesting camera permission: $e');
      return false;
    }
  }

  /// Check if camera permission is granted
  static Future<bool> hasCameraPermission() async {
    try {
      final status = await Permission.camera.status;
      return status == PermissionStatus.granted;
    } catch (e) {
      print('🔍 PermissionUtils: Error checking camera permission: $e');
      return false;
    }
  }

  /// Show permission dialog with explanation
  static Future<void> showPermissionDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onGranted,
    VoidCallback? onDenied,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                onDenied?.call();
              },
            ),
            TextButton(
              child: const Text('Grant Permission'),
              onPressed: () {
                Navigator.of(context).pop();
                onGranted();
              },
            ),
          ],
        );
      },
    );
  }

  /// Request all necessary permissions for media access
  static Future<bool> requestAllMediaPermissions() async {
    try {
      // Request camera permission
      final cameraGranted = await requestCameraPermission();

      // Request file access permissions
      final fileAccessGranted = await requestFileAccessPermissions();

      return cameraGranted && fileAccessGranted;
    } catch (e) {
      print('🔍 PermissionUtils: Error requesting all permissions: $e');
      return false;
    }
  }

  /// Check if all necessary permissions are granted
  static Future<bool> hasAllMediaPermissions() async {
    try {
      final cameraGranted = await hasCameraPermission();
      final fileAccessGranted = await hasFileAccessPermissions();

      return cameraGranted && fileAccessGranted;
    } catch (e) {
      print('🔍 PermissionUtils: Error checking all permissions: $e');
      return false;
    }
  }

  /// Open app settings for manual permission granting
  static Future<void> openAppSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      print('🔍 PermissionUtils: Error opening app settings: $e');
    }
  }

  /// Check if device is Android 13 or higher
  static Future<bool> _isAndroid13OrHigher() async {
    try {
      // This is a simplified check - in a real app you might want to use
      // device_info_plus package to get exact Android version
      return true; // Assume Android 13+ for now
    } catch (e) {
      return false;
    }
  }
}
