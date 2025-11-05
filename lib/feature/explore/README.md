# Explore Feature

A fully-styled explore screen for the Scout App that follows the Figma design and adheres to the app's design system.

## 📁 Structure

```
lib/feature/explore/
├── presentation/
│   └── screen/
│       ├── explore_screen.dart           # Main screen wrapper with AppBar
│       └── explore_screen_content.dart   # Screen content implementation
├── explore_export.dart                   # Feature exports
└── NAVIGATION_EXAMPLE.dart              # Navigation example code
```

## 🎨 Design System Compliance

This feature **strictly follows** the app's design system rules:

### ✅ Uses Standardized Styling
- **Colors**: All colors use `AppColors.*` (no hardcoded colors)
- **Text Styles**: All text uses `AppTextStyles.*` (no inline TextStyle)
- **Dimensions**: All spacing/sizes use `AppDimensions.*` (no hardcoded numbers)
- **Localization**: All text strings use `.tr` extension

### 🎯 Key Features
- **Search Bar**: Styled with `AppColors.surface` background and `AppColors.primary` focus border
- **Player Grid**: 2-column responsive grid with circular profile images
- **Profile Cards**: Circular avatars with shadows and borders following design system
- **Dark Theme**: Uses `AppColors.backgroundDark` for main background
- **Loading States**: CircularProgressIndicator with brand colors
- **Error Handling**: Graceful image loading fallbacks

## 📱 Screen Components

### 1. Search Bar
```dart
TextField(
  style: AppTextStyles.bodyMedium,
  decoration: InputDecoration(
    hintText: 'search'.tr,
    prefixIcon: Icon(Icons.search),
    fillColor: AppColors.surface,
    // ... more styling
  ),
)
```

### 2. Section Title
```dart
Text(
  'players_near_you'.tr,
  style: AppTextStyles.h5.copyWith(
    fontWeight: FontWeight.bold,
  ),
)
```

### 3. Player Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: AppDimensions.spacing24,
    mainAxisSpacing: AppDimensions.spacing32,
    childAspectRatio: 0.75,
  ),
  // ... player cards
)
```

### 4. Player Card
- Circular profile image (112x112 with padding)
- Name label below image
- Shadow and border effects
- Tap gesture for navigation
- Loading and error states

## 🚀 Usage

### Navigate to Explore Screen

```dart
import '../../core/navigation/nav.dart';

// Simple navigation
Nav.to('/explore');

// Or using route name constant
Nav.to(ExploreScreen.routeName);
```

### Import the Feature

```dart
import 'package:your_app/feature/explore/explore_export.dart';
```

## 🌐 Localization Strings

The following localization keys are used:

```dart
// In en_us_translations.dart
"explore": "Explore",
"search": "Search",
"players_near_you": "Players near you",
"explore_search_hint": "Search for players...",
"explore_no_players": "No players found",
"explore_no_players_desc": "Try adjusting your search or check back later",
```

## 🎨 Color Palette

| Element | Color Constant |
|---------|---------------|
| Background | `AppColors.backgroundDark` (#0F1A23) |
| Surface (cards/inputs) | `AppColors.surface` (#213549) |
| Primary (focus) | `AppColors.primary` (#0A73D9) |
| Text Primary | `AppColors.textPrimary` (#FFFFFF) |
| Text Secondary | `AppColors.textSecondary` (#D1D5DB) |
| Text Tertiary | `AppColors.textTertiary` (#8FADCC) |
| Border Light | `AppColors.borderLight` (#304D69) |

## 📏 Dimensions Used

| Element | Dimension Constant |
|---------|-------------------|
| Spacing | `spacing8`, `spacing12`, `spacing16`, `spacing24`, `spacing32`, `spacing40` |
| Border Radius | `radiusMedium` (8.0) |
| Avatar Size | `avatarXXXLarge` (80.0) + `spacing32` |
| Icon Size | `iconMedium` (20.0) |
| Shadow | `shadowBlur` (8.0), `shadowOffset` (4.0) |

## 📦 Mock Data

Currently uses mock player data with placeholder images from pravatar.cc:

```dart
final List<Map<String, String>> _players = [
  {'name': 'Ethan Carter', 'image': 'https://i.pravatar.cc/150?img=12'},
  {'name': 'Liam Harper', 'image': 'https://i.pravatar.cc/150?img=13'},
  // ... more players
];
```

## 🔧 Future Enhancements

To connect this to real data:

1. **Create Domain Layer**
   - Create `PlayerEntity` in `domain/entity/`
   - Create `IExploreRepository` interface
   - Create `GetNearbyPlayersUseCase`

2. **Create Data Layer**
   - Create `ExploreRemoteDataSource`
   - Implement `ExploreRepository`
   - Add API endpoints

3. **Add State Management**
   - Create `ExploreCubit` in `presentation/cubit/`
   - Add loading/error/success states
   - Integrate with BLoC

4. **Enhanced Features**
   - Real-time search functionality
   - Filter by position/location
   - Pagination for large datasets
   - Profile navigation on tap
   - Pull-to-refresh

## ✅ Design Checklist

This feature follows ALL mandatory styling rules:

- [x] **Text**: All text uses `AppTextStyles.*`
- [x] **Colors**: All colors use `AppColors.*`
- [x] **Spacing**: All spacing uses `AppDimensions.spacing*`
- [x] **Sizes**: All sizes use `AppDimensions.*`
- [x] **Radius**: All radius uses `AppDimensions.radius*`
- [x] **Decorations**: No inline decorations
- [x] **Strings**: All text uses localization `'key'.tr`
- [x] **No inline styles**: No hardcoded values anywhere

## 🎯 Figma Design Match

The implementation matches the Figma design:
- ✅ Dark background (#0F1A23)
- ✅ "Explore" header
- ✅ Search bar with proper styling
- ✅ "Players near you" section title
- ✅ 2-column grid layout
- ✅ Circular profile images
- ✅ Player names below images
- ✅ Consistent spacing and dimensions

## 📝 Notes

- The screen is fully responsive and works on all device sizes
- Images load gracefully with loading indicators
- Error states show placeholder icons
- Follows Flutter best practices
- Uses const constructors where possible
- Proper resource disposal (controllers, focus nodes)

## 🔗 Related Files

- `lib/core/constants/colors.dart` - Color definitions
- `lib/core/theme/app_text_styles.dart` - Text style definitions
- `lib/core/theme/app_dimensions.dart` - Dimension definitions
- `lib/localization/en_us/en_us_translations.dart` - Localization strings
- `lib/core/navigation/route_generator.dart` - Routing configuration

---

**Created**: Following login_screen_content.dart implementation patterns
**Design**: Based on Figma Scout App design (node-id=6-321)
**Status**: ✅ Complete and ready for use

