# Scouting API Implementation Summary

## Overview
All APIs from https://scouting.terveys.io/docs have been implemented following the existing account pattern using `RemoteDataSource`.

## Implementation Details

### 1. **API Endpoints** (lib/mainapis.dart)
Added all endpoint constants:
- Comments API: `apiCreateComment`, `apiUserComments`, `apiPostComments`
- Likes API: `apiToggleLike`, `apiUserLikes`, `apiPostLikes`
- Member API: `apiMemberRegister`, `apiMemberLogin`, `apiMemberMe`, `apiMemberUpdate`, `apiMemberList`, `apiMemberShow`
- Posts API: `apiPostsList`, `apiPostsShow`

### 2. **Comments API** (lib/feature/comments/)
**Endpoints:**
- POST `/api/comments/{post_id}` - Create comment
- GET `/api/posts/comments` - Get user comments
- GET `/api/posts/{post_id}/comments` - Get post comments

**Files Created:**
- **Params:** `create_comment_param.dart`, `get_user_comments_param.dart`, `get_post_comments_param.dart`
- **Entities:** `comment_response_entity.dart`
- **Models:** `comment_response_model.dart`
- **Datasource:** `icomments_remote.dart`, `comments_remote.dart`
- **Repository:** `icomments_repository.dart`, `comments_repository.dart`
- **Use Cases:** `create_comment_usecase.dart`, `get_user_comments_usecase.dart`, `get_post_comments_usecase.dart`

**Features:**
- Automatic cache invalidation on comment creation
- Invalidates: `['comments', 'newsfeed']`
- Full authentication support

### 3. **Likes API** (lib/feature/likes/)
**Endpoints:**
- POST `/api/likes/{post_id}` - Toggle like (add/remove)
- GET `/api/posts/likes` - Get user likes
- GET `/api/posts/{post_id}/likes` - Get post likes

**Files Created:**
- **Params:** `toggle_like_param.dart`, `get_user_likes_param.dart`, `get_post_likes_param.dart`
- **Entities:** `like_response_entity.dart`
- **Models:** `like_response_model.dart`
- **Datasource:** `ilikes_remote.dart`, `likes_remote.dart`
- **Repository:** `ilikes_repository.dart`, `likes_repository.dart`
- **Use Cases:** `toggle_like_usecase.dart`, `get_user_likes_usecase.dart`, `get_post_likes_usecase.dart`

**Features:**
- Automatic cache invalidation on like toggle
- Invalidates: `['likes', 'newsfeed']`
- Returns `isLiked` status after toggle
- Full authentication support

### 4. **Member APIs** (lib/feature/account/)
**Endpoints:**
- GET `/api/members/me` - Get current user profile
- POST `/api/members/update` - Update user profile
- GET `/api/members` - List all members
- GET `/api/members/{user_id}` - Get specific member profile

**Files Created/Modified:**
- **Params:** `get_me_param.dart`, `update_profile_param.dart`, `list_members_param.dart`, `show_member_param.dart`
- **Entities:** `member_response_entity.dart`
- **Models:** `member_response_model.dart`
- **Datasource:** Modified `iaccount_remote.dart` and `account_remote.dart`
- **Repository:** Modified `iaccount_repository.dart` and `account_repository.dart`
- **Use Cases:** `get_me_usecase.dart`, `update_profile_usecase.dart`, `list_members_usecase.dart`, `show_member_usecase.dart`

**Features:**
- Profile caching with automatic invalidation on update
- Supports athlete profile fields: age, weight, height, primaryPosition, preferredFoot
- Email verification status tracking
- Profile completeness indicator
- Full authentication support

### 5. **Posts API** (lib/feature/scouting_posts/)
**Endpoints:**
- GET `/api/posts?page={page}` - List posts with pagination
- GET `/api/posts/{post_id}` - Get single post

**Files Created:**
- **Params:** `get_posts_param.dart`, `get_post_by_id_param.dart`
- **Entities:** `post_response_entity.dart`
- **Models:** `post_response_model.dart`
- **Datasource:** `iscouting_posts_remote.dart`, `scouting_posts_remote.dart`
- **Repository:** `iscouting_posts_repository.dart`, `scouting_posts_repository.dart`
- **Use Cases:** `get_posts_usecase.dart`, `get_post_by_id_usecase.dart`

