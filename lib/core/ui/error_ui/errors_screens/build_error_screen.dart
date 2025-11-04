import 'package:scouting_app/core/common/app_colors.dart';
import 'package:scouting_app/core/ui/widgets/flutter_target/app_button.dart';
import 'package:scouting_app/core/ui/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scouting_app/core/common/app_config.dart';
import 'package:scouting_app/core/constants/enums/app_options_enum.dart';
import 'package:scouting_app/localization/app_localization.dart';

Widget buildErrorScreen({
  required BuildContext context,
  @required VoidCallback? callback,
  bool disableRetryButton = false,
  String? title,
  String? content,
  String? imageUrl,
  String? buttonContent,
  IconData? icon,
  ErrorAnimation? errorAnimation,
}) {
  final options = AppConfig().appOptions;

  Widget image = const SizedBox.shrink();
  switch (options.errorViewOption) {
    case ErrorWidgetOptions.IMAGE:
      if (imageUrl != null && imageUrl != "") {
        image = CustomImage.asset(
          imageUrl,
          height: 162,
          fit: BoxFit.contain,
        );
      }
      // image = Image.asset(imageUrl);
      break;
    case ErrorWidgetOptions.LOTTIE:
      if (errorAnimation != null) {
        image = SizedBox(
          height: 500,
          width: 500,
          child: GestureDetector(
            onTap: () async {
              if (!errorAnimation.animationController.isAnimating) {
                errorAnimation.animationController.reset();
                errorAnimation.animationController.forward();
              }
            },
            child: Lottie.asset(
              errorAnimation.animUrl,
              controller: errorAnimation.animationController,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                errorAnimation.animationController
                  ..duration = composition.duration
                  ..forward();
              },
              repeat: false,
            ),
          ),
        );
      }
      break;
    case ErrorWidgetOptions.NONE:
      image = const SizedBox.shrink();
      break;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 30, //.screenHorizontalPadding,
      vertical: 35,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            // width: .8.sw,
            child: image,
          ),
        ),
        if (title != null)
          const SizedBox(
            height: 37,
          ),
        if (title != null)
          Text(
            title,
            // style: TextThemeStyles().h4(
            //   color: AppColors.mssPrimaryDark,
            // ),
            textAlign: TextAlign.center,
          ),
        if (content != null) ...[
          const SizedBox(
            height: 17,
          ),
          Container(
            // width: .8.sw,
            // constraints: BoxConstraints(
            //   maxHeight: .3.sh,
            //   minHeight: .1.sh,
            // ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                content,
                // style: TextThemeStyles().body2(
                //   color: AppColors.mssNeutral80,
                // ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        // 17.verticalSpace,
        const SizedBox(
          height: 17,
        ),
        if (disableRetryButton == false && callback != null)
          AppButton(
            onPressed: callback,
            buttonText: buttonContent ?? "retry".tr,
            backgroundColor: AppColors.mssOrange,
            padding: const EdgeInsets.symmetric(
              horizontal: 35, //.w,
              vertical: 10,
            ),
          ),
        // AppConstants.navbarHeight.verticalSpace,
      ],
    ),
  );
}

class ErrorAnimation {
  final String animUrl;
  final AnimationController animationController;

  ErrorAnimation({
    required this.animUrl,
    required this.animationController,
  });
}
