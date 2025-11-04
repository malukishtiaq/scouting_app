import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../feature/posts/presentation/cubit/posts_cubit.dart';
import '../../../../feature/posts/presentation/cubit/posts_state.dart';
import '../../../../feature/posts/domain/entity/posts_response_entity.dart';

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

  List<Widget> get _pages {
    return [
      Container(
        color: AppColors.backgroundDark,
        child: Center(
            child: Text('Profile',
                style: AppTextStyles.h2.copyWith(color: Colors.white))),
      ), // Index 0: Profile
      Container(
        color: AppColors.backgroundDark,
        child: Center(
            child: Text('Explore',
                style: AppTextStyles.h2.copyWith(color: Colors.white))),
      ), // Index 1: Explore
      Container(
        color: AppColors.backgroundDark,
        child: Center(
            child: Text('Create Game',
                style: AppTextStyles.h2.copyWith(color: Colors.white))),
      ), // Index 2: Create Game
      Container(
        color: AppColors.backgroundDark,
        child: Center(
            child: Text('Games',
                style: AppTextStyles.h2.copyWith(color: Colors.white))),
      ), // Index 3: Games
      _buildHighlightsScreen(), // Index 4: Highlights (main content)
    ];
  }

  Widget _buildHighlightsScreen() {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
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
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load posts',
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  state.error.message ?? 'Failed to load posts',
                  style:
                      AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final posts = state is PostsLoaded ? state.posts : <PostEntity>[];

        if (posts.isEmpty) {
          return const Center(
            child: Text(
              'No posts available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        // Show the first post as the main content
        final currentPost = posts[0];

        return Stack(
          children: [
            // Background video/image from API
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      currentPost.mediaUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
            ),

            // Content overlay
            Positioned.fill(
              child: Column(
                children: [
                  const Spacer(),
                  // Bottom content area
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left side - Profile section with real API data
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileSectionFromAPI(currentPost),
                            ],
                          ),
                        ),
                        // Right side - Interaction buttons with real API data
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildInteractionButton(
                                Icons.favorite, '${currentPost.likes}'),
                            const SizedBox(height: 24),
                            _buildInteractionButton(
                                Icons.chat, '${currentPost.comments}'),
                            const SizedBox(height: 24),
                            _buildInteractionButton(
                                Icons.share, '${currentPost.shares}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileSectionFromAPI(PostEntity post) {
    return Row(
      children: [
        // Profile image from API
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                post.userAvatar,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Name from API
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                post.title,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white70,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButton(IconData icon, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon with drop shadow
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(height: 4),
        // Count text with drop shadow
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            count,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.8),
        border: const Border(
          top: BorderSide(
            color: AppColors.borderMedium,
            width: 1,
          ),
        ),
      ),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.person, 'Profile', 0, false),
            _buildNavItem(Icons.explore, 'Explore', 1, false),
            _buildNavItem(Icons.add, 'Create Game', 2, true),
            _buildNavItem(Icons.shield, 'Games', 3, false),
            _buildNavItem(Icons.movie, 'Highlights', 4, false, true),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isCenter,
      [bool isSelected = false]) {
    final isActive = _currentIndex == index;

    if (isCenter) {
      return GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Center button - blue circle with plus
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            icon,
            color: isActive || isSelected
                ? AppColors.primary
                : AppColors.textTertiary,
            size: 24,
          ),
          const SizedBox(height: 4),
          // Label
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isActive || isSelected
                  ? AppColors.primary
                  : AppColors.textTertiary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
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
