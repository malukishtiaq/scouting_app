import 'package:scouting_app/export_files.dart';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../theme/app_text_styles.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    required this.isLoading,
    required this.child,
    this.message = 'Loading...',
  });

  final bool isLoading;
  final Widget child;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: isLoading ? 0.25 : 1,
            child: child,
          ),
        ),
        if (isLoading) ...[
          Positioned.fill(
            child: Container(
              color: AppColors.primary.withOpacity(0.25),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CustomImageView(
                      imagePath: 'assets/images/icons/logo.webp',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: AppTextStyles.h2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
