import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../theme/app_text_styles.dart';

/// Modern, clean curved navigation bar with subtle design
class ModernCurvedNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showTrending;

  const ModernCurvedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showTrending = true,
  });

  @override
  State<ModernCurvedNavigation> createState() => _ModernCurvedNavigationState();
}

class _ModernCurvedNavigationState extends State<ModernCurvedNavigation>
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

    // Start centered on the selected tab: (index + 0.5) / itemCount
    _curveController.value = (widget.currentIndex + 0.5) / 4;
    debugPrint(
        '[NavCurve] init -> index=${widget.currentIndex}, value=${_curveController.value.toStringAsFixed(3)}');
  }

  @override
  void didUpdateWidget(ModernCurvedNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    // Center the curve under the tab by targeting the tab's midpoint
    final targetValue = (index + 0.5) / 4;
    debugPrint(
        '[NavCurve] animateTo -> index=$index, target=${targetValue.toStringAsFixed(3)}');
    _curveController.animateTo(targetValue);
  }

  @override
  void dispose() {
    _curveController.dispose();
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
      height: 75,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        boxShadow: [],
      ),
      child: Stack(
        children: [
          // Moving curved background
          AnimatedBuilder(
            animation: _curveAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(screenWidth, 75),
                painter: ModernCurvePainter(
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
                    height: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(isSelected ? 10 : 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item.icon,
                            size: isSelected ? 24 : 22,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 4),
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

/// Custom painter for the modern curved background
class ModernCurvePainter extends CustomPainter {
  final double animationValue;
  final int itemCount;
  final double screenWidth;

  ModernCurvePainter({
    required this.animationValue,
    required this.itemCount,
    required this.screenWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    final path = Path();
    final itemWidth = size.width / itemCount; // use actual canvas width
    // Convert normalized animation value (0..1) to a tab index using floor to avoid off-by-one at midpoints
    final tabIndexF = (animationValue * itemCount);
    int tabIndex = tabIndexF.floor();
    if (tabIndex < 0) tabIndex = 0;
    if (tabIndex > itemCount - 1) tabIndex = itemCount - 1;
    final double centerX = (tabIndex + 0.5) * itemWidth;
    debugPrint(
        '[NavCurve] paint -> anim=${animationValue.toStringAsFixed(3)}, tabIndex=$tabIndex, centerX=${centerX.toStringAsFixed(1)}, itemWidth=${itemWidth.toStringAsFixed(1)}');
    final curveHeight = 18.0;
    final curveWidth = itemWidth * 0.5;

    // Create the curved path from top
    path.moveTo(0, 0);
    path.lineTo(centerX - curveWidth / 2, 0);

    // Left curve going down
    path.quadraticBezierTo(
      centerX - curveWidth / 4,
      curveHeight,
      centerX,
      curveHeight,
    );

    // Right curve going back up
    path.quadraticBezierTo(
      centerX + curveWidth / 4,
      curveHeight,
      centerX + curveWidth / 2,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ModernCurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
