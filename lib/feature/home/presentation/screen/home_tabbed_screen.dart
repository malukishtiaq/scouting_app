import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../feature/explore/presentation/screen/explore_screen.dart';
import '../../../../feature/games/presentation/screen/games_screen.dart' as GamesFeature;
import '../../../../feature/games/presentation/state_m/games/games_cubit.dart';
import '../../../../feature/activity/presentation/screen/activity_screen.dart';
import '../../../../feature/activity/presentation/state_m/activity/activity_cubit.dart';
import '../../../../di/service_locator.dart';
import '../../../settings/presentation/screen/my_profile_screen.dart';

class HomeTabbedScreenParam {}

class HomeTabbedScreen extends BaseScreen<HomeTabbedScreenParam> {
  static const routeName = "/HomeTabbedScreen";

  const HomeTabbedScreen({required super.param, super.key});

  @override
  State createState() => _HomeTabbedScreenState();
}

class _HomeTabbedScreenState extends State<HomeTabbedScreen> {
  int _currentIndex = 0; // Start with Profile tab selected by default
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const MyProfileScreen(param: MyProfileScreenParam()),
      const ExploreScreen(),
      const SizedBox.shrink(),
      BlocProvider(
        create: (context) => getIt<GamesCubit>()..loadGames(),
        child: const GamesFeature.GamesScreen(
          param: GamesFeature.GamesScreenParam(),
        ),
      ),
      BlocProvider(
        create: (context) => getIt<ActivityCubit>()..loadActivities(),
        child: const ActivityScreen(
          param: ActivityScreenParam(),
        ),
      ),
    ];
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: AppDecorations.bottomNavigation(),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60, // Fixed height to prevent overflow
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.person, 'profile'.tr, 0, false),
              _buildNavItem(Icons.explore, 'explore'.tr, 1, false),
              _buildNavItem(Icons.add, 'create_game'.tr, 2, true),
              _buildNavItem(Icons.shield, 'games'.tr, 3, false),
              _buildNavItem(Icons.settings, 'activity'.tr, 4, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isCenter,
      [bool isSelected = false]) {
    final isActive = _currentIndex == index;

    if (isCenter) {
      return Expanded(
        child: GestureDetector(
          onTap: () => _onTabSelected(index, isCenter: true),
          child: Center(
            child: Container(
              width: AppDimensions.spacing40,
              height: AppDimensions.spacing40,
              decoration: AppDecorations.primaryCircle,
              child: Icon(
                icon,
                color: AppColors.textOnPrimary,
                size: AppDimensions.iconMedium,
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        child: Center(
          child: Icon(
            icon,
            color: isActive || isSelected
                ? AppColors.primary
                : AppColors.textTertiary,
            size: AppDimensions.iconLarge,
          ),
        ),
      ),
    );
  }

  void _onTabSelected(int index, {bool isCenter = false}) {
    if (isCenter) {
      _showCreateOptions();
      return;
    }

    if (_currentIndex == index) {
      return;
    }

    setState(() => _currentIndex = index);
  }

  void _showCreateOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.backgroundDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'create_highlight'.tr,
                style: AppTextStyles.h4,
              ),
              const SizedBox(height: AppDimensions.spacing12),
              ListTile(
                leading: const Icon(
                  Icons.videocam_outlined,
                  color: AppColors.textPrimary,
                ),
                title: Text(
                  'reels'.tr,
                  style: AppTextStyles.bodyMedium,
                ),
                subtitle: Text(
                  'feature_coming_soon'.tr,
                  style: AppTextStyles.bodySmall,
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'feature_coming_soon'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.post_add_outlined,
                  color: AppColors.textPrimary,
                ),
                title: Text(
                  'create_post'.tr,
                  style: AppTextStyles.bodyMedium,
                ),
                subtitle: Text(
                  'feature_coming_soon'.tr,
                  style: AppTextStyles.bodySmall,
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'feature_coming_soon'.tr,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppDimensions.spacing16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
