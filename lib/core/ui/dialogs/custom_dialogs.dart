import 'package:flutter/material.dart';
import 'package:scouting_app/core/navigation/nav.dart';
import 'package:scouting_app/localization/app_localization.dart';

import '../../common/app_colors.dart';
import 'show_dialog.dart';

void showCustomMessageDialog({
  String? title,
  String? content,
  String? buttonText,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
  bool dissmissable = true,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    barrierDismissible: dissmissable,
    builder: (BuildContext myContext) {
      return WillPopScope(
        onWillPop: () async {
          return dissmissable;
        },
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(myContext).size.width * 0.75,
            height: MediaQuery.of(myContext).size.height * 0.30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    // fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    content ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      // fontSize: ScreenUtil().setSp(16),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (buttonText != null)
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: onButtonPressed == null
                        ? () {
                            // Navigator.of(myContext).pop();
                            Nav.pop(myContext);
                          }
                        : () {
                            onButtonPressed(myContext);
                          },
                    textColor: Theme.of(myContext).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        buttonText,
                        // style: TextStyle(
                        //   fontSize: ScreenUtil().setSp(18),
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCustomDialogWithIconDialog({
  Widget? icon,
  Color? iconBackColor,
  String? content,
  String? buttonText,
  bool? isDesmissible,
  bool? isBackPopped,
  Function(BuildContext context)? onButtonPressed,
  required BuildContext context,
}) {
  ShowDialog().showElasticDialog(
    barrierDismissible: isDesmissible ?? true,
    context: context,
    builder: (BuildContext context) {
      print("showCustomDialogWithIconDialog");
      return WillPopScope(
        onWillPop: () async {
          return isBackPopped ?? true;
        },
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    // width: ScreenUtil().setWidth(150),
                    // height: ScreenUtil().setWidth(150),
                    decoration: BoxDecoration(
                        color: iconBackColor ?? Colors.greenAccent,
                        borderRadius: BorderRadius.circular(200)),
                    child: Center(
                      child: icon ??
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    content ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      // fontSize: ScreenUtil().setSp(18),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (buttonText != null)
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: onButtonPressed == null
                        ? () {
                            // Navigator.of(context).pop();
                            Nav.pop(context);
                          }
                        : () => onButtonPressed(context),
                    textColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          // fontSize: ScreenUtil().setSp(18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<dynamic> showCustomConfirmCancelDialog({
  String? title,
  String? content,
  Function(BuildContext context)? onConfirm,
  Function(BuildContext context)? onCancel,
  bool? isDismissible,
  bool? canPop,
  String? cancelText,
  String? confirmText,
  required BuildContext mainContext,
}) async {
  return await ShowDialog().showElasticDialog(
    context: mainContext,
    barrierDismissible: isDismissible ?? true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () => Future.value(canPop ?? true),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            // width: 1.screenW * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title ?? "areYouSure".tr,
                  // style: TextThemeStyles().h4(
                  //   color: AppColors.mssPrimaryDark,
                  // ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  // height: 120.h,
                  child: Align(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          // horizontal: 16.w,
                          ),
                      child: Text(
                        content ?? '',
                        // style: TextThemeStyles().body2(
                        //   color: Colors.black,
                        // ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: onCancel != null
                          ? () => onCancel(context)
                          : () {
                              Nav.pop(context);
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          cancelText ?? "cancel".tr,
                          // style: TextThemeStyles().h6(
                          //   color: AppColors.mssPrimaryDark,
                          // ),
                        ),
                      ),
                    ),
                    // 10.horizontalSpace,
                    ElevatedButton(
                      onPressed: onConfirm != null
                          ? () => onConfirm(context)
                          : () {
                              Nav.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mssPrimaryDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        confirmText ?? "confirm".tr,
                        // style: TextThemeStyles().h6(
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

showCustomDialogWithTextField({
  required BuildContext context,
  String? labelText,
  String? hintText,
  int? minLines,
  int? maxLines,
  double? height,
  String title = '',
  Function(String text)? onConfirm,
  FormFieldValidator<String>? validator,
  TextInputAction? textInputAction,
  Color? helperTextColor,
  TextInputType? keyboardType,
}) {
  final textKey = GlobalKey<FormFieldState<String>>();
  final textController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(40),
            ),
          ),
          //scrollable: true,
          child: SizedBox(
            // width: ScreenUtil().screenWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        // fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labelText ?? "",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            // fontSize: ScreenUtil().setSp(15),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Nav.pop(context);
                          },
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              "cancel".tr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            if (textKey.currentState!.validate()) {
                              if (onConfirm != null) {
                                onConfirm(textController.text);
                              }
                              // Navigator.of(context).pop();
                              Nav.pop(context);
                            }
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              "confirm".tr,
                              // style: TextStyle(
                              //   fontSize: ScreenUtil().setSp(18),
                              //   color: Colors.white,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
