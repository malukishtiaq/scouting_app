# Posts Feature - Quick Start 🚀

**API Documentation**: [https://scouting.terveys.io/docs](https://scouting.terveys.io/docs)

## ⚡ 3-Step Setup

### Step 1: Run Dependency Injection Generator (Already Done ✅)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 2: Import and Use
```dart
import 'package:scouting_app/feature/posts/posts_export.dart';
```

### Step 3: Add to Your App
```dart
// In your navigation or main screen:
PostsScreen()

// Or navigate to it:
Navigator.pushNamed(context, PostsScreen.routeName); // or '/posts'
```

That's it! The Posts screen is ready to use with:
- ✅ Automatic pagination (10 posts per page)
- ✅ Pull-to-refresh
- ✅ Error handling with retry
- ✅ Loading states
- ✅ Follows your app's design system
- ✅ No authentication required

## 📱 Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:scouting_app/feature/posts/posts_export.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostsScreen(), // That's it!
    );
  }
}
```

## 🎯 What You Get

- **PostsScreen**: Full-featured posts list with pagination
- **PostDetailWidget**: Beautiful post detail view
- **PostsCubit**: Complete state management
- **API Integration**: Connected to [Scouting API](https://scouting.terveys.io/docs)
- **Public API**: No authentication required
- **Paginated Data**: 10 posts per page with automatic loading

## 📚 Learn More

- **[Official API Docs](https://scouting.terveys.io/docs)** - Complete API reference with examples
- **[README.md](README.md)** - Full feature documentation and architecture
- **[INTEGRATION_EXAMPLE.dart](INTEGRATION_EXAMPLE.dart)** - 7 integration examples

## 🌐 API Details

**Base URL**: `https://scouting.terveys.io`  
**Authentication**: Not required (public API)  
**Available Endpoints**:
- `GET /api/posts` - List posts with pagination
- `GET /api/posts/{id}` - Get single post by ID

## 🎨 Preview

The Posts feature includes:
- User avatars and information
- Post titles and descriptions
- Media type badges (video/image)
- Like, comment, and share counts
- Automatic loading more posts on scroll
- Pull-to-refresh functionality
- Error handling with retry

All following your app's design system! ✨

