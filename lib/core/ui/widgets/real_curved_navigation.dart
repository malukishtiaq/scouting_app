import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// Real curved navigation bar using the curved_navigation_bar package
class RealCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const RealCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<RealCurvedNavigation> createState() => _RealCurvedNavigationState();
}

class _RealCurvedNavigationState extends State<RealCurvedNavigation> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getNavigationItems() {
    final items = [
      _buildNavItem(
        icon: Icons.article_outlined,
        label: 'News',
      ),
      _buildNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
      ),
      _buildNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
        ),
      );
    }

    items.add(
      _buildNavItem(
        icon: Icons.settings,
        label: 'Settings',
      ),
    );

    return items;
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppDimensions.iconLarge,
            color: AppColors.textOnPrimary,
          ),
          SizedBox(height: AppDimensions.spacing2),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textOnPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing12,
        vertical: AppDimensions.spacing8,
      ),
      height: AppDimensions.bottomNavHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.9),
                  AppColors.accent.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getNavigationItems(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modern curved navigation with glassmorphism effect
class ModernRealCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const ModernRealCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<ModernRealCurvedNavigation> createState() =>
      _ModernRealCurvedNavigationState();
}

class _ModernRealCurvedNavigationState
    extends State<ModernRealCurvedNavigation> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getNavigationItems() {
    final items = [
      _buildModernNavItem(
        icon: Icons.article_outlined,
        label: 'News',
      ),
      _buildModernNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
      ),
      _buildModernNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildModernNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
        ),
      );
    }

    items.add(
      _buildModernNavItem(
        icon: Icons.settings,
        label: 'Settings',
      ),
    );

    return items;
  }

  Widget _buildModernNavItem({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing8,
        vertical: AppDimensions.spacing4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.spacing8),
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: AppDimensions.shadowBlur,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconMedium,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textOnPrimary,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _getNavigationItems(),
      ),
    );
  }
}

/// Premium curved navigation with advanced styling
class PremiumRealCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const PremiumRealCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<PremiumRealCurvedNavigation> createState() =>
      _PremiumRealCurvedNavigationState();
}

class _PremiumRealCurvedNavigationState
    extends State<PremiumRealCurvedNavigation> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _getNavigationItems() {
    final items = [
      _buildPremiumNavItem(
        icon: Icons.article_outlined,
        label: 'News',
      ),
      _buildPremiumNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
      ),
      _buildPremiumNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildPremiumNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
        ),
      );
    }

    items.add(
      _buildPremiumNavItem(
        icon: Icons.settings,
        label: 'Settings',
      ),
    );

    return items;
  }

  Widget _buildPremiumNavItem({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing12,
        vertical: AppDimensions.spacing8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(AppDimensions.spacing12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.textOnPrimary.withValues(alpha: 0.2),
                  AppColors.textOnPrimary.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              border: Border.all(
                color: AppColors.textOnPrimary.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: AppDimensions.shadowBlur,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconLarge,
              color: AppColors.textOnPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacing8),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textOnPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
            AppColors.primary.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: AppDimensions.shadowBlurXLarge,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.2),
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _getNavigationItems(),
      ),
    );
  }
}
