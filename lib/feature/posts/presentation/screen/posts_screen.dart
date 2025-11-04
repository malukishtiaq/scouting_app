import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../di/service_locator.dart';
import '../../domain/entity/posts_response_entity.dart';
import '../cubit/posts_cubit.dart';
import '../cubit/posts_state.dart';

class PostsScreen extends StatelessWidget {
  static const String routeName = '/posts';

  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostsCubit>()..loadPosts(),
      child: const PostsView(),
    );
  }
}

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<PostsCubit>().loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('posts_title'.tr, style: AppTextStyles.h2),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
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
                    size: AppDimensions.iconLarge,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                  Text(
                    'error_loading_posts'.tr,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textOnPrimary,
                      minimumSize: const Size(
                        120,
                        AppDimensions.buttonHeightMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                      ),
                    ),
                    onPressed: state.retry,
                    child: Text('retry'.tr, style: AppTextStyles.buttonMedium),
                  ),
                ],
              ),
            );
          }

          if (state is PostsLoaded) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<PostsCubit>().refreshPosts();
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppDimensions.spacing16),
                itemCount: state.posts.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= state.posts.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppDimensions.spacing16),
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }

                  final post = state.posts[index];
                  return _PostCard(post: post);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final PostEntity post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacing16),
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              CircleAvatar(
                radius: AppDimensions.avatarSmall / 2,
                backgroundImage: NetworkImage(post.userAvatar),
                backgroundColor: AppColors.primaryLight,
              ),
              const SizedBox(width: AppDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'user_id'.tr + ': ${post.userId}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing12),

          // Title
          Text(
            post.title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing8),

          // Description
          Text(
            post.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimensions.spacing12),

          // Media Type Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing12,
              vertical: AppDimensions.spacing4,
            ),
            decoration: BoxDecoration(
              color: post.mediaType == 'video'
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  post.mediaType == 'video' ? Icons.video_library : Icons.image,
                  size: AppDimensions.iconSmall,
                  color: post.mediaType == 'video'
                      ? AppColors.accent
                      : AppColors.info,
                ),
                const SizedBox(width: AppDimensions.spacing4),
                Text(
                  post.mediaType,
                  style: AppTextStyles.caption.copyWith(
                    color: post.mediaType == 'video'
                        ? AppColors.accent
                        : AppColors.info,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacing12),

          // Stats Row
          Row(
            children: [
              _StatItem(
                icon: Icons.favorite_border,
                count: post.likes,
                label: 'likes'.tr,
              ),
              const SizedBox(width: AppDimensions.spacing16),
              _StatItem(
                icon: Icons.comment_outlined,
                count: post.comments,
                label: 'comments'.tr,
              ),
              const SizedBox(width: AppDimensions.spacing16),
              _StatItem(
                icon: Icons.share_outlined,
                count: post.shares,
                label: 'shares'.tr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;

  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppDimensions.iconSmall,
          color: AppColors.textTertiary,
        ),
        const SizedBox(width: AppDimensions.spacing4),
        Text(
          count.toString(),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
