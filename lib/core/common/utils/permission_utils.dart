import 'package:scouting_app/core/common/extensions/localization_extension.dart';
import 'package:scouting_app/core/ui/widgets/flutter_target/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../ui/dialogs/permission_alert_dialog.dart';
// import '../../ui/dialogs/show_dialog.dart';
import '../app_config.dart';

enum PermissionOption {
  NoPermission,
  ForcePermission,
  DefaultPermission,
}

Future<Map<Permission, PermissionStatus>> requestPermission(
  RequestPermissionsParam param, {
  bool requestIfNotGranted = true,
}) async {
  Map<Permission, PermissionStatus> result = {};
  for (MapEntry<Permission, PermissionOption> entry in param.toMap.entries) {
    if (entry.value != PermissionOption.NoPermission) {
      final isForce = entry.value == PermissionOption.ForcePermission;
      result[entry.key] = await _requestPermission(
        entry.key,
        isForce,
        requestIfNotGranted,
      );
    }
  }
  return result;
}

Future<PermissionStatus> _requestPermission(
  Permission permission,
  bool isForce,
  bool requestIfNotGranted,
) async {
  if (!requestIfNotGranted) {
    return await permission.status;
  }

  if (await permission.isGranted) return PermissionStatus.granted;

  if (await permission.isPermanentlyDenied) {
    if (isForce) await _showDialog(permission);
    return PermissionStatus.permanentlyDenied;
  }

  PermissionStatus status = await permission.request();

  if (!isForce || status.isGranted) return status;

  while (!status.isGranted) {
    status = await permission.request();

    if (status.isPermanentlyDenied) {
      await _showDialog(permission);
      break;
    }
  }
  return status;
}

Future<dynamic> _showDialog(Permission permission) async {
  // await ShowDialog().showElasticDialog(
  //   context: AppConfig().appContext!,
  //   barrierDismissible: false,
  //   builder: (context) => PermissionAlertDialog(
  //     permissionName: _getTranslatedPermissionName(context, permission),
  //   ),
  // );
  return showAppBottomSheet(
    context: AppConfig().appContext!,
    builder: (context) {
      final permissionName = _getTranslatedPermissionName(context, permission);
      return AppBottomSheet(
        title: "accessDenied".tr,
        buttonText: "openAppSettings".tr,
        onButtonPressed: (index) async {
          await openAppSettings();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              permissionName != null
                  ? "specificPermissionRequired"
                      .trWithArgs({"permissionName": permissionName})
                  : "permissionRequiredTitle".tr,
              // style: TextThemeStyles().body2(
              //   color: AppColors.mssNeutral100,
              // ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              permissionName != null
                  ? "makeSureSpecificPermissionGranted"
                      .trWithArgs({"permissionName": permissionName})
                  : "permissionRequiredMessage".tr,
              // style: TextThemeStyles().body3(
              //   color: AppColors.mssNeutral100,
              // ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "tryEnablingItFromYourPhoneSettings".tr,
              // style: TextThemeStyles().body3(
              //   color: AppColors.mssNeutral100,
              // ),
            ),
          ],
        ),
      );
    },
  );
}

class RequestPermissionsParam {
  final PermissionOption camera;
  final PermissionOption contacts;
  final PermissionOption location;
  final PermissionOption locationAlways;
  final PermissionOption locationWhenInUse;
  final PermissionOption mediaLibrary;
  final PermissionOption microphone;
  final PermissionOption phone;
  final PermissionOption photos;
  final PermissionOption photosAddOnly;
  final PermissionOption reminders;
  final PermissionOption storage;
  final PermissionOption notification;
  final PermissionOption accessMediaLocation;
  final PermissionOption manageExternalStorage;
  final PermissionOption requestInstallPackages;
  final PermissionOption appTrackingTransparency;
  final PermissionOption accessNotificationPolicy;

  const RequestPermissionsParam({
    this.camera = PermissionOption.NoPermission,
    this.contacts = PermissionOption.NoPermission,
    this.location = PermissionOption.NoPermission,
    this.locationAlways = PermissionOption.NoPermission,
    this.locationWhenInUse = PermissionOption.NoPermission,
    this.mediaLibrary = PermissionOption.NoPermission,
    this.microphone = PermissionOption.NoPermission,
    this.phone = PermissionOption.NoPermission,
    this.photos = PermissionOption.NoPermission,
    this.photosAddOnly = PermissionOption.NoPermission,
    this.reminders = PermissionOption.NoPermission,
    this.storage = PermissionOption.NoPermission,
    this.notification = PermissionOption.NoPermission,
    this.accessMediaLocation = PermissionOption.NoPermission,
    this.manageExternalStorage = PermissionOption.NoPermission,
    this.requestInstallPackages = PermissionOption.NoPermission,
    this.appTrackingTransparency = PermissionOption.NoPermission,
    this.accessNotificationPolicy = PermissionOption.NoPermission,
  });

  Map<Permission, PermissionOption> get toMap => {
        Permission.camera: camera,
        Permission.contacts: contacts,
        Permission.location: location,
        Permission.locationAlways: locationAlways,
        Permission.locationWhenInUse: locationWhenInUse,
        Permission.mediaLibrary: mediaLibrary,
        Permission.microphone: microphone,
        Permission.phone: phone,
        Permission.photos: photos,
        Permission.photosAddOnly: photosAddOnly,
        Permission.reminders: reminders,
        Permission.storage: storage,
        Permission.notification: notification,
        Permission.accessMediaLocation: accessMediaLocation,
        Permission.manageExternalStorage: manageExternalStorage,
        Permission.requestInstallPackages: requestInstallPackages,
        Permission.appTrackingTransparency: appTrackingTransparency,
        Permission.accessNotificationPolicy: accessNotificationPolicy,
      };
}

String? _getTranslatedPermissionName(
  BuildContext context,
  Permission permission,
) {
  if (permission == Permission.location ||
      permission == Permission.locationAlways ||
      permission == Permission.locationWhenInUse) {
    return "locationPermission".tr;
  } else if (permission == Permission.camera) {
    return "cameraPermission".tr;
  } else {
    return null;
  }
}
