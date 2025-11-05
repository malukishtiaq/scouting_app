/// Player Stats Feature - Demo Usage Example
///
/// This file demonstrates how to use the Player Stats feature in your app.
/// Copy these examples and adapt them to your needs.

library player_stats_demo;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import the player stats feature
import 'player_stats_export.dart';
// Import for mock repository
import 'data/repositories/mock_player_repository.dart';

/// Example 1: Basic usage with mock data (for testing)
class PlayerStatsDemo extends StatelessWidget {
  const PlayerStatsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerStatsCubit(
        getPlayerUsecase: GetPlayerUsecase(
          repository: MockPlayerRepository(),
        ),
        updatePlayerUsecase: UpdatePlayerUsecase(
          repository: MockPlayerRepository(),
        ),
        uploadMediaUsecase: UploadMediaUsecase(
          repository: MockPlayerRepository(),
        ),
        getUpcomingGamesUsecase: GetUpcomingGamesUsecase(
          repository: MockPlayerRepository(),
        ),
        getPlayerMediaUsecase: GetPlayerMediaUsecase(
          repository: MockPlayerRepository(),
        ),
      ),
      child: const PlayerStatsScreen(playerId: 'demo_player_1'),
    );
  }
}

/// Example 2: Navigate to player stats from another screen
void navigateToPlayerStats(BuildContext context, String playerId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => PlayerStatsCubit(
          getPlayerUsecase: GetPlayerUsecase(
            repository: MockPlayerRepository(),
          ),
          updatePlayerUsecase: UpdatePlayerUsecase(
            repository: MockPlayerRepository(),
          ),
          uploadMediaUsecase: UploadMediaUsecase(
            repository: MockPlayerRepository(),
          ),
          getUpcomingGamesUsecase: GetUpcomingGamesUsecase(
            repository: MockPlayerRepository(),
          ),
          getPlayerMediaUsecase: GetPlayerMediaUsecase(
            repository: MockPlayerRepository(),
          ),
        ),
        child: PlayerStatsScreen(playerId: playerId),
      ),
    ),
  );
}

/// Example 3: Using in a route generator
///
/// Add this to your route generator:
/// ```dart
/// case PlayerStatsScreen.routeName:
///   final playerId = settings.arguments as String;
///   return MaterialPageRoute(
///     builder: (_) => BlocProvider(
///       create: (context) => getIt<PlayerStatsCubit>(),
///       child: PlayerStatsScreen(playerId: playerId),
///     ),
///   );
/// ```

/// Example 4: Named route navigation
void navigateToPlayerStatsNamed(BuildContext context, String playerId) {
  Navigator.pushNamed(
    context,
    PlayerStatsScreen.routeName,
    arguments: playerId,
  );
}

/// Example 5: Real implementation with GetIt dependency injection
///
/// In your service_locator.dart, add:
/// ```dart
/// // Data sources
/// getIt.registerLazySingleton<IPlayerRemoteDatasource>(
///   () => PlayerRemoteDatasource(apiConsumer: getIt()),
/// );
///
/// // Repositories
/// getIt.registerLazySingleton<IPlayerRepository>(
///   () => PlayerRepository(remoteDatasource: getIt()),
/// );
///
/// // Use cases
/// getIt.registerLazySingleton(() => GetPlayerUsecase(repository: getIt()));
/// getIt.registerLazySingleton(() => UpdatePlayerUsecase(repository: getIt()));
/// getIt.registerLazySingleton(() => UploadMediaUsecase(repository: getIt()));
/// getIt.registerLazySingleton(() => GetUpcomingGamesUsecase(repository: getIt()));
/// getIt.registerLazySingleton(() => GetPlayerMediaUsecase(repository: getIt()));
///
/// // Cubit
/// getIt.registerFactory(() => PlayerStatsCubit(
///   getPlayerUsecase: getIt(),
///   updatePlayerUsecase: getIt(),
///   uploadMediaUsecase: getIt(),
///   getUpcomingGamesUsecase: getIt(),
///   getPlayerMediaUsecase: getIt(),
/// ));
/// ```
///
/// Then use it like:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => BlocProvider(
///       create: (context) => getIt<PlayerStatsCubit>(),
///       child: PlayerStatsScreen(playerId: playerId),
///     ),
///   ),
/// );
/// ```

/// Example 6: Testing the feature
///
/// ```dart
/// testWidgets('Player stats screen loads correctly', (tester) async {
///   await tester.pumpWidget(
///     MaterialApp(
///       home: BlocProvider(
///         create: (context) => PlayerStatsCubit(
///           getPlayerUsecase: GetPlayerUsecase(
///             repository: MockPlayerRepository(),
///           ),
///           // ... other usecases
///         ),
///         child: PlayerStatsScreen(playerId: 'test_player'),
///       ),
///     ),
///   );
///
///   // Wait for loading to complete
///   await tester.pumpAndSettle();
///
///   // Verify player name is displayed
///   expect(find.text('Ethan Carter'), findsOneWidget);
///
///   // Verify stats are displayed
///   expect(find.text('120'), findsOneWidget); // Games
///   expect(find.text('15'), findsOneWidget);  // Goals
///   expect(find.text('20'), findsOneWidget);  // Assists
/// });
/// ```

/// Example 7: Handling state changes
class PlayerStatsWithStateHandling extends StatelessWidget {
  final String playerId;

  const PlayerStatsWithStateHandling({
    super.key,
    required this.playerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerStatsCubit(
        getPlayerUsecase: GetPlayerUsecase(
          repository: MockPlayerRepository(),
        ),
        updatePlayerUsecase: UpdatePlayerUsecase(
          repository: MockPlayerRepository(),
        ),
        uploadMediaUsecase: UploadMediaUsecase(
          repository: MockPlayerRepository(),
        ),
        getUpcomingGamesUsecase: GetUpcomingGamesUsecase(
          repository: MockPlayerRepository(),
        ),
        getPlayerMediaUsecase: GetPlayerMediaUsecase(
          repository: MockPlayerRepository(),
        ),
      ),
      child: BlocListener<PlayerStatsCubit, PlayerStatsState>(
        listener: (context, state) {
          state.maybeWhen(
            playerUpdated: (player) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            },
            mediaUploaded: (player, newMedia) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Media uploaded successfully!')),
              );
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${error.message}')),
              );
            },
            orElse: () {},
          );
        },
        child: PlayerStatsScreen(playerId: playerId),
      ),
    );
  }
}

/// Key Features Demonstrated:
///
/// 1. ✅ Clean Architecture with separation of concerns
/// 2. ✅ BLoC/Cubit state management
/// 3. ✅ Dependency injection ready
/// 4. ✅ Mock repository for testing
/// 5. ✅ Multiple navigation patterns
/// 6. ✅ State listening for user feedback
/// 7. ✅ Follows app design system (AppColors, AppTextStyles, etc.)
/// 8. ✅ Fully localized
/// 9. ✅ Error handling
/// 10. ✅ Loading states

