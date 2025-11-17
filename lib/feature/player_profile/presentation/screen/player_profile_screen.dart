import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../localization/app_localization.dart';
import '../../../../di/service_locator.dart';
import '../../../account/domain/entity/member_response_entity.dart';
import '../cubit/player_profile_cubit.dart';
import '../cubit/player_profile_state.dart';

/// Read-only screen for viewing another player's profile
/// Separate from MyProfileScreen which is editable
class PlayerProfileScreen extends StatelessWidget {
  static const String routeName = '/player-profile';

  final String playerId;
  final MemberDataEntity? playerData; // Optional: pass data directly

  const PlayerProfileScreen({
    super.key,
    required this.playerId,
    this.playerData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PlayerProfileCubit>()..loadPlayer(playerId, playerData),
      child: const PlayerProfileView(),
    );
  }
}

class PlayerProfileView extends StatefulWidget {
  const PlayerProfileView({super.key});

  @override
  State<PlayerProfileView> createState() => _PlayerProfileViewState();
}

class _PlayerProfileViewState extends State<PlayerProfileView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
        builder: (context, state) {
          if (state is PlayerProfileLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is PlayerProfileError) {
            return _buildErrorState(state.message);
          }

          if (state is PlayerProfileLoaded) {
            return _buildProfileContent(state.player);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimensions.iconXXLarge,
            color: AppColors.error,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          Text(
            message,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('go_back'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(MemberDataEntity player) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(player),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.spacing16),
              _buildActionButtons(player),
              const SizedBox(height: AppDimensions.spacing16),
              _buildStatsRow(player),
              const SizedBox(height: AppDimensions.spacing16),
              _buildOverviewCard(player),
              const SizedBox(height: AppDimensions.spacing16),
              _buildTabSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(MemberDataEntity player) {
    final name = player.name.isNotEmpty
        ? player.name
        : player.username ?? player.email.split('@').first;
    final position = player.primaryPosition ?? 'Player';
    final age = player.age ?? '';
    final location =
        'location'.tr; // You can add location field to MemberDataEntity

    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.textOnPrimary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundDark,
                AppColors.backgroundDark.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppDimensions.spacing40),
              _buildAvatar(player),
              const SizedBox(height: AppDimensions.spacing16),
              Text(
                name,
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                '$position${age.toString().isNotEmpty ? " | $age" : ""}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (location.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppDimensions.spacing4),
                  child: Text(
                    location,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(MemberDataEntity player) {
    final avatar = player.avatar;
    final isDefaultAvatar = avatar.contains('default-avatar.png');
    final name = player.name.isNotEmpty
        ? player.name
        : player.username ?? player.email.split('@').first;

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isDefaultAvatar
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.6),
                  AppColors.accent.withOpacity(0.6),
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: isDefaultAvatar
            ? _buildInitialsAvatar(name)
            : Image.network(
                avatar,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitialsAvatar(name);
                },
              ),
      ),
    );
  }

  Widget _buildInitialsAvatar(String name) {
    final initials = _getInitials(name);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.accent.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTextStyles.h1.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  Widget _buildActionButtons(MemberDataEntity player) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TODO: Implement connect functionality
                _showSnackBar('connect_coming_soon'.tr);
              },
              child: Container(
                decoration: AppDecorations.secondaryButton,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spacing12,
                ),
                alignment: Alignment.center,
                child: Text(
                  'connect'.tr,
                  style: AppTextStyles.buttonMedium.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacing12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TODO: Implement challenge functionality
                _showSnackBar('challenge_coming_soon'.tr);
              },
              child: Container(
                decoration: AppDecorations.primaryButton,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.spacing12,
                ),
                alignment: Alignment.center,
                child: Text(
                  'challenge'.tr,
                  style: AppTextStyles.buttonMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(MemberDataEntity player) {
    // TODO: Replace with real stats from API
    final stats = [
      {'label': 'connections'.tr, 'value': '120'},
      {'label': 'hosted'.tr, 'value': '15'},
      {'label': 'completed'.tr, 'value': '20'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats
            .map((stat) => _buildStatCard(stat['label']!, stat['value']!))
            .toList(),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: AppDecorations.card.copyWith(
        border: Border.all(
          color: AppColors.surface.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(MemberDataEntity player) {
    final info = [
      {'label': 'age'.tr, 'value': player.age?.toString() ?? 'N/A'},
      {
        'label': 'weight'.tr,
        'value': player.weight != null ? '${player.weight} kg' : 'N/A'
      },
      {
        'label': 'height'.tr,
        'value': player.height != null ? '${player.height} cm' : 'N/A'
      },
      {
        'label': 'primary_position'.tr,
        'value': player.primaryPosition ?? 'N/A'
      },
      {'label': 'preferred_foot'.tr, 'value': player.preferredFoot ?? 'N/A'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing16),
      child: Container(
        decoration: AppDecorations.card,
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'player_overview'.tr,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            ...info.map((Map<String, dynamic> item) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppDimensions.spacing12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['label'] as String,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        item['value'],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textTertiary,
          indicatorColor: AppColors.primary,
          labelStyle: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: 'videos'.tr),
            Tab(text: 'images'.tr),
          ],
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildComingSoon(),
              _buildComingSoon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Text(
        'coming_soon'.tr,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
