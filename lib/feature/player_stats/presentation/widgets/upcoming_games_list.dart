import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../localization/app_localization.dart';
import '../../domain/entities/player_entity.dart';

/// Upcoming Games List Widget
/// Displays a list of upcoming games for the player
class UpcomingGamesList extends StatelessWidget {
  final List<GameEntity> games;

  const UpcomingGamesList({
    super.key,
    required this.games,
  });

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
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
                'upcoming_games'.tr,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              if (games.length > 3)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all games screen
                  },
                  child: Text(
                    'view_all_games'.tr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.spacing12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
          itemCount: games.length > 5 ? 5 : games.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppDimensions.spacing12),
          itemBuilder: (context, index) {
            return _buildGameCard(games[index]);
          },
        ),
      ],
    );
  }

  Widget _buildGameCard(GameEntity game) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${'vs'.tr} ${game.opponent ?? 'unknown'.tr}',
                  style: AppTextStyles.h6.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing8,
                  vertical: AppDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  color: game.homeAway?.toLowerCase() == 'home'
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.info.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSmall),
                ),
                child: Text(
                  game.homeAway ?? '',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: game.homeAway?.toLowerCase() == 'home'
                        ? AppColors.success
                        : AppColors.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.spacing8),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: AppDimensions.iconSmall,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: AppDimensions.spacing8),
              Text(
                game.date ?? '',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: AppDimensions.spacing16),
              Icon(
                Icons.access_time,
                size: AppDimensions.iconSmall,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: AppDimensions.spacing8),
              Text(
                game.time ?? '',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (game.location != null && game.location!.isNotEmpty) ...[
            SizedBox(height: AppDimensions.spacing8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: AppDimensions.iconSmall,
                  color: AppColors.textTertiary,
                ),
                SizedBox(width: AppDimensions.spacing8),
                Expanded(
                  child: Text(
                    game.location!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
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
              Icons.event_busy,
              size: AppDimensions.iconXXLarge,
              color: AppColors.textTertiary,
            ),
            SizedBox(height: AppDimensions.spacing16),
            Text(
              'no_upcoming_games'.tr,
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

