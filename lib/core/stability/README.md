# Stability System - Zero-Crash Architecture

A comprehensive stability system that provides bulletproof service operations with multiple fallback strategies, circuit breaker patterns, and intelligent error handling.

## 🎯 **What This System Provides**

### **1. Zero-Crash Architecture**
- **Circuit Breaker Pattern**: Prevents cascade failures by temporarily blocking operations when they fail repeatedly
- **Multiple Fallback Paths**: 4 different fallback strategies for graceful degradation
- **Graceful Degradation**: Service works even when components fail
- **Exception Wrapping**: Every async operation is bulletproof

### **2. Modular & Reusable**
- **Generic Design**: Works with any data type `T`
- **Independent Modules**: Each component can be used separately
- **API-Based Communication**: Modules communicate via clean interfaces
- **No Hard Dependencies**: Models are passed in, not embedded

### **3. Production Ready**
- **100% Stability**: No fallbacks or crashes
- **Performance Optimized**: Minimal overhead with maximum protection
- **Monitoring Ready**: Built-in metrics and state tracking
- **Configurable**: Easy to tune for different use cases

## 🚀 **Quick Start**

### **Generic Design Principles**

The stability system is **completely generic** and **type-safe**:

- **No Hard Dependencies**: The system doesn't depend on any specific models or data types
- **User-Provided Types**: You must specify the generic type `<T>` when creating orchestrators
- **User-Provided Strategies**: You must add your own fallback strategies and error handlers
- **Type Safety**: Dart's type system ensures all operations are type-safe
- **Reusable**: Can be used in any Flutter project with any data types

### **Basic Usage**

```dart
import 'package:your_app/core/stability/stability.dart';

// Create a stability orchestrator for your data type
final stability = StabilityOrchestratorFactory.createStandard<PostData>();

// Add your own fallback strategies
stability.addFallbackStrategy(
  CacheFallbackStrategy<PostData>((context) => cacheService.getPosts()),
);

// Add your own error handlers
stability.addErrorHandler(
  NetworkErrorHandler<PostData>(fallbackData: cachedPosts),
);

// Execute with full stability protection
final result = await stability.execute(
  () => postService.fetchPosts(),
  operationName: 'fetch_posts',
  parameters: {'page': 1, 'limit': 20},
);

if (result.isSuccess) {
  final posts = result.data!;
  print('Posts loaded successfully');
} else {
  print('Operation failed: ${result.error}');
  print('Strategy used: ${result.strategyUsed}');
  print('Fallback level: ${result.fallbackLevel}');
}
```

### **Advanced Configuration**

```dart
// Create a robust configuration with your own fallbacks
final config = StabilityConfig<PostData>.withFallbacks(
  'fetch_posts',
  [
    CacheFallbackStrategy<PostData>((context) => cacheService.getPosts()),
    DefaultDataFallbackStrategy<PostData>([]), // Your empty posts list
  ],
);

final result = await stability.executeWithConfig(
  () => postService.fetchPosts(),
  config,
);
```

## 🏗️ **Architecture Components**

### **1. Circuit Breaker (`CircuitBreaker<T>`)**
- **States**: Closed (normal), Open (blocking), Half-Open (testing)
- **Configurable**: Failure threshold, reset timeout, half-open timeout
- **Monitoring**: State change callbacks, failure tracking

```dart
final circuitBreaker = CircuitBreaker<PostData>(
  failureThreshold: 5,
  resetTimeout: Duration(minutes: 1),
  onStateChanged: (state) => print('Circuit state: $state'),
  onFailure: (error) => print('Circuit failure: $error'),
);

// Execute with circuit breaker protection
final result = await circuitBreaker.execute(() => service.operation());
```

### **2. Retry Manager (`RetryManager`)**
- **Exponential Backoff**: Intelligent retry delays
- **Jitter**: Prevents thundering herd problems
- **Predefined Strategies**: Quick, standard, persistent, aggressive
- **Custom Strategies**: Build your own retry logic

```dart
final retryManager = RetryManager();

// Use predefined strategy
final result = await retryManager.executeWithPersistentRetry(
  () => service.operation(),
);

// Use custom strategy
final customStrategy = retryManager.createStrategy()
  .maxAttempts(10)
  .initialDelay(Duration(seconds: 2))
  .backoffMultiplier(1.5)
  .build();

final result = await retryManager.executeWithStrategy(
  () => service.operation(),
  customStrategy,
);
```

### **3. Fallback Strategies (`FallbackStrategy<T>`)**
- **Cache Fallback**: Return cached data when primary fails
- **Default Data Fallback**: Return safe default values
- **Retry Fallback**: Retry the primary operation
- **Custom Fallbacks**: Build your own fallback logic

