import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../localization/app_localization.dart';
import '../../../../mainapis.dart';
import '../../domain/entities/player_entity.dart';

/// Media Gallery Widget
/// Displays player photos and videos in a grid
class MediaGallery extends StatelessWidget {
  final List<MediaEntity> media;

  const MediaGallery({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'videos'.tr,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              if (media.length > 6)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all media screen
                  },
                  child: Text(
                    'view_all_media'.tr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.spacing12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppDimensions.spacing8,
            mainAxisSpacing: AppDimensions.spacing8,
            childAspectRatio: 1,
          ),
          itemCount: media.length > 6 ? 6 : media.length,
          itemBuilder: (context, index) {
            return _buildMediaItem(context, media[index]);
          },
        ),
      ],
    );
  }

  Widget _buildMediaItem(BuildContext context, MediaEntity mediaItem) {
    return GestureDetector(
      onTap: () {
        // TODO: Open media viewer
      },
      child: Container(
        decoration: AppDecorations.card,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              child: CachedNetworkImage(
                imageUrl: MainAPIS.getCoverImage(
                    mediaItem.thumbnailUrl ?? mediaItem.mediaUrl ?? ''),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surface,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surface,
                  child: Icon(
                    Icons.broken_image,
                    color: AppColors.textTertiary,
                    size: AppDimensions.iconLarge,
                  ),
                ),
              ),
            ),
            // Video play button overlay
            if (mediaItem.mediaType == 'video')
              Center(
                child: Container(
                  padding: EdgeInsets.all(AppDimensions.spacing8),
                  decoration: BoxDecoration(
                    color: AppColors.overlay,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.textOnPrimary,
                    size: AppDimensions.iconLarge,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: AppDimensions.iconXXLarge,
              color: AppColors.textTertiary,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              'no_media_available'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

