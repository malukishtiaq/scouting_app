import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../feature/posts/presentation/cubit/posts_cubit.dart';
import '../../../../feature/posts/presentation/cubit/posts_state.dart';
import '../../../../feature/posts/presentation/screen/posts_screen.dart';
import '../../../../feature/settings/presentation/screen/my_profile_screen.dart';
import '../../../../feature/settings/presentation/screen/features/games_screen.dart';
import '../widgets/highlight_post_view.dart';

class HomeTabbedScreenParam {}

class HomeTabbedScreen extends BaseScreen<HomeTabbedScreenParam> {
  static const routeName = "/HomeTabbedScreen";

  const HomeTabbedScreen({required super.param, super.key});

  @override
  State createState() => _HomeTabbedScreenState();
}

class _HomeTabbedScreenState extends State<HomeTabbedScreen> {
  int _currentIndex =
      4; // Start with Highlights tab selected (matching the image)
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MyProfileScreen(param: const MyProfileScreenParam()),
      const PostsScreen(),
      const SizedBox.shrink(),
      GamesScreen(param: const GamesScreenParam()),
      const HighlightsTabView(),
    ];
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: AppDecorations.bottomNavigation(),
      child: SafeArea(
        top: false,
        child: Container(
          height: AppDimensions.bottomNavHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing8,
            vertical: AppDimensions.spacing4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.person, 'profile'.tr, 0, false),
              _buildNavItem(Icons.explore, 'explore'.tr, 1, false),
              _buildNavItem(Icons.add, 'create_game'.tr, 2, true),
              _buildNavItem(Icons.shield, 'games'.tr, 3, false),
              _buildNavItem(Icons.movie, 'highlights'.tr, 4, false, true),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppDimensions.spacing40,
                height: AppDimensions.spacing40,
                decoration: AppDecorations.primaryCircle,
                child: Icon(
                  icon,
                  color: AppColors.textOnPrimary,
                  size: AppDimensions.iconMedium,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive || isSelected
                  ? AppColors.primary
                  : AppColors.textTertiary,
              size: AppDimensions.iconLarge,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: isActive || isSelected
                    ? AppColors.primary
                    : AppColors.textTertiary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
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

class HighlightsTabView extends StatefulWidget {
  const HighlightsTabView({super.key});

  @override
  State<HighlightsTabView> createState() => _HighlightsTabViewState();
}

class _HighlightsTabViewState extends State<HighlightsTabView> {
  final PageController _pageController = PageController();
  int _activeIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsInitial || state is PostsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (state is PostsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: AppDimensions.iconXXLarge,
                ),
                const SizedBox(height: AppDimensions.spacing16),
                Text(
                  'failed_to_fetch_data'.tr,
                  style: AppTextStyles.h3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  state.error.message ?? 'posts_load_failed_description'.tr,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (state is! PostsLoaded || state.posts.isEmpty) {
          return Center(
            child: Text(
              'no_data'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          );
        }

        final postsLoaded = state as PostsLoaded;
        final posts = postsLoaded.posts;

        return Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() => _activeIndex = index);
                final currentState = context.read<PostsCubit>().state;
                if (currentState is PostsLoaded &&
                    currentState.meta.hasNextPage &&
                    index >= currentState.posts.length - 2) {
                  context.read<PostsCubit>().loadMorePosts();
                }
              },
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return HighlightPostView(
                  post: posts[index],
                  isActive: _activeIndex == index,
                );
              },
            ),
            if (postsLoaded.isLoadingMore)
              Positioned(
                bottom:
                    AppDimensions.bottomNavHeight + AppDimensions.spacing16,
                left: 0,
                right: 0,
                child: const Center(
                  child: SizedBox(
                    width: AppDimensions.iconLarge,
                    height: AppDimensions.iconLarge,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