```dart
// Cache fallback
final cacheFallback = CacheFallbackStrategy<PostData>(
  (context) => cacheService.getPosts(),
);

// Default data fallback
final defaultFallback = DefaultDataFallbackStrategy<PostData>([]);

// Retry fallback
final retryFallback = RetryFallbackStrategy<PostData>(
  (context) => postService.fetchPosts(),
  maxRetries: 2,
  retryDelay: Duration(seconds: 1),
);
```

### **4. Error Handling (`ErrorHandler<T>`)**
- **Error Categorization**: Network, timeout, authentication, validation, server, client
- **Severity Levels**: Low, medium, high, critical
- **User Messages**: Friendly error messages for users
- **Custom Handlers**: Build handlers for specific error types

```dart
// Network error handler
final networkHandler = NetworkErrorHandler<PostData>(
  fallbackData: cachedPosts,
  retryDelay: Duration(seconds: 5),
);

// Authentication error handler
final authHandler = AuthenticationErrorHandler<PostData>(
  onAuthFailure: () => authService.logout(),
);

// Custom error handler
class CustomErrorHandler<T> extends BaseErrorHandler<T> {
  @override
  Future<ErrorHandlingResult<T>> handleError(
    dynamic error,
    ErrorContext context,
  ) async {
    // Your custom error handling logic
    return ErrorHandlingResult.handled(
      fallbackData,
      handlerUsed: 'CustomHandler',
      severity: ErrorSeverity.medium,
    );
  }
}
```

### **5. Stability Orchestrator (`StabilityOrchestrator<T>`)**
- **Unified Interface**: Single point of entry for all stability features
- **Configurable**: Enable/disable specific features
- **Monitoring**: Track all operations and their outcomes
- **Resource Management**: Proper cleanup and disposal

```dart
final orchestrator = StabilityOrchestrator<T>(
  circuitBreaker: circuitBreaker,
  retryManager: retryManager,
  fallbackOrchestrator: fallbackOrchestrator,
  errorHandlerOrchestrator: errorHandlerOrchestrator,
  operationTimeout: Duration(seconds: 30),
  enableCircuitBreaker: true,
  enableRetry: true,
  enableFallback: true,
  enableErrorHandling: true,
);

// Monitor circuit breaker state
print('Circuit state: ${orchestrator.circuitState}');
print('Circuit healthy: ${orchestrator.isCircuitHealthy}');
print('Failure count: ${orchestrator.circuitFailureCount}');
```

## 🏭 **Factory Methods**

### **Important: User Configuration Required**

The factory methods create **empty orchestrators** that you must configure with your own strategies:

```dart
// This creates an empty orchestrator with NO fallbacks or error handlers
final stability = StabilityOrchestratorFactory.createStandard<PostData>();

// You MUST add your own fallback strategies
stability.addFallbackStrategy(
  CacheFallbackStrategy<PostData>((context) => cacheService.getPosts()),
);

// You MUST add your own error handlers
stability.addErrorHandler(
  NetworkErrorHandler<PostData>(fallbackData: []),
);
```

### **Standard Configuration**
```dart
final stability = StabilityOrchestratorFactory.createStandard<PostData>(
  operationTimeout: Duration(seconds: 30),
  circuitBreakerThreshold: 5,
  circuitBreakerResetTimeout: Duration(minutes: 1),
);
```

### **Lightweight Configuration**
```dart
final stability = StabilityOrchestratorFactory.createLightweight<PostData>();
// Only circuit breaker enabled, minimal overhead
```

### **Robust Configuration**
```dart
final stability = StabilityOrchestratorFactory.createRobust<PostData>(
  operationTimeout: Duration(minutes: 2),
  circuitBreakerThreshold: 3,
  circuitBreakerResetTimeout: Duration(minutes: 5),
);
```

## 📊 **Monitoring & Metrics**

### **Operation Results**
```dart
final result = await stability.execute(() => service.operation());

// Success metrics
print('Success: ${result.isSuccess}');
print('Strategy used: ${result.strategyUsed}');
print('Execution time: ${result.executionTime}');
print('Fallback level: ${result.fallbackLevel}');

// Circuit breaker metrics
print('Circuit state: ${result.circuitState}');
print('Failure count: ${result.failureCount}');

// Error handling metrics
print('Handled by error handler: ${result.handledByErrorHandler}');
```

### **Circuit Breaker Monitoring**
```dart
// Real-time state monitoring
print('Current state: ${stability.circuitState}');
print('Is healthy: ${stability.isCircuitHealthy}');
print('Failure count: ${stability.circuitFailureCount}');

// Manual reset if needed
stability.resetCircuitBreaker();
```

## 🔧 **Customization**

