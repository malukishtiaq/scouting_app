# Posts Feature

This feature provides integration with the Scouting API for fetching and displaying posts.

## 📚 API Documentation

**Base URL**: `https://scouting.terveys.io`  
**Official Docs**: [https://scouting.terveys.io/docs](https://scouting.terveys.io/docs)  
**Configuration**: `lib/core/constants/website_constants.dart` → `WebsiteConstants.scoutingApiUrl`  
**Authentication**: ❌ Not required (public API)

### Available Endpoints

#### 1. **List Posts** - `GET /api/posts`
- **Description**: Returns paginated list of posts
- **Query Parameters**: 
  - `page` (integer, optional): The page number. Default: 1
- **Headers**:
  - `Content-Type: application/json`
  - `Accept: application/json`
- **Response**: 200 OK
  - `data`: Array of post objects
  - `links`: Pagination links (first, last, prev, next)
  - `meta`: Pagination metadata (current_page, last_page, per_page, total)

#### 2. **Get Post by ID** - `GET /api/posts/{post_id}`
- **Description**: Returns a single post by its ID
- **URL Parameters**:
  - `post_id` (integer, required): The ID of the post
- **Headers**:
  - `Content-Type: application/json`
  - `Accept: application/json`
- **Response**: 200 OK
  - `data`: Single post object

### Response Structure (from Official API)

#### List Posts Response (GET /api/posts)
```json
{
  "data": [
    {
      "id": 1,
      "title": "Facilis corporis et tempora ipsum.",
      "description": "Dolores consequatur minus ratione et omnis.",
      "media_url": "http://scouting.terveys.io/media/stream/1",
      "media_type": "video",
      "user": "TEST",
      "user_id": 1,
      "user_avatar": "https://scouting.terveys.io/images/default-avatar.png",
      "likes": 0,
      "shares": 0,
      "comments": 0
    }
  ],
  "links": {
    "first": "https://scouting.terveys.io/api/posts?page=1",
    "last": "https://scouting.terveys.io/api/posts?page=1",
    "prev": "https://scouting.terveys.io/api/posts?page=15",
    "next": null
  },
  "meta": {
    "current_page": 16,
    "from": null,
    "last_page": 1,
    "links": [
      {
        "url": "https://scouting.terveys.io/api/posts?page=15",
        "label": "&laquo; Previous",
        "page": 15,
        "active": false
      },
      {
        "url": "https://scouting.terveys.io/api/posts?page=1",
        "label": "1",
        "page": 1,
        "active": false
      },
      {
        "url": null,
        "label": "Next &raquo;",
        "page": null,
        "active": false
      }
    ],
    "path": "https://scouting.terveys.io/api/posts",
    "per_page": 10,
    "to": null,
    "total": 5
  }
}
```

#### Single Post Response (GET /api/posts/1)
```json
{
  "data": {
    "id": 1,
    "title": "Facilis corporis et tempora ipsum.",
    "description": "Dolores consequatur minus ratione et omnis.",
    "media_url": "http://scouting.terveys.io/media/stream/1",
    "media_type": "video",
    "user": "TEST",
    "user_id": 1,
    "user_avatar": "https://scouting.terveys.io/images/default-avatar.png",
    "likes": 0,
    "shares": 0,
    "comments": 0
  }
}
```

## 🏗️ Architecture

This feature follows Clean Architecture with three layers:

### Data Layer
- **Models**: `PostsResponseModel`, `PostModel`, `PaginationMetaModel`, `PaginationLinksModel`
- **Datasources**: `IPostsRemoteSource`, `PostsRemoteSource`
- **Params**: `GetPostsParam`, `GetPostByIdParam`

### Domain Layer
- **Entities**: `PostsResponseEntity`, `PostEntity`, `PaginationMeta`, `PaginationLinks`
- **Repositories**: `IPostsRepository`, `PostsRepository`
- **Use Cases**: `GetPostsUsecase`, `GetPostByIdUsecase`

### Presentation Layer
- **State Management**: `PostsCubit`, `PostsState`
- **Screens**: `PostsScreen`
- **Widgets**: `PostDetailWidget`

## 🚀 Usage

### 1. Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:scouting_app/feature/posts/posts_export.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostsScreen(),
    );
  }
}
```

### 2. Using PostsCubit Directly

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app/feature/posts/posts_export.dart';
import 'package:scouting_app/di/service_locator.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostsCubit>()..loadPosts(),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return CircularProgressIndicator();
          }
          
          if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostDetailWidget(post: post);
              },
            );
          }
          
          if (state is PostsError) {
            return Text('Error: ${state.error}');
          }
          
          return SizedBox.shrink();
        },
      ),
    );
  }
}
```

