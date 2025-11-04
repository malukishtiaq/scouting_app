import 'package:flutter/material.dart';

/// Beautiful Modern Color Scheme for WoWonder App
/// Designed for optimal user experience and visual appeal
class AppColors {
  // ===== PRIMARY BRAND COLORS =====
  // Extracted from Figma Scout App design - Google/Primary buttons
  static const Color primary =
      Color(0xFF0A73D9); // Figma: Bright blue button (#0A73D9)
  static const Color primaryLight = Color(0xFF3D8FE0); // Lighter blue (kept)
  static const Color primaryDark = Color(0xFF0D5AA8); // Darker blue (kept)
  static const Color primaryContainer =
      Color(0xFFE3F2FD); // Light blue container (kept)

  // ===== ACCENT COLORS =====
  // Vibrant accent colors for highlights and CTAs
  static const Color accent = Color(0xFFEC4899); // Pink 500
  static const Color accentLight = Color(0xFFF472B6); // Pink 400
  static const Color accentDark = Color(0xFFDB2777); // Pink 600
  static const Color accentContainer = Color(0xFFFCE7F3); // Pink 100

  // ===== BACKGROUND COLORS =====
  // Extracted from Figma Scout App design (node 6-245)
  static const Color background =
      Color(0xFFF6F7F8); // background-light (kept for compatibility)
  static const Color backgroundDark =
      Color(0xFF0F1A23); // Figma: Main screen background (#0F1A23)
  static const Color surface =
      Color(0xFF213549); // Figma: Social buttons background (#213549)
  static const Color surfaceVariant =
      Color(0xFF172633); // Figma: Input field background (#172633)
  static const Color cardBackground = Color(0xFF213549); // Dark card background
  static const Color cardBackgroundElevated = Color(0xFF172633);

  // ===== TEXT COLORS =====
  // Extracted from Figma Scout App design
  static const Color textPrimary =
      Color(0xFFFFFFFF); // Figma: White text (#FFFFFF)
  static const Color textSecondary =
      Color(0xFFD1D5DB); // Light gray for secondary text (kept)
  static const Color textTertiary =
      Color(0xFF8FADCC); // Figma: Placeholder text (#8FADCC)
  static const Color textHint =
      Color(0xFF8FADCC); // Figma: Placeholder text (#8FADCC)
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // ===== BUTTON COLORS =====
  // Matching HTML design button colors
  static const Color buttonPrimary =
      Color(0xFF1173D4); // Primary blue from HTML
  static const Color buttonPrimaryHover =
      Color(0xFF0D5AA8); // Darker blue on hover
  static const Color buttonSecondary = Color(0xFF64748B); // Cool gray 500
  static const Color buttonSecondaryHover = Color(0xFF475569); // Cool gray 600
  static const Color buttonOutline = Color(0xFF1173D4); // Primary blue
  static const Color buttonDisabled = Color(0xFFCBD5E1); // Cool gray 300
  static const Color buttonSuccess = Color(0xFF10B981); // Emerald 500
  static const Color buttonWarning = Color(0xFFF59E0B); // Amber 500
  static const Color buttonError = Color(0xFFEF4444); // Red 500

  // ===== BORDER COLORS =====
  // Extracted from Figma Scout App design
  static const Color borderLight =
      Color(0xFF304D69); // Figma: Input field border (#304D69)
  static const Color borderMedium = Color(0xFF6B7280); // Medium gray (kept)
  static const Color borderDark =
      Color(0xFF9CA3AF); // Light gray for dark theme (kept)
  static const Color borderFocus =
      Color(0xFF8FADCC); // Figma: Blue focus ring (#8FADCC)

  // ===== STATUS COLORS =====
  // Clear, accessible status indicators
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successLight = Color(0xFFD1FAE5); // Emerald 100
  static const Color successDark = Color(0xFF059669); // Emerald 600
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningLight = Color(0xFFFEF3C7); // Amber 100
  static const Color warningDark = Color(0xFFD97706); // Amber 600
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color errorLight = Color(0xFFFEE2E2); // Red 100
  static const Color errorDark = Color(0xFFDC2626); // Red 600
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color infoLight = Color(0xFFDBEAFE); // Blue 100
  static const Color infoDark = Color(0xFF2563EB); // Blue 600

  // ===== SOCIAL MEDIA COLORS =====
  // Brand-accurate social media colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color google = Color(0xFFDB4437);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color linkedin = Color(0xFF0077B5);
  static const Color instagram = Color(0xFFE4405F);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color youtube = Color(0xFFFF0000);

