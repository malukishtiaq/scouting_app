import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'app_dimensions.dart';

/// Standardized Decorations for Social Bee App
/// Use these decorations throughout the entire app for consistency
class AppDecorations {
  // ===== CARDS =====
  static BoxDecoration get card => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      );

  static BoxDecoration get cardElevated => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, AppDimensions.shadowOffsetLarge),
          ),
        ],
      );

  // ===== BUTTONS =====
  static BoxDecoration get primaryButton => BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColored,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      );

  static BoxDecoration get secondaryButton => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.primary, width: 1.5),
      );

  static BoxDecoration get outlineButton => BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderMedium, width: 1.0),
      );

  // ===== INPUT FIELDS =====
  static BoxDecoration get inputField => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
      );

  static BoxDecoration get inputFieldFocused => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderFocus, width: 2.0),
      );

  static BoxDecoration get inputFieldError => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.error, width: 1.0),
      );

  // ===== AVATARS =====
  static BoxDecoration get avatar => BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
      );

  static BoxDecoration get avatarWithShadow => BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      );

  // ===== SPLASH SCREEN =====
  static BoxDecoration get splashLogo => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColored,
            blurRadius: AppDimensions.shadowBlurXLarge,
            offset: const Offset(0, AppDimensions.shadowOffsetLarge),
          ),
        ],
      );

  // ===== GRADIENTS =====
  static BoxDecoration get primaryGradient => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
            AppColors.accent,
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      );

  static BoxDecoration get accentGradient => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent,
            AppColors.accentDark,
          ],
        ),
      );

  // ===== DIVIDERS =====
  static BoxDecoration get divider => BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(AppDimensions.dividerThickness / 2),
      );

  static BoxDecoration get dividerThick => BoxDecoration(
        color: AppColors.borderMedium,
        borderRadius:
            BorderRadius.circular(AppDimensions.dividerThicknessThick / 2),
      );

  // ===== STATUS INDICATORS =====
  static BoxDecoration get successIndicator => BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: AppColors.success, width: 1.0),
      );

  static BoxDecoration get errorIndicator => BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: AppColors.error, width: 1.0),
      );

  static BoxDecoration get warningIndicator => BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: AppColors.warning, width: 1.0),
      );

  static BoxDecoration get infoIndicator => BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        border: Border.all(color: AppColors.info, width: 1.0),
      );

  // ===== CONTAINERS =====
  static BoxDecoration get container => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      );

  static BoxDecoration get containerWithBorder => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
      );

  static BoxDecoration get containerElevated => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      );
}
