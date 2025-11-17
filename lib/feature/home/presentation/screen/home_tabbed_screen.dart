import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/app_route_observer.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../feature/posts/presentation/cubit/posts_cubit.dart';
import '../../../../feature/posts/presentation/cubit/posts_state.dart';
import '../../../../feature/explore/presentation/screen/explore_screen.dart';
import '../../../../feature/settings/presentation/screen/features/games_screen.dart';
import '../../../settings/presentation/screen/my_profile_screen.dart';
import '../widgets/highlight_post_view.dart';

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
  final ValueNotifier<bool> _highlightPlaybackNotifier =
      ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _pages = [
      const MyProfileScreen(param: MyProfileScreenParam()),
      const ExploreScreen(),
      const SizedBox.shrink(),
      const GamesScreen(param: GamesScreenParam()),
      HighlightsTabView(playbackNotifier: _highlightPlaybackNotifier),
    ];
  }

  @override
  void dispose() {
    _highlightPlaybackNotifier.dispose();
    super.dispose();
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

    _highlightPlaybackNotifier.value = index == 4;
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
  final ValueNotifier<bool> playbackNotifier;

  const HighlightsTabView({
    super.key,
    required this.playbackNotifier,
  });

  @override
  State<HighlightsTabView> createState() => _HighlightsTabViewState();
}

class _HighlightsTabViewState extends State<HighlightsTabView>
    with WidgetsBindingObserver, RouteAware {
  final PageController _pageController = PageController();
  int _activeIndex = 0;
  final ValueNotifier<bool> _routePlaybackNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    widget.playbackNotifier.addListener(_handlePlaybackChange);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant HighlightsTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.playbackNotifier != widget.playbackNotifier) {
      oldWidget.playbackNotifier.removeListener(_handlePlaybackChange);
      widget.playbackNotifier.addListener(_handlePlaybackChange);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    widget.playbackNotifier.removeListener(_handlePlaybackChange);
    appRouteObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _routePlaybackNotifier.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _routePlaybackNotifier.value = false;
    } else if (state == AppLifecycleState.resumed) {
      _routePlaybackNotifier.value = true;
    }
  }

  @override
  void didPushNext() {
    _routePlaybackNotifier.value = false;
  }

  @override
  void didPopNext() {
    _routePlaybackNotifier.value = true;
  }

  void _handlePlaybackChange() {
    setState(() {});
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

        final PostsLoaded postsLoaded = state;
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
                  playbackNotifier: widget.playbackNotifier,
                  routePlaybackNotifier: _routePlaybackNotifier,
                );
              },
            ),
            if (postsLoaded.isLoadingMore)
              const Positioned(
                bottom: AppDimensions.bottomNavHeight + AppDimensions.spacing16,
                left: 0,
                right: 0,
                child: Center(
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
