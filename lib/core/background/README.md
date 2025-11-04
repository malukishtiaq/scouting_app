# Generic Background Service

## 🎯 Overview

The Generic Background Service is a pluggable, reusable background service that can handle any API call using isolates. It replaces the need to create separate background services for each feature while maintaining backward compatibility.

## 🚀 Key Features

- **🔌 Pluggable**: Configure any API endpoint, method, headers, and body fields
- **🔄 Reusable**: Same service handles newsfeed, stories, notifications, etc.
- **⚡ Isolate-Based**: Heavy JSON parsing happens in background threads
- **🛡️ Safe**: All generics inherit from base classes for type safety
- **📱 Non-Blocking**: UI remains responsive during API calls
- **🔄 Backward Compatible**: Existing services continue to work

## 🏗️ Architecture

```
GenericBackgroundService
├── executeApiCall() - Main generic method
├── executeNewsfeedCall() - Pre-configured newsfeed
├── executeStoriesCall() - Pre-configured stories
└── executeCustomApiCall() - Fully customizable
```

## 📖 Usage Examples

### 1. **Pre-configured API Calls**

```dart
// Newsfeed (backward compatible)
final result = await genericService.executeNewsfeedCall(
  limit: '20',
  afterPostId: '0',
  postType: 'all',
);

// Stories
final result = await genericService.executeStoriesCall(
  limit: '15',
  afterStoryId: '0',
);
```

### 2. **Custom API Calls**

```dart
// Fully customizable API call
final result = await genericService.executeCustomApiCall(
  apiUrl: 'https://api.example.com/endpoint',
  taskName: 'CustomTaskName',
  method: 'POST',
  headers: {'Authorization': 'Bearer token'},
  bodyFields: {
    'param1': 'value1',
    'param2': 'value2',
  },
  queryParams: {'filter': 'active'},
  timeout: Duration(seconds: 30),
);
```

### 3. **Using API Configs**

```dart
// Create custom configuration
final config = GenericApiConfig(
  apiUrl: 'https://api.example.com/endpoint',
  method: 'POST',
  bodyFields: {'key': 'value'},
  taskName: 'MyCustomTask',
  timeout: Duration(seconds: 20),
);

// Execute with config
final result = await genericService.executeApiCall(config: config);
```

## 🔧 Configuration

### GenericApiConfig Properties

- **`apiUrl`** (required): The API endpoint URL
- **`method`**: HTTP method (GET, POST, PUT, DELETE) - defaults to POST
- **`headers`**: Custom HTTP headers
- **`bodyFields`**: Form fields for POST requests
- **`queryParams`**: URL query parameters
- **`taskName`** (required): Unique identifier for the task
- **`timeout`**: Request timeout - defaults to 30 seconds

### Pre-configured Configs

```dart
// Newsfeed config
ApiConfigs.newsfeed(
  afterPostId: '0',
  limit: '20',
  postType: 'all',
)

// Stories config
ApiConfigs.stories(
  afterStoryId: '0',
  limit: '15',
  userId: '123',
)

// Custom config
ApiConfigs.custom(
  apiUrl: 'https://api.example.com/endpoint',
  taskName: 'CustomTask',
  method: 'GET',
  headers: {'Custom-Header': 'value'},
)
```

## 🎨 Integration with Features

### 1. **Newsfeed Integration**

```dart
@injectable
class NewsFeedRepository {
  final GenericBackgroundService _genericService;
  
  Future<Result<AppErrors, NewsFeedResponseEntity>> getNewsFeedFromBackground(
      GetNewsFeedParam param) async {
    
    final result = await _genericService.executeNewsfeedCall(
      afterPostId: param.offset,
      limit: param.limit,
      postType: param.postType,
    );
    
    // Process result...
  }
}
```

### 2. **Stories Integration**

```dart
@injectable
class StoriesBackgroundService {
  final GenericBackgroundService _genericService;
  
  Future<Map<String, dynamic>> fetchStoriesInBackground({
    String? afterStoryId,
    String? limit,
  }) async {
    
    return await _genericService.executeStoriesCall(
      afterStoryId: afterStoryId,
      limit: limit,
    );
  }
}
```

### 3. **Custom Feature Integration**

```dart
@injectable
class CustomFeatureService {
  final GenericBackgroundService _genericService;
  
  Future<Map<String, dynamic>> fetchCustomData() async {
    
    return await _genericService.executeCustomApiCall(
      apiUrl: 'https://api.example.com/custom',
      taskName: 'CustomFeatureTask',
      method: 'POST',
      bodyFields: {
        'server_key': MainAPIS.serverKey,
        'type': 'custom_action',
        'param1': 'value1',
      },
    );
  }
}
```

## 🔒 Type Safety

All generics inherit from base classes to ensure type safety:

- **`GenericApiConfig`**: Configuration object with validation
- **`GenericApiTask`**: Implements `IsolateTask` interface
- **`GenericBackgroundService`**: Injectable singleton service

## 🚫 What NOT to Do

- ❌ Don't create separate background services for each feature
- ❌ Don't hardcode API URLs in feature code
- ❌ Don't skip error handling in background tasks
- ❌ Don't forget to include `server_key` in body fields

## ✅ What ALWAYS to Do

- ✅ Use the generic service for all background API calls
- ✅ Configure API endpoints through `GenericApiConfig`
- ✅ Handle errors gracefully with proper logging
- ✅ Include proper timeouts for background operations
- ✅ Use pre-configured configs when available

## 🧪 Testing

Use the `TestGenericService` class to verify functionality:

```dart
@injectable
class TestGenericService {
  final GenericBackgroundService _genericService;
  
  Future<void> runAllTests() async {
    await testNewsfeedCall();
    await testStoriesCall();
    await testCustomApiCall();
  }
}
```

## 🔄 Migration from Old Services

1. **Keep existing services** - they continue to work
2. **Gradually migrate** to generic service
3. **Update repositories** to use generic service
4. **Remove old services** after migration is complete

## 📱 Performance Benefits

- **UI Responsiveness**: No main thread blocking
- **Background Processing**: Heavy operations in isolates
- **Smart Caching**: Configurable cache strategies
- **Error Handling**: Graceful fallbacks and retries

## 🎯 Future Enhancements

- **Retry Policies**: Configurable retry strategies
- **Rate Limiting**: Prevent API abuse
- **Circuit Breaker**: Handle API failures gracefully
- **Metrics**: Track API performance and usage

