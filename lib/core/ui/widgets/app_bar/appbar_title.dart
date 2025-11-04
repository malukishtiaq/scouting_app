import 'package:flutter/material.dart';
import '../../../../export_files.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/colors.dart';

class AppbarTitle extends StatelessWidget {
  AppbarTitle({Key? key, required this.text, this.onTap, this.margin})
      : super(
          key: key,
        );

  final String text;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }
}
