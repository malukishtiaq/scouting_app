import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reels_cubit.dart';
import '../cubit/reels_state.dart';
import '../widget/reel_player_widget.dart';
import '../../domain/entity/reels_response_entity.dart';
import '../../../../core/video/video_cache_manager.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../core/navigation/app_route_observer.dart';

class ReelsScreen extends StatefulWidget {
  static const String routeName = '/reels';

  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen>
    with WidgetsBindingObserver, RouteAware {
  late PageController _pageController;
  int _currentIndex = 0;
  int _selectedNavIndex = 0; // For bottom navigation

  // Gesture tracking for quick flicks
  double _dragStartY = 0;
  double _currentDragY = 0;
  bool _isDragging = false;
  final ValueNotifier<bool> _isScreenActive = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    // Configure PageController for smooth scrolling
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
      keepPage: true,
    );
    // Load initial reels
    context.read<ReelsCubit>().loadReels();

    // Listen to app lifecycle events
    WidgetsBinding.instance.addObserver(this);
  }

  Widget _buildLoadingState() {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        _buildBackOverlay(context),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.ondemand_video,
                color: AppColors.textSecondary,
                size: AppDimensions.iconXXLarge,
              ),
              SizedBox(height: AppDimensions.spacing16),
              Text(
                'reels_empty_title'.tr,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
              SizedBox(height: AppDimensions.spacing8),
              Text(
                'reels_empty_subtitle'.tr,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildBackOverlay(context),
      ],
    );
  }

  Widget _buildErrorState(ReelsError state) {
    final message = state.error.message?.isNotEmpty == true
        ? state.error.message!
        : 'unknownError'.tr;

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: AppDimensions.iconXXLarge,
              ),
              SizedBox(height: AppDimensions.spacing16),
              Text(
                'reels_error_title'.tr,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.textOnPrimary,
                ),
              ),
              SizedBox(height: AppDimensions.spacing8),
              Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.spacing24),
              ElevatedButton(
                onPressed: state.retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  minimumSize: Size(
                    AppDimensions.spacing64,
                    AppDimensions.buttonHeightMedium,
                  ),
                ),
                child: Text(
                  'retry'.tr,
                  style: AppTextStyles.buttonMedium,
                ),
              ),
            ],
          ),
        ),
        _buildBackOverlay(context),
      ],
    );
  }

  Widget _buildReelsPager(List<PostDataEntity> reels) {
    return Stack(
      children: [
        GestureDetector(
          onVerticalDragStart: (details) {
            _isDragging = true;
            _dragStartY = details.globalPosition.dy;
            _currentDragY = details.globalPosition.dy;
          },
          onVerticalDragUpdate: (details) {
            if (_isDragging) {
              _currentDragY = details.globalPosition.dy;
            }
          },
          onVerticalDragEnd: (details) {
            if (!_isDragging) return;
            _isDragging = false;

            final dragDistance = _dragStartY - _currentDragY;
            final screenHeight = MediaQuery.of(context).size.height;
            final dragPercent = (dragDistance.abs() / screenHeight);
            final velocity = details.primaryVelocity ?? 0;

            final isQuickFlick = velocity.abs() > 300;
            final isSignificantDrag = dragPercent > 0.15;

            if (isQuickFlick || isSignificantDrag) {
              if (dragDistance > 0) {
                if (_currentIndex < reels.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              } else {
                if (_currentIndex > 0) {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            }

            _dragStartY = 0;
            _currentDragY = 0;
          },
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });

              context.read<ReelsCubit>().preloadUpcomingVideos(index);

              if (index >= reels.length - 2) {
                context.read<ReelsCubit>().loadMoreReels();
              }
            },
            itemCount: reels.length,
            itemBuilder: (context, index) {
              final reel = reels[index];
              return ReelPlayerWidget(
                reel: reel,
                isActive: index == _currentIndex,
                playbackNotifier: _isScreenActive,
              );
            },
            allowImplicitScrolling: false,
            padEnds: false,
          ),
        ),
        _buildBackOverlay(context),
      ],
    );
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Clear cache when app goes to background to free memory
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      print('📱 APP PAUSED: Clearing video cache to free memory');
      _setScreenActive(false);
      VideoCacheManager().forceCleanup(clearAll: true);
    } else if (state == AppLifecycleState.resumed) {
      _setScreenActive(true);
    }
  }

  @override
  void didPush() {
    _setScreenActive(true);
  }

  @override
  void didPopNext() {
    _setScreenActive(true);
  }

  @override
  void didPushNext() {
    _setScreenActive(false);
    VideoCacheManager().pauseAll();
  }

  @override
  void didPop() {
    _setScreenActive(false);
  }

  void _setScreenActive(bool isActive) {
    if (_isScreenActive.value != isActive) {
      _isScreenActive.value = isActive;
    }
    if (!isActive) {
      VideoCacheManager().pauseAll();
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _isScreenActive.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      extendBody: true, // Extend body behind bottom nav
      body: BlocConsumer<ReelsCubit, ReelsState>(
        listener: (context, state) {
          if (state is ReelsError) {
            final message = state.error.message?.isNotEmpty == true
                ? state.error.message!
                : 'unknownError'.tr;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.surface,
                content: Text(
                  message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
                action: SnackBarAction(
                  label: 'retry'.tr,
                  textColor: AppColors.primary,
                  onPressed: state.retry,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReelsInitial || state is ReelsLoading) {
            return _buildLoadingState();
          }

          if (state is ReelsLoaded) {
            final reels = state.reels;
            if (reels.isEmpty) {
              return _buildEmptyState();
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ReelsCubit>().preloadUpcomingVideos(_currentIndex);
            });

            return _buildReelsPager(reels);
          }

          if (state is ReelsError) {
            return _buildErrorState(state);
          }

          return _buildLoadingState();
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Build TikTok-style bottom navigation bar (from Figma)
  Widget _buildBottomNavigationBar() {
    return Container(
      height: AppDimensions.bottomNavHeight,
      decoration: AppDecorations.bottomNavigation(opacity: 0.85),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing24,
            vertical: AppDimensions.spacing12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavIcon(
                icon: Icons.person_outline,
                label: 'home'.tr,
                index: 0,
              ),
              _buildNavIcon(
                icon: Icons.sports_soccer,
                label: 'explore'.tr,
                index: 1,
              ),
              _buildNavIcon(
                icon: Icons.add_circle_outline,
                label: '',
                index: 2,
                isCenter: true,
              ),
              _buildNavIcon(
                icon: Icons.videogame_asset_outlined,
                label: 'games'.tr,
                index: 3,
              ),
              _buildNavIcon(
                icon: Icons.public,
                label: 'discover'.tr,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build navigation icon button
  Widget _buildNavIcon({
    required IconData icon,
    required String label,
    required int index,
    bool isCenter = false,
  }) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        _handleNavigation(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? AppColors.primary
                : AppColors.textOnPrimary,
            size: isCenter
                ? AppDimensions.iconXLarge
                : AppDimensions.iconLarge,
          ),
          if (label.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: AppDimensions.spacing4),
              child: Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Handle bottom navigation
  void _handleNavigation(int index) {
    switch (index) {
      case 0: // Profile/People
        _showComingSoonMessage('home_coming_soon');
        break;
      case 1: // Explore/Ball
        _showComingSoonMessage('explore_coming_soon');
        break;
      case 2: // Add/Upload (center)
        _showComingSoonMessage('upload_coming_soon');
        break;
      case 3: // Games/Controller
        _showComingSoonMessage('games_coming_soon');
        break;
      case 4: // Discover/Globe
        _showComingSoonMessage('discover_coming_soon');
        break;
    }
  }

  void _showComingSoonMessage(String key) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.surface,
        duration: const Duration(seconds: 1),
        content: Text(
          key.tr,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildBackOverlay(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spacing12),
          child: Container(
            width: AppDimensions.spacing40,
            height: AppDimensions.spacing40,
            decoration: AppDecorations.circularOverlay,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.textOnPrimary,
              ),
              onPressed: () => Navigator.pop(context),
              tooltip: 'go_back'.tr,
            ),
          ),
        ),
      ),
    );
  }
}
