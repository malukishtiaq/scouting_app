import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

/// Standardized Text Styles for Scouting App
/// Font: Plus Jakarta Sans (matching HTML design)
/// Font weights: 400 (normal), 500 (medium), 700 (bold), 800 (extra bold)
class AppTextStyles {
  // Base font family
  static String get fontFamily => 'Plus Jakarta Sans';

  // ===== HEADLINES =====
  static TextStyle h1 = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w800, // Extra bold from HTML
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle h2 = GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.w700, // Bold from HTML
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle h3 = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle h4 = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle h5 = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle h6 = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  // ===== BODY TEXT =====
  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // ===== CAPTION =====
  static TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textTertiary,
  );

  // ===== LABELS =====
  static TextStyle labelLarge = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium from HTML
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static TextStyle labelSmall = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  // ===== BUTTONS =====
  static TextStyle buttonLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w700, // Bold from HTML
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
  );

  static TextStyle buttonMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semibold from HTML
    letterSpacing: 0.25,
    color: AppColors.textOnPrimary,
  );

  static TextStyle buttonSmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
  );

  // ===== SPECIAL STYLES =====
  static TextStyle appBarTitle = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppColors.textOnPrimary,
  );

  static TextStyle cardTitle = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle errorText = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.error,
  );

  static TextStyle successText = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.success,
  );

  static TextStyle linkText = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // ===== SPLASH SCREEN SPECIFIC =====
  static TextStyle splashAppName = GoogleFonts.plusJakartaSans(
    fontSize: 36,
    fontWeight: FontWeight.w800, // Extra bold for app name
    letterSpacing: 1.5,
    color: AppColors.textOnPrimary,
  );

  static TextStyle splashTagline = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.8,
    color: AppColors.textOnPrimary,
  );

  // ===== OVERLAY STYLES (for different backgrounds) =====
  static TextStyle get bodyMediumOnPrimary => bodyMedium.copyWith(
        color: AppColors.textOnPrimary,
      );

  static TextStyle get bodyMediumOnAccent => bodyMedium.copyWith(
        color: AppColors.textOnAccent,
      );

  static TextStyle get bodyMediumSecondary => bodyMedium.copyWith(
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyMediumTertiary => bodyMedium.copyWith(
        color: AppColors.textTertiary,
      );
}
