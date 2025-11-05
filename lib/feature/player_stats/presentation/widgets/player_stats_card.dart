import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../localization/app_localization.dart';

/// Player Stats Card Widget
/// Displays three main stats (Games, Goals, Assists) in a horizontal card
class PlayerStatsCard extends StatelessWidget {
  final int gamesPlayed;
  final int goals;
  final int assists;

  const PlayerStatsCard({
    super.key,
    required this.gamesPlayed,
    required this.goals,
    required this.assists,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.spacing16),
      decoration: AppDecorations.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('games_played'.tr, gamesPlayed.toString()),
          _buildDivider(),
          _buildStatItem('goals'.tr, goals.toString()),
          _buildDivider(),
          _buildStatItem('assists'.tr, assists.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.spacing4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: AppDimensions.dividerThickness,
      height: 40,
      color: AppColors.borderLight,
    );
  }
}

