import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// Beautiful curved navigation bar with proper styling and animations
class BeautifulCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const BeautifulCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<BeautifulCurvedNavigation> createState() =>
      _BeautifulCurvedNavigationState();
}

class _BeautifulCurvedNavigationState extends State<BeautifulCurvedNavigation>
    with TickerProviderStateMixin {
  late AnimationController _curveController;
  late AnimationController _bounceController;
  late Animation<double> _curveAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _curveController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _curveController,
      curve: Curves.easeInOutCubic,
    );

    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );

    // Start with current index
    _curveController.value = widget.currentIndex / 4;
  }

  @override
  void didUpdateWidget(BeautifulCurvedNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    final targetValue = index / 4;
    _curveController.animateTo(targetValue);
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
  }

  @override
  void dispose() {
    _curveController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  List<NavigationItem> _getNavigationItems() {
    return [
      NavigationItem(Icons.article_outlined, 'News'),
      NavigationItem(Icons.notifications_outlined, 'Notifications'),
      NavigationItem(Icons.trending_up, 'Trending'),
      NavigationItem(Icons.settings, 'Settings'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _getNavigationItems();
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 80,
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
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Moving curved background
          AnimatedBuilder(
            animation: _curveAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(screenWidth, 80),
                painter: BeautifulCurvePainter(
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
                    height: 80,
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: isSelected
                              ? 1.0 + (_bounceAnimation.value * 0.1)
                              : 1.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(isSelected ? 12 : 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.white
                                                .withValues(alpha: 0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Icon(
                                  item.icon,
                                  size: isSelected ? 28 : 24,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.label,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.7),
                                  fontSize: isSelected ? 11 : 10,
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
                        );
                      },
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

/// Custom painter for the beautiful curved background
class BeautifulCurvePainter extends CustomPainter {
  final double animationValue;
  final int itemCount;
  final double screenWidth;

  BeautifulCurvePainter({
    required this.animationValue,
    required this.itemCount,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
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

    // Add inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final highlightPath = Path();
    highlightPath.moveTo(
        centerX - curveWidth / 3, size.height - curveHeight * 0.5);
    highlightPath.quadraticBezierTo(
      centerX,
      size.height - curveHeight - 5,
      centerX + curveWidth / 3,
      size.height - curveHeight * 0.5,
    );
    highlightPath.lineTo(centerX + curveWidth / 3, size.height);
    highlightPath.lineTo(centerX - curveWidth / 3, size.height);
    highlightPath.close();

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(BeautifulCurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
