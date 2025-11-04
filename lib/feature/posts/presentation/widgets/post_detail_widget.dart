import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../domain/entity/posts_response_entity.dart';

/// Widget to display full post details
class PostDetailWidget extends StatelessWidget {
  final PostEntity post;

  const PostDetailWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Section
          Padding(
            padding: EdgeInsets.all(AppDimensions.cardPadding),
            child: Row(
              children: [
                CircleAvatar(
                  radius: AppDimensions.avatarMedium / 2,
                  backgroundImage: NetworkImage(post.userAvatar),
                  backgroundColor: AppColors.primaryLight,
                ),
                SizedBox(width: AppDimensions.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user,
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppDimensions.spacing4),
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
          ),

          // Media Section (if available)
          if (post.mediaUrl.isNotEmpty)
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      post.mediaType == 'video'
                          ? Icons.play_circle_outline
                          : Icons.image_outlined,
                      size: AppDimensions.iconLarge * 2,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: AppDimensions.spacing8),
                    Text(
                      post.mediaType == 'video'
                          ? 'video_media'.tr
                          : 'image_media'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacing4),
                    Text(
                      post.mediaUrl,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

          // Content Section
          Padding(
            padding: EdgeInsets.all(AppDimensions.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  post.title,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing12),

                // Description
                Text(
                  post.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing16),

                // Stats Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatColumn(
                      icon: Icons.favorite,
                      count: post.likes,
                      label: 'likes'.tr,
                      color: AppColors.error,
                    ),
                    _StatColumn(
                      icon: Icons.comment,
                      count: post.comments,
                      label: 'comments'.tr,
                      color: AppColors.info,
                    ),
                    _StatColumn(
                      icon: Icons.share,
                      count: post.shares,
                      label: 'shares'.tr,
                      color: AppColors.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final Color color;

  const _StatColumn({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: AppDimensions.iconMedium,
          color: color,
        ),
        SizedBox(height: AppDimensions.spacing4),
        Text(
          count.toString(),
          style: AppTextStyles.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppDimensions.spacing4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
