import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../domain/entity/game_entity.dart';

class GameCard extends StatelessWidget {
  final GameEntity game;
  final VoidCallback onViewDetails;

  const GameCard({
    Key? key,
    required this.game,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing12,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Host Info Section
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Row(
              children: [
                // Host Avatar
                Container(
                  width: AppDimensions.avatarXLarge,
                  height: AppDimensions.avatarXLarge,
                  decoration: AppDecorations.avatar,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusRound),
                    child: CachedNetworkImage(
                      imageUrl: game.hostAvatar,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconLarge,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceVariant,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconLarge,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppDimensions.spacing12),

                // Host Name and Reliability
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'hosted_by'.tr} ${game.hostName}',
                        style: AppTextStyles.h6,
                      ),
                      const SizedBox(height: AppDimensions.spacing4),
                      Text(
                        '${game.hostReliability}% ${'reliability'.tr}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Game Info and Field Image Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Game Info (Left Side) - Expanded to take remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        game.title,
                        style: AppTextStyles.h5,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.spacing8),

                      // Sport Type and Player Count
                      Row(
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            size: AppDimensions.iconSmall,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: AppDimensions.spacing4),
                          Flexible(
                            child: Text(
                              '${game.sportType} • ${game.playersCount} / ${game.maxPlayers} ${'players'.tr}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textTertiary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spacing8),

                      // Location
                      Text(
                        game.location,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.spacing8),

                      // Date and Time
                      Text(
                        game.dateTime,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.spacing16),

                      // View Details Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              AppDimensions.buttonHeightMedium,
                            ),
                            backgroundColor: AppColors.surface,
                            foregroundColor: AppColors.textPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium,
                              ),
                            ),
                            elevation: 0,
                          ),
                          onPressed: onViewDetails,
                          child: Text(
                            'view_details'.tr,
                            style: AppTextStyles.buttonMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppDimensions.spacing8),

                // Field Image (Right Side) - Fixed width, no flex
                SizedBox(
                  width: AppDimensions.gameFieldImageWidth,
                  height: AppDimensions.gameFieldImageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: game.fieldImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: AppDecorations.gameFieldImage,
                        child: const Icon(
                          Icons.sports_soccer,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconXLarge,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: AppDecorations.gameFieldImage,
                        child: const Icon(
                          Icons.sports_soccer,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconXLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacing16),
        ],
      ),
    );
  }
}
