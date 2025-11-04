import 'package:scouting_app/core/constants/app/app_constants.dart';
import 'package:scouting_app/core/ui/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../custom_scaffold.dart';

class AppScaffold extends StatelessWidget {
  // final MssAppBar? appBar;
  final Widget body;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final bool showPattern;

  const AppScaffold({
    super.key,
    // this.appBar,
    required this.body,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.showPattern = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // appBar: appBar,
      backgroundColor: backgroundColor ?? AppColors.mssBackgroud,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      body: showPattern
          ? Stack(
              children: [
                Positioned.fill(
                  child: body,
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Align(
                      child: CustomImage.asset(
                        AppConstants.APP_LOGO,
                        // height: 1.sh,
                        // width: 1.sw,
                        repeat: ImageRepeat.repeat,
                        color: AppColors.mssNeutral65,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : body,
    );
  }
}