  // ===== SHADOW COLORS =====
  // Modern shadow system for depth
  static const Color shadowLight = Color(0x0A000000); // 4% opacity
  static const Color shadowMedium = Color(0x14000000); // 8% opacity
  static const Color shadowDark = Color(0x1F000000); // 12% opacity
  static const Color shadowColored =
      Color(0x1A6366F1); // Indigo with 10% opacity

  // ===== TRANSPARENT COLORS =====
  static const Color transparent = Color(0x00000000);
  static const Color semiTransparent = Color(0x80000000);
  static const Color overlay = Color(0x66000000); // 40% opacity

  // ===== NEWSFEED SPECIFIC COLORS =====
  // Modern, polished colors for newsfeed components
  static const Color storyGradientStart = Color(0xFF6366F1); // Indigo 500
  static const Color storyGradientEnd = Color(0xFFEC4899); // Pink 500
  static const Color postCardBackground = Color(0xFFFFFFFF);
  static const Color postCardBorder =
      Color(0xFFF1F5F9); // Very light gray for subtle borders
  static const Color postInteractionActive = Color(0xFFEC4899); // Pink 500
  static const Color postInteractionInactive =
      Color(0xFF64748B); // Cool gray 500
  static const Color filterActive = Color(0xFF6366F1); // Indigo 500
  static const Color filterInactive = Color(0xFFCBD5E1); // Cool gray 300

  // Enhanced post card colors
  static const Color postCardShadow = Color(0x08000000); // Very subtle shadow
  static const Color postHeaderBackground =
      Color(0xFFFAFBFC); // Light background for header
  static const Color postTextPrimary =
      Color(0xFF1E293B); // Darker text for better readability
  static const Color postTextSecondary =
      Color(0xFF64748B); // Medium gray for secondary text
  static const Color postTextTertiary =
      Color(0xFF94A3B8); // Light gray for timestamps

  // ===== LEGACY COMPATIBILITY COLORS =====
  // Keep these for backward compatibility with existing components
  static const Color weatherBackground = Color(0xFFE0F2FE); // Blue 50
  static const Color whiteRadius = Color(0xFFFFFFFF);
  static const Color windowBackground = Color(0xFFFAFBFC); // Cool gray 50
  static const Color storyRoundColor = Color(0xFFE0E7FF); // Indigo 100
  static const Color socialBgCircleDotted = Color(0xFFFCE7F3); // Pink 100
  static const Color roundGrayBorder = Color(0xFFE2E8F0); // Cool gray 200
  static const Color roundTrans = Color(0x00000000);
  static const Color roundStrokeTrans = Color(0x00000000);

  // Profile Shadow Colors
  static const Color profileShadowSocial = Color(0x0A000000); // 4% opacity

  // Progress Bar Colors
  static const Color primaryProgress = Color(0xFF6366F1); // Indigo 500
  static const Color secondaryProgress = Color(0xFFE2E8F0); // Cool gray 200

  // Tab Indicator Colors
  static const Color selectedDot = Color(0xFF6366F1); // Indigo 500
  static const Color defaultDot = Color(0xFFE2E8F0); // Cool gray 200

  // Checkbox Colors
  static const Color checkboxSelected = Color(0xFF6366F1); // Indigo 500
  static const Color checkboxUnselected = Color(0xFFE2E8F0); // Cool gray 200

  // Circle Shadow Colors
  static const Color circleShadow =
      Color(0x1A6366F1); // Indigo with 10% opacity

  // Button State Colors
  static const Color buttonPressed = Color(0xFF4F46E5); // Indigo 600
  static const Color buttonNormal = Color(0xFF6366F1); // Indigo 500
  static const Color buttonGradient = Color(0xFF818CF8); // Indigo 400

  // Message Colors
  static const Color messageOutline = Color(0xFF6366F1); // Indigo 500
  static const Color recvBgMic = Color(0xFFE0F2FE); // Blue 50
  static const Color recvIcArrow = Color(0xFF6366F1); // Indigo 500
  static const Color recvIcDelete = Color(0xFFEF4444); // Red 500

  // Post Icon Colors
  static const Color postIconMusicalNotes = Color(0xFF8B5CF6); // Violet 500
  static const Color postIconPin = Color(0xFFEF4444); // Red 500
  static const Color postIconAirplane = Color(0xFF3B82F6); // Blue 500
  static const Color postIconEye = Color(0xFF10B981); // Emerald 500
  static const Color postIconFlash = Color(0xFFF59E0B); // Amber 500
  static const Color postIconGameController = Color(0xFF8B5CF6); // Violet 500