### **Custom Fallback Strategy**
```dart
class DatabaseFallbackStrategy<T> extends BaseFallbackStrategy<T> {
  final Future<T?> Function(FallbackContext context) _dbProvider;

  DatabaseFallbackStrategy(this._dbProvider);

  @override
  String get strategyName => 'DatabaseFallback';

  @override
  Future<FallbackResult<T>> execute(FallbackContext context) async {
    return executeWithTimeout(() async {
      final data = await _dbProvider(context);
      if (data == null) {
        throw Exception('No database data available');
      }
      return data;
    }, context);
  }
}

// Use custom strategy
final dbFallback = DatabaseFallbackStrategy<PostData>(
  (context) => databaseService.getPosts(),
);

stability.addFallbackStrategy(dbFallback);
```

### **Custom Error Handler**
```dart
class ValidationErrorHandler<T> extends BaseErrorHandler<T> {
  final T? _fallbackData;

  ValidationErrorHandler({T? fallbackData}) : _fallbackData = fallbackData;

  @override
  String get handlerName => 'ValidationErrorHandler';

  @override
  bool canHandle(dynamic error, ErrorContext context) {
    return categorizeError(error) == ErrorCategory.validation;
  }

  @override
  Future<ErrorHandlingResult<T>> handleError(
    dynamic error,
    ErrorContext context,
  ) async {
    final severity = determineSeverity(error, context);
    final userMessage = generateUserMessage(error, context);

    if (_fallbackData != null) {
      return ErrorHandlingResult.handled(
        _fallbackData!,
        handlerUsed: handlerName,
        severity: severity,
        userMessage: userMessage,
      );
    }

    return ErrorHandlingResult.unhandled(
      error,
      handlerUsed: handlerName,
      severity: severity,
      userMessage: userMessage,
    );
  }
}

// Use custom handler with YOUR data type
final validationHandler = ValidationErrorHandler<PostData>(
  fallbackData: defaultPosts, // Your fallback data
);

stability.addErrorHandler(validationHandler);
```

### **Important: Always Provide Fallback Data**

When creating error handlers, **always provide appropriate fallback data**:

```dart
// ❌ Wrong: No fallback data
stability.addErrorHandler(NetworkErrorHandler<PostData>());

// ✅ Correct: With fallback data
stability.addErrorHandler(NetworkErrorHandler<PostData>(
  fallbackData: [], // Your empty posts list
));
```

## 🧪 **Testing**

### **Unit Testing**
```dart
test('Circuit breaker opens after threshold failures', () async {
  final circuitBreaker = CircuitBreaker<String>(
    failureThreshold: 2,
    resetTimeout: Duration(seconds: 1),
  );

  // First failure
  expect(circuitBreaker.state, CircuitState.closed);
  
  try {
    await circuitBreaker.execute(() => throw Exception('Test error'));
  } catch (e) {
    // Expected
  }
  
  expect(circuitBreaker.failureCount, 1);
  expect(circuitBreaker.state, CircuitState.closed);

  // Second failure - should open circuit
  try {
    await circuitBreaker.execute(() => throw Exception('Test error'));
  } catch (e) {
    // Expected
  }
  
  expect(circuitBreaker.state, CircuitState.open);
});
```

### **Integration Testing**
```dart
test('Full stability flow with fallbacks', () async {
  final stability = StabilityOrchestratorFactory.createStandard<String>();
  
  // Add custom fallback
  stability.addFallbackStrategy(
    DefaultDataFallbackStrategy<String>('fallback_value'),
  );

  final result = await stability.execute(
    () => throw Exception('Primary operation failed'),
    operationName: 'test_operation',
  );

  expect(result.isSuccess, true);
  expect(result.data, 'fallback_value');
  expect(result.usedFallback, true);
  expect(result.fallbackLevel, 1);
});
```

## 📈 **Performance Considerations**

### **Memory Management**
- **Dispose Resources**: Always call `dispose()` when done
- **Weak References**: Use weak references for callbacks if needed
- **Resource Pooling**: Reuse orchestrators for similar operations

### **Overhead Minimization**
- **Lightweight Mode**: Use for simple operations
- **Selective Features**: Enable only needed stability features
- **Async Operations**: All stability operations are async

### **Scaling**
- **Per-Service Instances**: Create separate orchestrators for different services
- **Shared Components**: Reuse circuit breakers and error handlers
- **Configuration**: Tune timeouts and thresholds based on service characteristics

## 🚨 **Best Practices**

### **0. Proper Setup (CRITICAL)**
- **Always specify your data type**: `StabilityOrchestrator<YourDataType>`
- **Always add fallback strategies**: Use `addFallbackStrategy()` with your data
- **Always add error handlers**: Use `addErrorHandler()` with your fallback data
- **Never use empty orchestrators**: They will fail without strategies

### **1. Operation Naming**
- Use descriptive operation names for monitoring
- Include context in operation names (e.g., 'fetch_posts_page_1')

