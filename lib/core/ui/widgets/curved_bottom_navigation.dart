import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// Beautiful curved bottom navigation bar with modern styling
class CurvedBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const CurvedBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<CurvedBottomNavigation> createState() => _CurvedBottomNavigationState();
}

class _CurvedBottomNavigationState extends State<CurvedBottomNavigation> {
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
            color: AppColors.primary.withOpacity(0.3),
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

  List<Widget> _getNavigationItems() {
    final items = [
      _buildNavItem(
        icon: Icons.article_outlined,
        label: 'News',
        index: 0,
      ),
      _buildNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
        index: 1,
      ),
      _buildNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
        index: 2,
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
          index: 3,
        ),
      );
    }

    items.add(
      _buildNavItem(
        icon: Icons.settings,
        label: 'Settings',
        index: widget.showTrending ? 4 : 3,
      ),
    );

    return items;
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing4,
            vertical: AppDimensions.spacing8,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.textOnPrimary.withOpacity(0.2),
                      AppColors.textOnPrimary.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.textOnPrimary.withOpacity(0.3),
                      blurRadius: AppDimensions.shadowBlur,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.textOnPrimary,
                size: isSelected
                    ? AppDimensions.iconLarge
                    : AppDimensions.iconMedium,
              ),
              SizedBox(height: AppDimensions.spacing4),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textOnPrimary,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modern curved navigation with glassmorphism effect
class ModernCurvedBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const ModernCurvedBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<ModernCurvedBottomNavigation> createState() =>
      _ModernCurvedBottomNavigationState();
}

class _ModernCurvedBottomNavigationState
    extends State<ModernCurvedBottomNavigation> {
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
            color: AppColors.primary.withOpacity(0.3),
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

  List<Widget> _getNavigationItems() {
    final items = [
      _buildModernNavItem(
        icon: Icons.article_outlined,
        label: 'News',
        index: 0,
      ),
      _buildModernNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
        index: 1,
      ),
      _buildModernNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
        index: 2,
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildModernNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
          index: 3,
        ),
      );
    }

    items.add(
      _buildModernNavItem(
        icon: Icons.settings,
        label: 'Settings',
        index: widget.showTrending ? 4 : 3,
      ),
    );

    return items;
  }

  Widget _buildModernNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing4,
            vertical: AppDimensions.spacing8,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.textOnPrimary.withOpacity(0.2),
                      AppColors.textOnPrimary.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.textOnPrimary.withOpacity(0.3),
                      blurRadius: AppDimensions.shadowBlur,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.spacing8),
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Icon(
                  icon,
                  color: AppColors.textOnPrimary,
                  size: isSelected
                      ? AppDimensions.iconLarge
                      : AppDimensions.iconMedium,
                ),
              ),
              SizedBox(height: AppDimensions.spacing4),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textOnPrimary,
                  fontSize: 9,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Premium curved navigation with advanced styling
class PremiumCurvedBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const PremiumCurvedBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<PremiumCurvedBottomNavigation> createState() =>
      _PremiumCurvedBottomNavigationState();
}

class _PremiumCurvedBottomNavigationState
    extends State<PremiumCurvedBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing12,
      ),
      height: AppDimensions.bottomNavHeight + AppDimensions.spacing8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: AppDimensions.shadowBlurXLarge,
            offset: const Offset(0, -6),
          ),
          BoxShadow(
            color: AppColors.accent.withOpacity(0.2),
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

  List<Widget> _getNavigationItems() {
    final items = [
      _buildPremiumNavItem(
        icon: Icons.article_outlined,
        label: 'News',
        index: 0,
      ),
      _buildPremiumNavItem(
        icon: Icons.chat_outlined,
        label: 'Chat',
        index: 1,
      ),
      _buildPremiumNavItem(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
        index: 2,
      ),
    ];

    if (widget.showTrending) {
      items.add(
        _buildPremiumNavItem(
          icon: Icons.trending_up,
          label: 'Trending',
          index: 3,
        ),
      );
    }

    items.add(
      _buildPremiumNavItem(
        icon: Icons.settings,
        label: 'Settings',
        index: widget.showTrending ? 4 : 3,
      ),
    );

    return items;
  }

  Widget _buildPremiumNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing8,
            vertical: AppDimensions.spacing8,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.textOnPrimary.withOpacity(0.2),
                      AppColors.textOnPrimary.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: isSelected
                ? Border.all(
                    color: AppColors.textOnPrimary.withOpacity(0.3),
                    width: 1,
                  )
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: AppDimensions.shadowBlur,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(AppDimensions.spacing12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.textOnPrimary.withOpacity(0.3),
                            AppColors.textOnPrimary.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.textOnPrimary.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: AppDimensions.shadowBlur,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  icon,
                  color: AppColors.textOnPrimary,
                  size: isSelected
                      ? AppDimensions.iconXLarge
                      : AppDimensions.iconLarge,
                ),
              ),
              SizedBox(height: AppDimensions.spacing8),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textOnPrimary,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
