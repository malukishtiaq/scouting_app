import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../localization/app_localization.dart';
import '../../domain/entity/activity_entity.dart';

class ActivityItem extends StatelessWidget {
  final ActivityEntity activity;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ActivityItem({
    super.key,
    required this.activity,
    this.onAccept,
    this.onDecline,
  });

  IconData _getIconForType(String type) {
    switch (type) {
      case 'post_liked':
        return Icons.favorite_outline;
      case 'game_notification':
        return Icons.settings_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar or Icon
              if (activity.avatarUrl != null)
                Container(
                  width: AppDimensions.avatarLarge,
                  height: AppDimensions.avatarLarge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceVariant,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: activity.avatarUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceVariant,
                        child: Icon(
                          Icons.person,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconMedium,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceVariant,
                        child: Icon(
                          Icons.person,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconMedium,
                        ),
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: AppDimensions.avatarLarge,
                  height: AppDimensions.avatarLarge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    _getIconForType(activity.type),
                    color: AppColors.textPrimary,
                    size: AppDimensions.iconLarge,
                  ),
                ),

              SizedBox(width: AppDimensions.spacing12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      activity.title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: AppDimensions.spacing4),

                    // Timestamp
                    Text(
                      activity.timestamp,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // Action Buttons (for connection requests)
                    if (activity.hasActions && onAccept != null && onDecline != null) ...[
                      SizedBox(height: AppDimensions.spacing12),
                      Row(
                        children: [
                          // Accept Button
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  double.infinity,
                                  AppDimensions.buttonHeightSmall,
                                ),
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textOnPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              onPressed: onAccept,
                              child: Text(
                                'accept'.tr,
                                style: AppTextStyles.buttonSmall,
                              ),
                            ),
                          ),

                          SizedBox(width: AppDimensions.spacing8),

                          // Decline Button
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(
                                  double.infinity,
                                  AppDimensions.buttonHeightSmall,
                                ),
                                foregroundColor: AppColors.textPrimary,
                                side: BorderSide(
                                  color: AppColors.borderLight,
                                  width: 1.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium,
                                  ),
                                ),
                              ),
                              onPressed: onDecline,
                              child: Text(
                                'decline'.tr,
                                style: AppTextStyles.buttonSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

