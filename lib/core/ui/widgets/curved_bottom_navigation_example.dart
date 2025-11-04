import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../constants/colors.dart';
import '../../theme/app_dimensions.dart';

/// Dashboard curved bottom navigation bar
/// Integrates with actual dashboard pages
class CurvedBottomNavigationExample extends StatefulWidget {
  final int? currentIndex;
  final Function(int)? onTap;
  final bool? showTrending;
  final int? notificationBadgeCount; // ✅ Badge count for notifications

  const CurvedBottomNavigationExample({
    super.key,
    this.currentIndex,
    this.onTap,
    this.showTrending,
    this.notificationBadgeCount = 0,
  });

  @override
  State<CurvedBottomNavigationExample> createState() =>
      _CurvedBottomNavigationExampleState();
}

class _CurvedBottomNavigationExampleState
    extends State<CurvedBottomNavigationExample> {
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.currentIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant CurvedBottomNavigationExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int newIndex = widget.currentIndex ?? 0;
    if (newIndex != _pageIndex) {
      setState(() {
        _pageIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _pageIndex,
      backgroundColor: AppColors.transparent,
      buttonBackgroundColor: AppColors.primary,
      color: AppColors.primary,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        setState(() {
          _pageIndex = index;
        });
        widget.onTap?.call(index);
      },
      items: [
        const Icon(Icons.home,
            size: AppDimensions.bottomNavIconSize,
            color: AppColors.textOnPrimary),
        const Icon(Icons.trending_up,
            size: AppDimensions.bottomNavIconSize,
            color: AppColors.textOnPrimary),
        _buildNotificationIcon(), // ✅ Notification icon with badge
        const Icon(Icons.person,
            size: AppDimensions.bottomNavIconSize,
            color: AppColors.textOnPrimary),
      ],
    );
  }

  /// Build notification icon with badge count
  Widget _buildNotificationIcon() {
    final badgeCount = widget.notificationBadgeCount ?? 0;
    final hasBadge = badgeCount > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.notifications,
          size: AppDimensions.bottomNavIconSize,
          color: AppColors.textOnPrimary,
        ),
        if (hasBadge)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2,
                ),
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  badgeCount > 99 ? '99+' : badgeCount.toString(),
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
