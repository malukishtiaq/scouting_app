import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// Moving curved navigation bar that replicates the curved_navigation_bar package
/// The curve itself moves to the selected item with smooth animations
class MovingCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const MovingCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<MovingCurvedNavigation> createState() => _MovingCurvedNavigationState();
}

class _MovingCurvedNavigationState extends State<MovingCurvedNavigation>
    with TickerProviderStateMixin {
  late AnimationController _curveController;
  late AnimationController _itemController;
  late Animation<double> _curveAnimation;
  late Animation<double> _itemAnimation;

  @override
  void initState() {
    super.initState();
    _curveController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _itemController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _curveController,
      curve: Curves.easeInOutCubic,
    );

    _itemAnimation = CurvedAnimation(
      parent: _itemController,
      curve: Curves.easeInOutCubic,
    );

    // Start with current index
    _curveController.value =
        widget.currentIndex / (widget.showTrending ? 4 : 3);
  }

  @override
  void didUpdateWidget(MovingCurvedNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    final targetValue = index / (widget.showTrending ? 4 : 3);
    _curveController.animateTo(targetValue);
    _itemController.forward().then((_) {
      _itemController.reverse();
    });
  }

  @override
  void dispose() {
    _curveController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  List<NavigationItem> _getNavigationItems() {
    final items = [
      NavigationItem(Icons.article_outlined, 'News'),
      NavigationItem(Icons.chat_outlined, 'Chat'),
      NavigationItem(Icons.notifications_outlined, 'Notifications'),
    ];

    if (widget.showTrending) {
      items.add(NavigationItem(Icons.trending_up, 'Trending'));
    }

    items.add(NavigationItem(Icons.settings, 'Settings'));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final items = _getNavigationItems();
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / items.length;

    return Container(
      height: AppDimensions.bottomNavHeight + 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Moving curved background
          AnimatedBuilder(
            animation: _curveAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(screenWidth, AppDimensions.bottomNavHeight + 20),
                painter: MovingCurvePainter(
                  animationValue: _curveAnimation.value,
                  itemCount: items.length,
                  screenWidth: screenWidth,
                ),
              );
            },
          ),
          // Navigation items
          Row(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  child: Container(
                    height: AppDimensions.bottomNavHeight + 20,
                    child: Stack(
                      children: [
                        // Animated item background
                        AnimatedBuilder(
                          animation: _itemAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: isSelected
                                  ? 1.0 + (_itemAnimation.value * 0.1)
                                  : 1.0,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.spacing4,
                                  vertical: AppDimensions.spacing8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.textOnPrimary
                                          .withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusLarge),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: isSelected
                                          ? AppDimensions.iconLarge
                                          : AppDimensions.iconMedium,
                                      color: isSelected
                                          ? AppColors.textOnPrimary
                                          : AppColors.textOnPrimary
                                              .withValues(alpha: 0.7),
                                    ),
                                    SizedBox(height: AppDimensions.spacing2),
                                    Text(
                                      item.label,
                                      style: AppTextStyles.labelSmall.copyWith(
                                        color: isSelected
                                            ? AppColors.textOnPrimary
                                            : AppColors.textOnPrimary
                                                .withValues(alpha: 0.7),
                                        fontSize: isSelected ? 10 : 9,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem(this.icon, this.label);
}

/// Custom painter for the moving curved background
class MovingCurvePainter extends CustomPainter {
  final double animationValue;
  final int itemCount;
  final double screenWidth;

  MovingCurvePainter({
    required this.animationValue,
    required this.itemCount,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textOnPrimary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final path = Path();
    final itemWidth = screenWidth / itemCount;
    final centerX = animationValue * screenWidth;
    final curveHeight = 20.0;
    final curveWidth = itemWidth * 0.8;

    // Create the curved path
    path.moveTo(0, size.height);
    path.lineTo(centerX - curveWidth / 2, size.height);

    // Left curve
    path.quadraticBezierTo(
      centerX - curveWidth / 4,
      size.height - curveHeight,
      centerX,
      size.height - curveHeight,
    );

    // Right curve
    path.quadraticBezierTo(
      centerX + curveWidth / 4,
      size.height - curveHeight,
      centerX + curveWidth / 2,
      size.height,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Add glow effect
    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(MovingCurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Premium moving curved navigation with advanced effects
class PremiumMovingCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const PremiumMovingCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<PremiumMovingCurvedNavigation> createState() =>
      _PremiumMovingCurvedNavigationState();
}

class _PremiumMovingCurvedNavigationState
    extends State<PremiumMovingCurvedNavigation> with TickerProviderStateMixin {
  late AnimationController _curveController;
  late AnimationController _itemController;
  late AnimationController _glowController;
  late Animation<double> _curveAnimation;
  late Animation<double> _itemAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _curveController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _itemController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _curveController,
      curve: Curves.easeInOutCubic,
    );

    _itemAnimation = CurvedAnimation(
      parent: _itemController,
      curve: Curves.elasticOut,
    );

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    // Start with current index
    _curveController.value =
        widget.currentIndex / (widget.showTrending ? 4 : 3);
    _glowController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(PremiumMovingCurvedNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    final targetValue = index / (widget.showTrending ? 4 : 3);
    _curveController.animateTo(targetValue);
    _itemController.forward().then((_) {
      _itemController.reverse();
    });
  }

  @override
  void dispose() {
    _curveController.dispose();
    _itemController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  List<NavigationItem> _getNavigationItems() {
    final items = [
      NavigationItem(Icons.article_outlined, 'News'),
      NavigationItem(Icons.chat_outlined, 'Chat'),
      NavigationItem(Icons.notifications_outlined, 'Notifications'),
    ];

    if (widget.showTrending) {
      items.add(NavigationItem(Icons.trending_up, 'Trending'));
    }

    items.add(NavigationItem(Icons.settings, 'Settings'));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final items = _getNavigationItems();
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: AppDimensions.bottomNavHeight + 25,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.accent,
            AppColors.primary.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: AppDimensions.shadowBlurXLarge,
            offset: const Offset(0, -8),
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
            child: Stack(
              children: [
                // Premium moving curved background
                AnimatedBuilder(
                  animation:
                      Listenable.merge([_curveAnimation, _glowAnimation]),
                  builder: (context, child) {
                    return CustomPaint(
                      size:
                          Size(screenWidth, AppDimensions.bottomNavHeight + 25),
                      painter: PremiumMovingCurvePainter(
                        animationValue: _curveAnimation.value,
                        glowValue: _glowAnimation.value,
                        itemCount: items.length,
                        screenWidth: screenWidth,
                      ),
                    );
                  },
                ),
                // Navigation items
                Row(
                  children: items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = index == widget.currentIndex;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => widget.onTap(index),
                        child: Container(
                          height: AppDimensions.bottomNavHeight + 25,
                          child: Stack(
                            children: [
                              // Animated item background with ripple effect
                              AnimatedBuilder(
                                animation: _itemAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: isSelected
                                        ? 1.0 + (_itemAnimation.value * 0.15)
                                        : 1.0,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: AppDimensions.spacing8,
                                        vertical: AppDimensions.spacing12,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? LinearGradient(
                                                colors: [
                                                  AppColors.textOnPrimary
                                                      .withValues(alpha: 0.3),
                                                  AppColors.textOnPrimary
                                                      .withValues(alpha: 0.1),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.radiusXLarge),
                                        border: isSelected
                                            ? Border.all(
                                                color: AppColors.textOnPrimary
                                                    .withValues(alpha: 0.4),
                                                width: 1,
                                              )
                                            : null,
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.4),
                                                  blurRadius: AppDimensions
                                                      .shadowBlurLarge,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(
                                                AppDimensions.spacing8),
                                            decoration: BoxDecoration(
                                              gradient: isSelected
                                                  ? LinearGradient(
                                                      colors: [
                                                        AppColors.textOnPrimary
                                                            .withValues(
                                                                alpha: 0.2),
                                                        AppColors.textOnPrimary
                                                            .withValues(
                                                                alpha: 0.1),
                                                      ],
                                                    )
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimensions
                                                          .radiusLarge),
                                            ),
                                            child: Icon(
                                              item.icon,
                                              size: isSelected
                                                  ? AppDimensions.iconLarge
                                                  : AppDimensions.iconMedium,
                                              color: isSelected
                                                  ? AppColors.textOnPrimary
                                                  : AppColors.textOnPrimary
                                                      .withValues(alpha: 0.7),
                                            ),
                                          ),
                                          SizedBox(
                                              height: AppDimensions.spacing4),
                                          Text(
                                            item.label,
                                            style: AppTextStyles.labelSmall
                                                .copyWith(
                                              color: isSelected
                                                  ? AppColors.textOnPrimary
                                                  : AppColors.textOnPrimary
                                                      .withValues(alpha: 0.7),
                                              fontSize: isSelected ? 10 : 9,
                                              fontWeight: isSelected
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Premium custom painter for the moving curved background with glow effects
class PremiumMovingCurvePainter extends CustomPainter {
  final double animationValue;
  final double glowValue;
  final int itemCount;
  final double screenWidth;

  PremiumMovingCurvePainter({
    required this.animationValue,
    required this.glowValue,
    required this.itemCount,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final itemWidth = screenWidth / itemCount;
    final centerX = animationValue * screenWidth;
    final curveHeight = 25.0;
    final curveWidth = itemWidth * 0.9;

    // Main curve paint
    final paint = Paint()
      ..color = AppColors.textOnPrimary.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    // Glow effect paint
    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3 + (0.2 * glowValue))
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final path = Path();

    // Create the curved path
    path.moveTo(0, size.height);
    path.lineTo(centerX - curveWidth / 2, size.height);

    // Left curve with more sophisticated bezier
    path.quadraticBezierTo(
      centerX - curveWidth / 3,
      size.height - curveHeight * 0.7,
      centerX - curveWidth / 6,
      size.height - curveHeight,
    );

    // Center peak
    path.quadraticBezierTo(
      centerX,
      size.height - curveHeight - 5,
      centerX + curveWidth / 6,
      size.height - curveHeight,
    );

    // Right curve
    path.quadraticBezierTo(
      centerX + curveWidth / 3,
      size.height - curveHeight * 0.7,
      centerX + curveWidth / 2,
      size.height,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    // Draw glow effect first
    canvas.drawPath(path, glowPaint);

    // Draw main curve
    canvas.drawPath(path, paint);

    // Add inner highlight
    final highlightPaint = Paint()
      ..color = AppColors.textOnPrimary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final highlightPath = Path();
    highlightPath.moveTo(
        centerX - curveWidth / 3, size.height - curveHeight * 0.5);
    highlightPath.quadraticBezierTo(
      centerX,
      size.height - curveHeight - 8,
      centerX + curveWidth / 3,
      size.height - curveHeight * 0.5,
    );
    highlightPath.lineTo(centerX + curveWidth / 3, size.height);
    highlightPath.lineTo(centerX - curveWidth / 3, size.height);
    highlightPath.close();

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(PremiumMovingCurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.glowValue != glowValue;
  }
}
