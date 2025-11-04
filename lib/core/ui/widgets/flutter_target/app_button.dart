import 'package:scouting_app/core/common/app_colors.dart';
import 'package:scouting_app/core/constants/app/app_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final String? buttonText;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  final bool isCircularShape;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color forgroundColor;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final BorderSide? borderSide;
  final bool hasTransparentBackground;
  final Size? fixedSize;

  const AppButton({
    super.key,
    this.child,
    this.icon,
    this.buttonText,
    this.textStyle,
    this.isCircularShape = false,
    this.padding,
    required this.onPressed,
    this.backgroundColor,
    this.surfaceTintColor,
    this.forgroundColor = Colors.white,
    this.borderRadius,
    this.elevation,
    this.borderSide,
    this.hasTransparentBackground = false,
    this.fixedSize,
  }) : assert(
          (child == null) ^ (buttonText == null),
          "child or buttonText must be null",
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AppConstants.appShadow],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize,
          elevation: elevation ?? 0,
          disabledBackgroundColor: (backgroundColor ?? AppColors.primaryColor),
          shape: isCircularShape
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(8),
                  side: borderSide ?? BorderSide.none,
                ),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          surfaceTintColor: hasTransparentBackground
              ? null
              : surfaceTintColor ?? backgroundColor ?? AppColors.primaryColor,
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 13,
              ),
        ),
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  // 10.horizontalSpace,
                ],
                Text(buttonText ?? '', style: textStyle
                    // ??
                    //     TextThemeStyles().h6(
                    //       color: forgroundColor,
                    //     ),
                    ),
              ],
            ),
      ),
    );
  }
}
