# Player Stats Feature

## Overview
Comprehensive player profile/stats screen designed according to Figma specifications. This feature displays player information, performance statistics, upcoming games, and media gallery.

## Features Implemented ✅

### 1. **Player Profile Header**
- Profile avatar with verified badge
- Cover image with gradient overlay
- Player name and username
- PRO badge for premium members
- Position display

### 2. **Action Buttons**
- Edit Profile button
- Upload Media button

### 3. **Performance Stats Card**
- Games Played
- Goals
- Assists
- Displayed in a horizontal card layout

### 4. **Player Information Section**
- Team
- Weight (with units)
- Average Location
- Height (with units)
- Graduation Class
- School Played For

### 5. **Upcoming Games List**
- Display up to 5 upcoming games
- Shows opponent, date, time, location
- Home/Away indicator with color coding
- Empty state handling

### 6. **Media Gallery**
- Grid layout (3 columns)
- Display up to 6 media items
- Video play button overlay
- Photo and video support
- Empty state handling

## Architecture

### Clean Architecture Layers:

```
lib/feature/player_stats/
├── domain/
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Business logic
├── data/
│   ├── datasources/       # Remote data sources
│   ├── repositories/      # Repository implementations
│   └── request/
│       ├── model/         # Data models
│       └── param/         # Request parameters
└── presentation/
    ├── screen/            # UI screens
    ├── state_m/          # State management (Cubit)
    └── widgets/          # Reusable widgets
```

## State Management

Uses **Bloc/Cubit** pattern with **Freezed** for state classes:

- `PlayerStatsInitial` - Initial state
- `PlayerStatsLoading` - Loading player data
- `PlayerStatsLoaded` - Player data loaded
- `PlayerStatsGamesLoaded` - Games data loaded
- `PlayerStatsMediaLoaded` - Media data loaded
- `PlayerStatsError` - Error state

## Styling System

### ✅ **100% Compliant with App Standards**

All styling follows the mandatory design system:

- **AppTextStyles** - All text styling
- **AppColors** - All colors
- **AppDimensions** - All spacing and sizes
- **AppDecorations** - All visual elements
- **Localization** - All text strings

### No Inline Styles
Zero hardcoded values. Everything references the standardized design system.

## Widgets Created

### 1. **PlayerStatsCard**
Displays three main performance statistics in a card.

### 2. **PlayerInfoItem**
Reusable widget for displaying label-value pairs with optional icons.

### 3. **UpcomingGamesList**
Displays a list of upcoming games with full details.

### 4. **MediaGallery**
Grid layout for displaying player photos and videos.

## Usage

### Basic Implementation

```dart
import 'package:scouting_app/feature/player_stats/player_stats_export.dart';

// Navigate to player stats screen
Navigator.pushNamed(
  context,
  PlayerStatsScreen.routeName,
  arguments: playerId,
);

// Or with direct navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PlayerStatsScreen(
      playerId: 'player_123',
    ),
  ),
);
```

### With BlocProvider

```dart
BlocProvider(
  create: (context) => PlayerStatsCubit(
    getPlayerUsecase: getIt<GetPlayerUsecase>(),
    updatePlayerUsecase: getIt<UpdatePlayerUsecase>(),
    uploadMediaUsecase: getIt<UploadMediaUsecase>(),
    getUpcomingGamesUsecase: getIt<GetUpcomingGamesUsecase>(),
    getPlayerMediaUsecase: getIt<GetPlayerMediaUsecase>(),
  ),
  child: PlayerStatsScreen(playerId: playerId),
)
```

## API Endpoints (TODO)

The following endpoints need to be defined in `EndPoints` class:

```dart
static const String getPlayer = '/api/player/get';
static const String updatePlayer = '/api/player/update';
static const String uploadPlayerMedia = '/api/player/media/upload';
static const String getUpcomingGames = '/api/player/games/upcoming';
static const String getPlayerMedia = '/api/player/media/list';
```

## Dependency Injection

Add to your service locator (GetIt):

```dart
// Data sources
getIt.registerLazySingleton<IPlayerRemoteDatasource>(
  () => PlayerRemoteDatasource(apiConsumer: getIt()),
);

// Repositories
getIt.registerLazySingleton<IPlayerRepository>(
  () => PlayerRepository(remoteDatasource: getIt()),
);

// Use cases
getIt.registerLazySingleton(() => GetPlayerUsecase(repository: getIt()));
getIt.registerLazySingleton(() => UpdatePlayerUsecase(repository: getIt()));
getIt.registerLazySingleton(() => UploadMediaUsecase(repository: getIt()));
getIt.registerLazySingleton(() => GetUpcomingGamesUsecase(repository: getIt()));
getIt.registerLazySingleton(() => GetPlayerMediaUsecase(repository: getIt()));

// Cubit
getIt.registerFactory(() => PlayerStatsCubit(
  getPlayerUsecase: getIt(),
  updatePlayerUsecase: getIt(),
  uploadMediaUsecase: getIt(),
  getUpcomingGamesUsecase: getIt(),
  getPlayerMediaUsecase: getIt(),
));
```

## Mock Data for Testing

For testing without backend:

```dart
final mockPlayer = PlayerEntity(
  playerId: '1',
  fullName: 'Ethan Carter',
  avatar: 'https://example.com/avatar.jpg',
  position: 'Forward',
  team: 'Lakers',
  weight: '180',
  height: '6.2',
  graduationClass: '2025',
  school: 'Springfield High',
  averageLocation: 'Los Angeles, CA',
  verified: true,
  isPro: true,
  stats: PlayerStatsEntity(
    gamesPlayed: 120,
    goals: 15,
    assists: 20,
  ),
);
```

## Code Generation

After making changes to models or state files, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Features to Implement (Future)

- [ ] Edit Profile functionality
- [ ] Upload Media functionality
- [ ] Video player integration
- [ ] Photo viewer with zoom
- [ ] Share profile functionality
- [ ] Report profile functionality
- [ ] Pull-to-refresh
- [ ] Pagination for games and media
- [ ] Real-time stats updates

## Design Reference

Based on Figma design:
https://www.figma.com/design/BUAwZJ4cMyf2qOc007VqnE/Scout-App?node-id=6-321

## Contributing

When adding new features:
1. Follow Clean Architecture principles
2. Use the standardized styling system (NO inline styles)
3. Add localization keys for all text
4. Write tests for use cases and widgets
5. Update this README

## License

Part of the Scouting App project.

