import '../../../../../../export_files.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class ImageWithLabel extends StatelessWidget {
  const ImageWithLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(right: 36.h),
        padding: EdgeInsets.symmetric(vertical: 38.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Text(
              "lbl_sign_in".tr.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            )
          ],
        ),
      ),
    );
  }
}
