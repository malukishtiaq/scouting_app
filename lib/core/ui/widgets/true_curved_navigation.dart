import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// True curved navigation bar that mimics the curved_navigation_bar package effect
class TrueCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const TrueCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<TrueCurvedNavigation> createState() => _TrueCurvedNavigationState();
}

class _TrueCurvedNavigationState extends State<TrueCurvedNavigation>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rippleController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _onItemTap(int index) {
    if (index != widget.currentIndex) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
      _rippleController.forward().then((_) {
        _rippleController.reset();
      });
      widget.onTap(index);
    }
  }

  List<Widget> _buildNavigationItems() {
    final items = [
      _buildNavItem(Icons.article_outlined, 'News', 0),
      _buildNavItem(Icons.chat_outlined, 'Chat', 1),
      _buildNavItem(Icons.notifications_outlined, 'Notifications', 2),
    ];

    if (widget.showTrending) {
      items.add(_buildNavItem(Icons.trending_up, 'Trending', 3));
    }
    items.add(
        _buildNavItem(Icons.settings, 'Settings', widget.showTrending ? 4 : 3));
    return items;
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = index == widget.currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTap(index),
        child: AnimatedBuilder(
          animation: _bounceController,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _bounceAnimation.value : 1.0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing4,
                  vertical: AppDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.accent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: AppDimensions.shadowBlurLarge,
                            offset: const Offset(0, AppDimensions.shadowOffset),
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  children: [
                    if (isSelected)
                      AnimatedBuilder(
                        animation: _rippleAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusLarge),
                              border: Border.all(
                                color: AppColors.primary.withValues(
                                  alpha: 0.3 * (1 - _rippleAnimation.value),
                                ),
                                width: 2 * _rippleAnimation.value,
                              ),
                            ),
                          );
                        },
                      ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppDimensions.spacing4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.textOnPrimary
                                      .withValues(alpha: 0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMedium),
                            ),
                            child: Icon(
                              icon,
                              color: isSelected
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                              size: isSelected
                                  ? AppDimensions.iconMedium
                                  : AppDimensions.iconSmall,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacing2),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isSelected
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: 10,
                            ),
                            child: Text(label),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
            AppColors.surface,
            AppColors.surfaceVariant,
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(
          color: AppColors.borderLight.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColored,
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.surface.withValues(alpha: 0.8),
                  AppColors.surfaceVariant.withValues(alpha: 0.6),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildNavigationItems(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Premium curved navigation with glassmorphism and advanced animations
class PremiumTrueCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const PremiumTrueCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<PremiumTrueCurvedNavigation> createState() =>
      _PremiumTrueCurvedNavigationState();
}

class _PremiumTrueCurvedNavigationState
    extends State<PremiumTrueCurvedNavigation> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rippleController;
  late AnimationController _glowController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rippleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rippleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _onItemTap(int index) {
    if (index != widget.currentIndex) {
      _bounceController.forward().then((_) {
        _bounceController.reverse();
      });
      _rippleController.forward().then((_) {
        _rippleController.reset();
      });
      widget.onTap(index);
    }
  }

  List<Widget> _buildNavigationItems() {
    final items = [
      _buildPremiumNavItem(Icons.article_outlined, 'News', 0),
      _buildPremiumNavItem(Icons.chat_outlined, 'Chat', 1),
      _buildPremiumNavItem(Icons.notifications_outlined, 'Notifications', 2),
    ];

    if (widget.showTrending) {
      items.add(_buildPremiumNavItem(Icons.trending_up, 'Trending', 3));
    }
    items.add(_buildPremiumNavItem(
        Icons.settings, 'Settings', widget.showTrending ? 4 : 3));
    return items;
  }

  Widget _buildPremiumNavItem(IconData icon, String label, int index) {
    final isSelected = index == widget.currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTap(index),
        child: AnimatedBuilder(
          animation: Listenable.merge([_bounceController, _glowController]),
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _bounceAnimation.value : 1.0,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing4,
                  vertical: AppDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.accent,
                            AppColors.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusXLarge),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(
                              alpha: 0.4 + (0.2 * _glowAnimation.value),
                            ),
                            blurRadius: AppDimensions.shadowBlurXLarge +
                                (5 * _glowAnimation.value),
                            offset: const Offset(0, 6),
                          ),
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.3),
                            blurRadius: AppDimensions.shadowBlurLarge,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Stack(
                  children: [
                    if (isSelected)
                      AnimatedBuilder(
                        animation: _rippleAnimation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusXLarge),
                              border: Border.all(
                                color: AppColors.primary.withValues(
                                  alpha: 0.5 * (1 - _rippleAnimation.value),
                                ),
                                width: 3 * _rippleAnimation.value,
                              ),
                            ),
                          );
                        },
                      ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppDimensions.spacing8),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      colors: [
                                        AppColors.textOnPrimary
                                            .withOpacity(0.3),
                                        AppColors.textOnPrimary
                                            .withOpacity(0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusLarge),
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.textOnPrimary
                                          .withOpacity(0.3),
                                      width: 1,
                                    )
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color:
                                            AppColors.primary.withOpacity(0.3),
                                        blurRadius: AppDimensions.shadowBlur,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Icon(
                              icon,
                              color: isSelected
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                              size: isSelected
                                  ? AppDimensions.iconLarge
                                  : AppDimensions.iconMedium,
                            ),
                          ),
                          SizedBox(height: AppDimensions.spacing4),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isSelected
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              fontSize: 9,
                            ),
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing8,
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
            AppColors.primary.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: AppDimensions.shadowBlurXLarge,
            offset: const Offset(0, -8),
          ),
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.3),
            blurRadius: AppDimensions.shadowBlurLarge,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
              children: _buildNavigationItems(),
            ),
          ),
        ),
      ),
    );
  }
}
