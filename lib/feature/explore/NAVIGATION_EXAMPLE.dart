import 'package:flutter/material.dart';
import '../../core/navigation/nav.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';
import '../../localization/app_localization.dart';

/// Example widget showing how to navigate to the Explore Screen
/// 
/// Usage:
/// ```dart
/// // Navigate to explore screen
/// Nav.to('/explore');
/// 
/// // Or using the route name constant
/// Nav.to(ExploreScreen.routeName);
/// ```
class ExploreNavigationExample extends StatelessWidget {
  const ExploreNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        title: Text(
          'Navigation Example',
          style: AppTextStyles.h5.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing24),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to explore screen
              Nav.to('/explore');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                AppDimensions.buttonHeightLarge,
              ),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
            ),
            child: Text(
              'go_to_explore'.tr,
              style: AppTextStyles.buttonMedium,
            ),
          ),
        ),
      ),
    );
  }
}

