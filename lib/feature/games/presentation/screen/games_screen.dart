import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/screens/base_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/ui/widgets/flutter_target/app_loader.dart';
import '../../../../localization/app_localization.dart';
import '../../../../core/navigation/nav.dart';
import '../state_m/games/games_cubit.dart';
import '../widgets/game_card.dart';
import 'game_details_screen.dart';

class GamesScreenParam {
  const GamesScreenParam();
}

class GamesScreen extends BaseScreen<GamesScreenParam> {
  static const routeName = "/GamesScreen";

  const GamesScreen({required super.param, super.key});

  @override
  State createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: Text(
          'games'.tr,
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.textPrimary,
              size: AppDimensions.iconLarge,
            ),
            onPressed: () {
              // Show coming soon message - create game screen will be implemented later
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'create_game_coming_soon'.tr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  backgroundColor: AppColors.info,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider<GamesCubit>(
        create: (context) => GamesCubit()..loadGames(),
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

            if (state is GamesLoadedState) {
              final games = state.gamesListEntity.games;

              if (games.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sports_soccer,
                        size: AppDimensions.iconXXLarge,
                        color: AppColors.textTertiary,
                      ),
                      SizedBox(height: AppDimensions.spacing16),
                      Text(
                        'no_games_found'.tr,
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<GamesCubit>().refreshGames();
                },
                backgroundColor: AppColors.surface,
                color: AppColors.primary,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: AppDimensions.spacing8,
                    bottom: AppDimensions.spacing16,
                  ),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return GameCard(
                      game: game,
                      onViewDetails: () {
                        Nav.to(
                          GameDetailsScreen.routeName,
                          arguments: GameDetailsScreenParam(gameId: game.id),
                        );
                      },
                    );
                  },
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