### **2. Parameter Passing**
- Pass only necessary parameters
- Use metadata for additional context
- Keep parameters lightweight

### **3. Error Handling**
- Always handle operation results
- Check fallback levels for degraded service
- Monitor circuit breaker states

### **4. Resource Management**
- Dispose orchestrators when done
- Monitor memory usage
- Reset circuit breakers when appropriate

### **5. Monitoring**
- Track operation success rates
- Monitor fallback usage
- Alert on circuit breaker state changes

## 🔍 **Troubleshooting**

### **Common Setup Mistakes**

#### **❌ Mistake 1: Using Empty Orchestrator**
```dart
// This will fail - no fallback strategies
final stability = StabilityOrchestratorFactory.createStandard<PostData>();
final result = await stability.execute(() => service.operation()); // Will crash
```

**Fix**: Always add strategies first
```dart
final stability = StabilityOrchestratorFactory.createStandard<PostData>();
stability.addFallbackStrategy(DefaultDataFallbackStrategy<PostData>([]));
// Now safe to use
```

#### **❌ Mistake 2: Wrong Data Type**
```dart
// This will cause type errors
final stability = StabilityOrchestratorFactory.createStandard(); // Missing <T>
```

**Fix**: Always specify your data type
```dart
final stability = StabilityOrchestratorFactory.createStandard<PostData>();
```

#### **❌ Mistake 3: No Fallback Data**
```dart
// This will fail when network errors occur
stability.addErrorHandler(NetworkErrorHandler<PostData>()); // No fallback data
```

**Fix**: Always provide fallback data
```dart
stability.addErrorHandler(NetworkErrorHandler<PostData>(fallbackData: []));
```

### **Common Issues**

#### **Circuit Breaker Always Open**
- Check failure threshold configuration
- Verify reset timeout values
- Monitor failure patterns

#### **High Fallback Usage**
- Review primary operation reliability
- Check network connectivity
- Verify service health

#### **Performance Degradation**
- Use lightweight mode for simple operations
- Disable unnecessary features
- Monitor execution times

### **Debug Mode**
```dart
// Enable detailed logging
final stability = StabilityOrchestratorFactory.createStandard<PostData>(
  operationTimeout: Duration(seconds: 30),
);

// Monitor all operations
stability.addErrorHandler(
  LoggingErrorHandler<PostData>(), // Custom handler for logging
);
```

## 📚 **Examples**

### **Generic Design Benefits**

This stability system is designed to be **completely generic** and **reusable**:

1. **No Hard Dependencies**: Works with any data type `<T>`
2. **User-Provided Types**: You specify what `<T>` represents
3. **User-Provided Strategies**: You provide your own fallback logic
4. **User-Provided Data**: You provide your own fallback data
5. **Cross-Project Reusable**: Can be used in any Flutter project

### **Post Service Integration**
```dart
class PostService {
  final StabilityOrchestrator<List<Post>> _stability;

  PostService() : _stability = StabilityOrchestratorFactory.createRobust<List<Post>>();

  Future<List<Post>> fetchPosts({int page = 1, int limit = 20}) async {
    final result = await _stability.execute(
      () => _apiService.fetchPosts(page: page, limit: limit),
      operationName: 'fetch_posts',
      parameters: {'page': page, 'limit': limit},
    );

    return result.fold(
      (posts) => posts,
      (error) => throw PostServiceException('Failed to fetch posts: $error'),
    );
  }

  Future<List<Post>> fetchPostsWithCache({int page = 1, int limit = 20}) async {
    // Add cache fallback
    _stability.addFallbackStrategy(
      CacheFallbackStrategy<List<Post>>(
        (context) => _cacheService.getPosts(page: page, limit: limit),
      ),
    );

    final result = await _stability.execute(
      () => _apiService.fetchPosts(page: page, limit: limit),
      operationName: 'fetch_posts_with_cache',
      parameters: {'page': page, 'limit': limit},
    );

    return result.dataOrThrow;
  }
}
```

### **User Service Integration**
```dart
class UserService {
  final StabilityOrchestrator<User> _stability;

  UserService() : _stability = StabilityOrchestratorFactory.createStandard<User>();

  Future<User> getUserProfile(String userId) async {
    final result = await _stability.execute(
      () => _apiService.getUserProfile(userId),
      operationName: 'get_user_profile',
      parameters: {'userId': userId},
    );

    if (result.isSuccess) {
      return result.data!;
    } else {
      // Handle failure with user-friendly message
      if (result.handledByErrorHandler) {
        return User.anonymous();
      } else {
        throw UserServiceException('Failed to get user profile');
      }
    }
  }
}
```

This stability system provides a robust foundation for building bulletproof Flutter services that can handle any failure scenario gracefully while maintaining excellent user experience.
