import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../localization/app_localization.dart';
import '../state_m/games/games_cubit.dart';

class GameDetailsScreenParam {
  final int gameId;

  const GameDetailsScreenParam({required this.gameId});
}

class GameDetailsScreen extends BaseScreen<GameDetailsScreenParam> {
  static const routeName = "/GameDetailsScreen";

  const GameDetailsScreen({required super.param, super.key});

  @override
  State createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Nav.pop(context),
        ),
        title: Text(
          'game_details'.tr,
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: BlocProvider<GamesCubit>(
        create: (context) => GamesCubit()..loadGameDetails(widget.param.gameId),
        child: BlocConsumer<GamesCubit, GamesState>(
          listener: (context, state) {
            state.whenOrNull(
              gamesError: (error, callback) async {
                // Handle error with snackbar
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${'error_occurred'.tr}: $error',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              gameJoined: (gameDetails) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'game_joined_successfully'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            if (state is GamesLoading) {
              return const Center(
                child: AppLoader(
                  isLoading: true,
                  child: SizedBox(),
                ),
              );
            }

            if (state is GameDetailsLoadedState || state is GameJoinedState) {
              final gameDetails = state is GameDetailsLoadedState
                  ? state.gameDetailsEntity
                  : (state as GameJoinedState).gameDetailsEntity;

              final game = gameDetails.game;
              final players = gameDetails.players;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimensions.spacing16),

                      // Hosted by Section - Dark Blue Card
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.spacing16),
                        decoration: AppDecorations.card,
                        child: Row(
                          children: [
                            Container(
                              width: AppDimensions.avatarXLarge,
                              height: AppDimensions.avatarXLarge,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.surfaceVariant,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusRound,
                                ),
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
                                  errorWidget: (context, url, error) =>
                                      Container(
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'hosted_by'.tr} ${game.hostName}',
                                    style: AppTextStyles.h6.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppDimensions.spacing4),
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

                      const SizedBox(height: AppDimensions.spacing16),

                      // Sport Type Section
                      Row(
                        children: [
                          const Icon(
                            Icons.sports_soccer,
                            size: AppDimensions.iconMedium,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: AppDimensions.spacing8),
                          Text(
                            game.sportType,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.spacing24),

                      // Players Section
                      Text(
                        'players'.tr,
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacing8),
                      Text(
                        '${game.playersCount} / ${game.maxPlayers} ${'players'.tr}',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.spacing24),

                      // Description Section
                      Text(
                        'description'.tr,
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacing8),
                      Text(
                        game.description,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.spacing24),

                      // Registered Players Section
                      if (players.isNotEmpty) ...[
                        Text(
                          'registered_players'.tr,
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing12),
                        ...players.map((player) => Container(
                              margin: const EdgeInsets.only(
                                bottom: AppDimensions.spacing12,
                              ),
                              padding:
                                  const EdgeInsets.all(AppDimensions.spacing16),
                              decoration: AppDecorations.card,
                              child: Row(
                                children: [
                                  Container(
                                    width: AppDimensions.avatarLarge,
                                    height: AppDimensions.avatarLarge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.surfaceVariant,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusRound,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: player.avatar,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: AppColors.surfaceVariant,
                                          child: const Icon(
                                            Icons.person,
                                            color: AppColors.textTertiary,
                                            size: AppDimensions.iconMedium,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: AppColors.surfaceVariant,
                                          child: const Icon(
                                            Icons.person,
                                            color: AppColors.textTertiary,
                                            size: AppDimensions.iconMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: AppDimensions.spacing12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          player.name,
                                          style:
                                              AppTextStyles.bodyMedium.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        if (player.position.isNotEmpty)
                                          Text(
                                            player.position,
                                            style: AppTextStyles.bodySmall
                                                .copyWith(
                                              color: AppColors.textTertiary,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (player.isHost)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimensions.spacing8,
                                        vertical: AppDimensions.spacing4,
                                      ),
                                      decoration: AppDecorations.hostBadge,
                                      child: Text(
                                        'host'.tr,
                                        style:
                                            AppTextStyles.labelSmall.copyWith(
                                          color: AppColors.textOnPrimary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )),
                      ],

                      const SizedBox(height: AppDimensions.spacing32),

                      // Join Game Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              AppDimensions.buttonHeightLarge,
                            ),
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textOnPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<GamesCubit>().joinGame(game.id);
                          },
                          child: Text(
                            'join_game'.tr,
                            style: AppTextStyles.buttonLarge,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimensions.spacing24),
                    ],
                  ),
                ),
              );
            }

            // Initial state - show loading
            return const Center(
              child: AppLoader(
                isLoading: true,
                child: SizedBox(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
