import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../localization/app_localization.dart';
import '../../../../mainapis.dart';
import '../../domain/entities/player_entity.dart';
import '../state_m/player_stats_cubit.dart';
import '../state_m/player_stats_state.dart';
import '../widgets/media_gallery.dart';
import '../widgets/player_info_item.dart';
import '../widgets/player_stats_card.dart';
import '../widgets/upcoming_games_list.dart';

/// Player Stats Screen - Main UI
/// Displays comprehensive player profile with stats, games, and media
class PlayerStatsScreen extends StatefulWidget {
  final String playerId;

  const PlayerStatsScreen({
    super.key,
    required this.playerId,
  });

  static const routeName = '/player-stats';

  @override
  State<PlayerStatsScreen> createState() => _PlayerStatsScreenState();
}

class _PlayerStatsScreenState extends State<PlayerStatsScreen> {
  late PlayerStatsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PlayerStatsCubit>();
    _cubit.loadPlayer(widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: BlocBuilder<PlayerStatsCubit, PlayerStatsState>(
        builder: (context, state) {
          return state.when(
            initial: () => _buildLoadingState(),
            loading: () => _buildLoadingState(),
            loaded: (player) => _buildPlayerProfile(player),
            error: (error) => _buildErrorState(error.message ?? 'error'.tr),
            gamesLoading: (player) => _buildPlayerProfile(player),
            gamesLoaded: (player, games) =>
                _buildPlayerProfile(player, games: games),
            mediaLoading: (player) => _buildPlayerProfile(player),
            mediaLoaded: (player, media) =>
                _buildPlayerProfile(player, media: media),
            mediaUploading: (player) => _buildPlayerProfile(player),
            mediaUploaded: (player, newMedia) => _buildPlayerProfile(player),
            playerUpdating: (player) => _buildPlayerProfile(player),
            playerUpdated: (player) => _buildPlayerProfile(player),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          Text(
            'loading_player_data'.tr,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimensions.iconXXLarge * 2,
              color: AppColors.error,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              'error_loading_player_data'.tr,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            ElevatedButton(
              onPressed: () => _cubit.loadPlayer(widget.playerId),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                minimumSize: const Size(200, AppDimensions.buttonHeightMedium),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
              child: Text('retry'.tr, style: AppTextStyles.buttonMedium),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerProfile(
    PlayerEntity player, {
    List<GameEntity>? games,
    List<MediaEntity>? media,
  }) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(player),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(player),
              const SizedBox(height: AppDimensions.spacing16),
              _buildActionButtons(),
              const SizedBox(height: AppDimensions.spacing24),
              _buildStatsSection(player),
              const SizedBox(height: AppDimensions.spacing24),
              _buildPlayerInfoSection(player),
              const SizedBox(height: AppDimensions.spacing24),
              _buildUpcomingGamesSection(player, games),
              const SizedBox(height: AppDimensions.spacing24),
              _buildMediaSection(player, media),
              const SizedBox(height: AppDimensions.spacing24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(PlayerEntity player) {
    final coverUrl = player.coverImage != null && player.coverImage!.isNotEmpty
        ? MainAPIS.getCoverImage(player.coverImage!)
        : '';

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textOnPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.textOnPrimary),
          onPressed: () => _showMoreOptions(context),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (coverUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: coverUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  decoration: AppDecorations.primaryGradient,
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: AppDecorations.primaryGradient,
                ),
              )
            else
              Container(
                decoration: AppDecorations.primaryGradient,
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.backgroundDark.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(PlayerEntity player) {
    final avatarUrl = player.avatar != null && player.avatar!.isNotEmpty
        ? MainAPIS.getCoverImage(player.avatar!)
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: AppDimensions.avatarXXXLarge,
                height: AppDimensions.avatarXXXLarge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.surface,
                      child: const Icon(
                        Icons.person,
                        size: AppDimensions.iconXLarge,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.surface,
                      child: const Icon(
                        Icons.person,
                        size: AppDimensions.iconXLarge,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ),
              if (player.verified == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppDimensions.spacing4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundDark,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.verified,
                      size: AppDimensions.iconMedium,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppDimensions.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        player.fullName ?? 'player_profile'.tr,
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (player.isPro == true) ...[
                      const SizedBox(width: AppDimensions.spacing8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing8,
                          vertical: AppDimensions.spacing4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.amber, Colors.orange],
                          ),
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSmall),
                        ),
                        child: Text(
                          'PRO',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing4),
                if (player.username != null)
                  Text(
                    '@${player.username}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                if (player.position != null) ...[
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(
                    player.position!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to edit profile screen
              },
              icon: const Icon(Icons.edit, size: AppDimensions.iconMedium),
              label: Text('edit_profile'.tr, style: AppTextStyles.buttonMedium),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                minimumSize: const Size(0, AppDimensions.buttonHeightMedium),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacing12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to upload media screen
              },
              icon: const Icon(Icons.upload, size: AppDimensions.iconMedium),
              label: Text('upload_media'.tr, style: AppTextStyles.buttonMedium),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.textPrimary,
                minimumSize: const Size(0, AppDimensions.buttonHeightMedium),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  side: const BorderSide(color: AppColors.borderLight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(PlayerEntity player) {
    if (player.stats == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: PlayerStatsCard(
        gamesPlayed: player.stats!.gamesPlayed ?? 0,
        goals: player.stats!.goals ?? 0,
        assists: player.stats!.assists ?? 0,
      ),
    );
  }

  Widget _buildPlayerInfoSection(PlayerEntity player) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      padding: const EdgeInsets.all(AppDimensions.spacing12),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.spacing12),
            child: Text(
              'player_info'.tr,
              style: AppTextStyles.h6.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Divider(color: AppColors.borderLight, height: 1),
          if (player.team != null)
            PlayerInfoItem(
              label: 'team'.tr,
              value: player.team!,
              icon: Icons.groups,
            ),
          if (player.weight != null)
            PlayerInfoItem(
              label: 'weight'.tr,
              value: '${player.weight} ${'lbs'.tr}',
              icon: Icons.fitness_center,
            ),
          if (player.averageLocation != null)
            PlayerInfoItem(
              label: 'average_location'.tr,
              value: player.averageLocation!,
              icon: Icons.location_on,
            ),
          if (player.height != null)
            PlayerInfoItem(
              label: 'height'.tr,
              value: '${player.height} ${'ft'.tr}',
              icon: Icons.height,
            ),
          if (player.graduationClass != null)
            PlayerInfoItem(
              label: 'graduation_class'.tr,
              value: player.graduationClass!,
              icon: Icons.school,
            ),
          if (player.school != null)
            PlayerInfoItem(
              label: 'school_played_for'.tr,
              value: player.school!,
              icon: Icons.account_balance,
            ),
        ],
      ),
    );
  }

  Widget _buildUpcomingGamesSection(
      PlayerEntity player, List<GameEntity>? games) {
    if (games == null) {
      return _buildLoadingSection('upcoming_games'.tr);
    }
    return UpcomingGamesList(games: games);
  }
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppDimensions.spacing12),
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing20),
            ListTile(
              leading: const Icon(Icons.share, color: AppColors.primary),
              title: Text('share'.tr, style: AppTextStyles.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                // TODO: Share profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.report, color: AppColors.warning),
              title: Text('product_report'.tr, style: AppTextStyles.bodyMedium),
              onTap: () {
                Navigator.pop(context);
                // TODO: Report profile
              },
            ),
            const SizedBox(height: AppDimensions.spacing20),
          ],
        ),
      ),
    );
  }
}