### 3. Loading Single Post by ID

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app/feature/posts/posts_export.dart';
import 'package:scouting_app/di/service_locator.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;
  
  const PostDetailPage({required this.postId});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PostsCubit>()..loadPostById(postId),
      child: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (state is PostDetailLoaded) {
            return PostDetailWidget(post: state.post);
          }
          
          if (state is PostDetailError) {
            return Center(child: Text('Error loading post'));
          }
          
          return SizedBox.shrink();
        },
      ),
    );
  }
}
```

### 4. Pagination

The `PostsCubit` automatically handles pagination:

```dart
// Load initial posts (page 1)
cubit.loadPosts();

// Load more posts (next page)
cubit.loadMorePosts();

// Refresh posts (reload from page 1)
cubit.refreshPosts();

// Check if has more pages
if (cubit.hasMorePages) {
  cubit.loadMorePosts();
}
```

The `PostsScreen` widget includes automatic pagination when scrolling to the bottom.

## 📊 State Management

### States

1. **PostsInitial** - Initial state before any data is loaded
2. **PostsLoading** - Loading initial posts
3. **PostsLoaded** - Posts loaded successfully
   - `posts`: List of posts
   - `meta`: Pagination metadata
   - `isLoadingMore`: Whether loading more posts
4. **PostsError** - Error loading posts
   - `error`: Error details
   - `retry`: Retry callback
5. **PostDetailLoading** - Loading single post
6. **PostDetailLoaded** - Single post loaded
   - `post`: Post details
7. **PostDetailError** - Error loading single post

### Cubit Methods

- `loadPosts()` - Load initial posts (page 1)
- `loadMorePosts()` - Load next page of posts
- `refreshPosts()` - Refresh posts from page 1
- `loadPostById(int postId)` - Load single post by ID

## 🎨 UI Components

### PostsScreen

A complete screen that displays a list of posts with:
- Pull-to-refresh
- Automatic pagination on scroll
- Loading states
- Error handling with retry
- Follows app design system (AppTextStyles, AppColors, AppDimensions, AppDecorations)

### PostDetailWidget

A widget to display full post details including:
- User information
- Media preview
- Title and description
- Like, comment, and share stats

## 🔧 Customization

### Custom Post Card

```dart
class CustomPostCard extends StatelessWidget {
  final PostEntity post;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card,
      child: Column(
        children: [
          Text(post.title, style: AppTextStyles.h2),
          Text(post.description, style: AppTextStyles.bodyMedium),
          // Add your custom UI
        ],
      ),
    );
  }
}
```

## 📝 Localization Keys

Add these keys to your localization file:

```dart
'posts_title': 'Posts',
'error_loading_posts': 'Error loading posts',
'retry': 'Retry',
'user_id': 'User ID',
'likes': 'Likes',
'comments': 'Comments',
'shares': 'Shares',
'video_media': 'Video Media',
'image_media': 'Image Media',
```

## 🧪 Testing the API

### Using cURL (from official docs)

#### Get Posts List
```bash
curl --request GET \
    --get "https://scouting.terveys.io/api/posts?page=1" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"
```

#### Get Single Post
```bash
curl --request GET \
    --get "https://scouting.terveys.io/api/posts/1" \
    --header "Content-Type: application/json" \
    --header "Accept: application/json"
```

### Unit Testing

```dart
void main() {
  group('PostsCubit', () {
    late PostsCubit cubit;
    
    setUp(() {
      cubit = PostsCubit(
        getPostsUsecase: mockGetPostsUsecase,
        getPostByIdUsecase: mockGetPostByIdUsecase,
      );
    });
    
    test('initial state is PostsInitial', () {
      expect(cubit.state, equals(PostsInitial()));
    });
    
    // Add more tests
  });
}
```

## 🔗 Dependencies

This feature requires:
- `flutter_bloc` - State management
- `injectable` - Dependency injection
- `dartz` - Functional programming (Either)
- `http` - HTTP requests
- `equatable` - Value equality

## 📦 Dependency Injection

The feature is automatically registered with Injectable. After adding this feature, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🌐 API Reference

See the full API documentation at: https://scouting.terveys.io/docs

## 📄 License

This feature is part of the Scouting App project.