**Features:**
- Full pagination support with metadata
- Caching enabled for posts
- Includes: title, description, mediaUrl, mediaType, user info, likes/shares/comments counts
- Full authentication support

## Architecture Pattern

All implementations follow clean architecture with:

```
Feature/
├── data/
│   ├── datasource/
│   │   ├── i{feature}_remote.dart      (Interface)
│   │   └── {feature}_remote.dart       (Implementation)
│   └── request/
│       ├── param/                      (Request parameters)
│       └── model/                      (Response models)
├── domain/
│   ├── entity/                         (Domain entities)
│   ├── repository/
│   │   ├── i{feature}_repository.dart  (Interface)
│   │   └── {feature}_repository.dart   (Implementation)
│   └── usecase/                        (Business logic)
└── presentation/                       (UI layer - not implemented)
```

## Key Features

### 1. **Authentication**
- All endpoints use `withAuthentication: true`
- Token automatically injected via `RemoteDataSource`

### 2. **Caching**
- Automatic caching via `BaseParams`
- Cache keys auto-generated from params
- TTL configurable per feature
- Mutations auto-invalidate related caches

### 3. **Cache Invalidation**
Comments create: Invalidates `['comments', 'newsfeed']`
- Likes toggle: Invalidates `['likes', 'newsfeed']`
- Profile update: Invalidates `['profile']`

### 4. **Error Handling**
- Uses `Either<AppErrors, T>` pattern
- Custom error types per feature
- Network error recovery

### 5. **Logging**
- Configurable per-method logging
- Enabled for mutations, disabled for reads
- Via `enableLogging` parameter

## Usage Examples

### Comments
```dart
// Create comment
final usecase = getIt<CreateCommentUsecase>();
final result = await usecase(CreateCommentParam(
  postId: 1,
  comment: "Great post!",
));

// Get post comments
final usecase = getIt<GetPostCommentsUsecase>();
final result = await usecase(GetPostCommentsParam(postId: 1));
```

### Likes
```dart
// Toggle like
final usecase = getIt<ToggleLikeUsecase>();
final result = await usecase(ToggleLikeParam(postId: 1));

result.fold(
  (error) => print('Error: $error'),
  (response) => print('Liked: ${response.isLiked}'),
);
```

### Member
```dart
// Get current user
final usecase = getIt<GetMeUsecase>();
final result = await usecase(GetMeParam());

// Update profile
final usecase = getIt<UpdateProfileUsecase>();
final result = await usecase(UpdateProfileParam(
  age: 25,
  height: 180.0,
  weight: 75.0,
  primaryPosition: "Forward",
  preferredFoot: "Right",
));

// List members
final usecase = getIt<ListMembersUsecase>();
final result = await usecase(ListMembersParam());

// Show member
final usecase = getIt<ShowMemberUsecase>();
final result = await usecase(ShowMemberParam(userId: 1));
```

### Posts
```dart
// Get posts
final usecase = getIt<GetPostsUsecase>();
final result = await usecase(GetPostsParam(page: 1));

result.fold(
  (error) => print('Error: $error'),
  (response) {
    print('Posts: ${response.data.length}');
    print('Current page: ${response.meta.currentPage}');
    print('Has next: ${response.meta.hasNextPage}');
  },
);

// Get single post
final usecase = getIt<GetPostByIdUsecase>();
final result = await usecase(GetPostByIdParam(postId: 1));
```

## Next Steps

1. **Dependency Injection**: Run code generation
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **UI Implementation**: Create presentation layer with Cubits/Blocs

3. **Testing**: Write unit tests for use cases and repositories

4. **Integration**: Connect to existing UI or create new screens

## Notes

- All implementations use `@Injectable` and `@singleton` annotations
- Repository pattern with interfaces for testability
- No modifications to `remote_data_source.dart` or `http_client.dart`
- All models inherit from `BaseModel`
- All entities inherit from `BaseEntity`
- All params extend `BaseParams` with caching support
- Authentication tokens handled automatically
- Base URL from `MainAPIS.websiteUrl` (configurable via `WebsiteConstants`)

## API Documentation Reference
https://scouting.terveys.io/docs

