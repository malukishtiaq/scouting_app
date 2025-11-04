import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

/// Clean curved navigation bar without background colors
class CleanCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const CleanCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<CleanCurvedNavigation> createState() => _CleanCurvedNavigationState();
}

class _CleanCurvedNavigationState extends State<CleanCurvedNavigation>
    with TickerProviderStateMixin {
  late AnimationController _curveController;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _curveController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _curveController,
      curve: Curves.easeInOut,
    );

    // Start with current index
    _curveController.value =
        widget.currentIndex / (widget.showTrending ? 4 : 3);
  }

  @override
  void didUpdateWidget(CleanCurvedNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    final targetValue = index / (widget.showTrending ? 4 : 3);
    _curveController.animateTo(targetValue);
  }

  @override
  void dispose() {
    _curveController.dispose();
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
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
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
                size: Size(screenWidth, 70),
                painter: CleanCurvePainter(
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
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: isSelected ? 26 : 22,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontSize: isSelected ? 10 : 9,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
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

/// Custom painter for the clean curved background
class CleanCurvePainter extends CustomPainter {
  final double animationValue;
  final int itemCount;
  final double screenWidth;

  CleanCurvePainter({
    required this.animationValue,
    required this.itemCount,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final itemWidth = screenWidth / itemCount;
    final centerX = animationValue * screenWidth;
    final curveHeight = 12.0;
    final curveWidth = itemWidth * 0.6;

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
  }

  @override
  bool shouldRepaint(CleanCurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