  // Price Colors
  static const Color priceGoproItemStyle = Color(0xFF6366F1); // Indigo 500
  static const Color priceGoproItemStyleDark = Color(0xFF4F46E5); // Indigo 600

  // Native Button Colors
  static const Color nativeMedButtonColor = Color(0xFF6366F1); // Indigo 500

  // Linear Gradient Colors
  static const Color linearGradientDark = Color(0xFF475569); // Cool gray 600

  // Login Colors
  static const Color loginRound = Color(0xFFFFFFFF);

  // Icon Colors
  static const Color iconWarningFill = Color(0xFFF59E0B); // Amber 500
  static const Color iconVolumeOff = Color(0xFF64748B); // Cool gray 500
  static const Color iconVolumeUp = Color(0xFF6366F1); // Indigo 500
  static const Color iconUserAdd = Color(0xFF10B981); // Emerald 500
  static const Color iconUser = Color(0xFF6366F1); // Indigo 500
  static const Color iconVideoCamera = Color(0xFFEC4899); // Pink 500
  static const Color iconVideoCameraMute = Color(0xFF64748B); // Cool gray 500
  static const Color iconTrendingUp = Color(0xFF10B981); // Emerald 500
  static const Color iconTwitter = Color(0xFF1DA1F2);
  static const Color iconUnmute = Color(0xFF10B981); // Emerald 500
  static const Color iconUpload = Color(0xFF3B82F6); // Blue 500
  static const Color iconSwap = Color(0xFFF59E0B); // Amber 500
  static const Color iconSwitchCamera = Color(0xFF8B5CF6); // Violet 500
  static const Color iconTabUser = Color(0xFF6366F1); // Indigo 500
  static const Color iconYoutube = Color(0xFFFF0000);
  static const Color iconWallpaper = Color(0xFF8B5CF6); // Violet 500
  static const Color iconWebsite = Color(0xFF3B82F6); // Blue 500
  static const Color iconWork = Color(0xFF78716C); // Stone 500
  static const Color iconVideoPlayer = Color(0xFFEC4899); // Pink 500
  static const Color iconVideoReels = Color(0xFF8B5CF6); // Violet 500
  static const Color iconVk = Color(0xFF4C75A3);

  // ===== XAMARIN COMPATIBILITY COLORS =====
  // Keep these for backward compatibility with Xamarin components
  static const Color xamarinPrimary = Color(0xFF6366F1); // Indigo 500
  static const Color xamarinAccent = Color(0xFFEC4899); // Pink 500
  static const Color xamarinPrimaryDark = Color(0xFF4F46E5); // Indigo 600
  static const Color xamarinPrimaryLight = Color(0xFFE0E7FF); // Indigo 100
  static const Color xamarinAccentLight = Color(0xFFFCE7F3); // Pink 100
  static const Color xamarinBgApp = Color(0xFFFAFBFC); // Cool gray 50
  static const Color xamarinBgAppDark = Color(0xFF0F172A); // Cool gray 900
  static const Color xamarinTextDark = Color(0xFF0F172A); // Cool gray 900
  static const Color xamarinTextInBetween = Color(0xFF64748B); // Cool gray 500
  static const Color xamarinLightColor = Color(0xFFF8FAFC); // Cool gray 25
  static const Color xamarinColorReact = Color(0xFF94A3B8); // Cool gray 400
  static const Color xamarinColorFill = Color(0xFFFFFFFF);
  static const Color xamarinColorBubble = Color(0xFFF8FAFC); // Cool gray 25
  static const Color xamarinGntWhite = Color(0xFFFFFFFF);
  static const Color xamarinTransparentDark = Color(0x66000000); // 40% opacity
  static const Color xamarinShimmerColor = Color(0xFFCBD5E1); // Cool gray 300

  // Xamarin Login Background Gradient Colors (Modernized)
  static const Color xamarinBgGradient1 = Color(0xFF0F172A); // Cool gray 900
  static const Color xamarinBgGradient2 = Color(0xFF1E293B); // Cool gray 800
  static const Color xamarinBgGradient3 = Color(0xFF334155); // Cool gray 700
  static const Color xamarinBgGradient4 = Color(0xFF475569); // Cool gray 600
  static const Color xamarinBgGradient5 = Color(0xFF64748B); // Cool gray 500
  static const Color xamarinBgGradientAccent = Color(0xFF4F46E5); // Indigo 600
}
