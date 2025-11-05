import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../localization/app_localization.dart';
import '../cubit/explore_cubit.dart';
import '../../domain/entity/explore_player_entity.dart';

class ExploreScreenContent extends StatefulWidget {
  const ExploreScreenContent({super.key});

  @override
  State<ExploreScreenContent> createState() => _ExploreScreenContentState();
}

class _ExploreScreenContentState extends State<ExploreScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupFocusListener();
    // Load nearby players on init
    context.read<ExploreCubit>().loadNearbyPlayers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _setupFocusListener() {
    _searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  void _handleSearch(String query) {
    if (query.isEmpty) {
      context.read<ExploreCubit>().clearSearch();
    } else {
      context.read<ExploreCubit>().searchPlayers(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimensions.spacing16),

          // Search Bar
          TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            onChanged: _handleSearch,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'search'.tr,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textTertiary,
                size: AppDimensions.iconMedium,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.textTertiary,
                        size: AppDimensions.iconMedium,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _handleSearch('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16,
                vertical: AppDimensions.spacing12,
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.spacing32),

          // Section Title
          Text(
            'players_near_you'.tr,
            style: AppTextStyles.h5.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppDimensions.spacing24),

          // Players Grid
          state.when(
            exploreInit: () => _buildLoadingState(),
            exploreLoading: () => _buildLoadingState(),
            exploreLoadSuccess: (players) {
              if (players.isEmpty) {
                return _buildEmptyState();
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppDimensions.spacing24,
                  mainAxisSpacing: AppDimensions.spacing32,
                  childAspectRatio: 0.75,
                ),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return _buildPlayerCard(player: player);
                },
              );
            },
            exploreError: (error, callback) => _buildErrorState(callback),
            searchResults: (players, query) {
              if (players.isEmpty) {
                return _buildEmptyState();
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppDimensions.spacing24,
                  mainAxisSpacing: AppDimensions.spacing32,
                  childAspectRatio: 0.75,
                ),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return _buildPlayerCard(player: player);
                },
              );
            },
            exploreEmpty: (message) => _buildEmptyState(message: message),
          ),

          const SizedBox(height: AppDimensions.spacing40),
        ],
        ),
      );
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing40),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildEmptyState({String? message}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: AppDimensions.iconXXLarge,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              message ?? 'explore_no_players'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(VoidCallback retry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing40),
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
              'error_occurred'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            ElevatedButton(
              onPressed: retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
              child: Text(
                'retry'.tr,
                style: AppTextStyles.buttonMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCard({
    required ExplorePlayerEntity player,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to player profile
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile Image
          Container(
            width: AppDimensions.avatarXXXLarge + AppDimensions.spacing32,
            height: AppDimensions.avatarXXXLarge + AppDimensions.spacing32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(
                color: AppColors.borderLight,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: AppDimensions.shadowBlur,
                  offset: const Offset(0, AppDimensions.shadowOffset),
                ),
              ],
            ),
            child: ClipOval(
              child: player.avatar != null && player.avatar!.isNotEmpty
                  ? Image.network(
                      player.avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.surface,
                          child: Icon(
                            Icons.person,
                            size: AppDimensions.iconXLarge,
                            color: AppColors.textTertiary,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: AppColors.surface,
                      child: Icon(
                        Icons.person,
                        size: AppDimensions.iconXLarge,
                        color: AppColors.textTertiary,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: AppDimensions.spacing12),

          // Player Name
          Text(
            player.fullName ?? player.username ?? 'Unknown Player',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

