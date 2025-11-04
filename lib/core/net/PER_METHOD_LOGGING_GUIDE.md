# Per-Method Logging Control Guide

## Overview
This implementation allows you to control Dio logging on a per-API method basis instead of globally. This helps you debug specific APIs without cluttering the console with logs from all 100+ APIs.

## How It Works

### 1. Global Logging Control
- The global `AppConfig().appOptions.enableDioPrinting` setting still controls whether logging is available at all
- When `enableDioPrinting` is `false`, no logging will occur regardless of per-method settings

### 2. Per-Method Logging Control
- Each API method can now specify `enableLogging: true/false`
- Default value is `false` (no logging)
- Only methods that explicitly set `enableLogging: true` will have logging enabled

## Usage Examples

### Example 1: Login Method with Logging Enabled
```dart
@override
Future<Either<AppErrors, AuthResponseModel>> login(LoginParam param) async {
  return await request(
    converter: (json) => AuthResponseModel.fromJson(json),
    method: HttpMethod.POST,
    url: MainAPIS.apiAuth,
    body: param.toMap(),
    createModelInterceptor: const PrimativeCreateModelInterceptor(),
    withAuthentication: false,
    responseValidator: AuthResponseValidator(),
    enableLogging: true, // Enable logging for login debugging
  );
}
```

### Example 2: Register Method with Logging Disabled (Default)
```dart
@override
Future<Either<AppErrors, AuthResponseModel>> register(RegisterParam param) async {
  return await request(
    converter: (json) => AuthResponseModel.fromJson(json),
    method: HttpMethod.POST,
    url: MainAPIS.apiCreateAccount,
    body: param.toMap(),
    createModelInterceptor: const PrimativeCreateModelInterceptor(),
    withAuthentication: false,
    responseValidator: AuthResponseValidator(),
    enableLogging: false, // Explicitly disable logging (default behavior)
  );
}
```

### Example 3: Notification Methods with Selective Logging
```dart
// Send notification - enable logging for debugging
@override
Future<Either<AppErrors, NotificationModel>> sendNotification(
    SendNotificationParam param) async {
  return await request(
    converter: (json) => NotificationModel.fromJson(json),
    method: HttpMethod.POST,
    url: MainAPIS.apiSendNotification,
    body: param.toMap(),
    createModelInterceptor: const PrimativeCreateModelInterceptor(),
    withAuthentication: true,
    responseValidator: DefaultResponseValidator(),
    enableLogging: true, // Enable logging for notification debugging
  );
}

// Get notifications - disable logging (default)
@override
Future<Either<AppErrors, List<NotificationModel>>> getNotifications(
    GetNotificationsParam param) async {
  return await request(
    converter: (json) => NotificationModel.fromJson(json),
    method: HttpMethod.GET,
    url: MainAPIS.apiGetNotifications,
    queryParameters: param.toMap(),
    createModelInterceptor: const PrimativeCreateModelInterceptor(),
    withAuthentication: true,
    responseValidator: DefaultResponseValidator(),
    enableLogging: false, // Disable logging for get notifications
  );
}
```

## Benefits

1. **Targeted Debugging**: Enable logging only for problematic APIs
2. **Clean Console**: Avoid cluttering console with logs from all APIs
3. **Performance**: Reduce logging overhead for production APIs
4. **Flexibility**: Easy to enable/disable logging per method as needed

## Implementation Details

### HttpClient Changes
- Added `enableLogging` parameter to all HTTP methods (`sendRequest`, `sendListRequest`, `upload`)
- Created `_createClientForRequest()` method that creates a new Dio instance with optional logging
- Each request now uses its own Dio client instance

### RemoteDataSource Changes
- Added `enableLogging` parameter to the `request()` method
- Passes the logging control to HttpClient

### Usage in Data Sources
- Each API method can now specify `enableLogging: true/false`
- Default is `false` (no logging)
- Only methods that need debugging should set `enableLogging: true`

## Best Practices

1. **Use Sparingly**: Only enable logging for APIs you're actively debugging
2. **Disable After Debugging**: Remember to set `enableLogging: false` after debugging is complete
3. **Document Usage**: Add comments explaining why logging is enabled for specific methods
4. **Global Control**: Keep `AppConfig().appOptions.enableDioPrinting` as the master switch

## Migration Guide

To migrate existing code:

1. **No Changes Required**: Existing code will work without changes (default is `enableLogging: false`)
2. **Add Logging Where Needed**: Add `enableLogging: true` to methods you want to debug
3. **Remove Global Logging**: Consider removing the global logging interceptor from HttpClient constructor

## Example Migration

### Before (Global Logging)
```dart
// All APIs would log if global setting was enabled
@override
Future<Either<AppErrors, AuthResponseModel>> login(LoginParam param) async {
  return await request(
    converter: (json) => AuthResponseModel.fromJson(json),
    method: HttpMethod.POST,
    url: MainAPIS.apiAuth,
    body: param.toMap(),
    // ... other parameters
  );
}
```

### After (Per-Method Logging)
```dart
// Only this specific method will log when debugging
@override
Future<Either<AppErrors, AuthResponseModel>> login(LoginParam param) async {
  return await request(
    converter: (json) => AuthResponseModel.fromJson(json),
    method: HttpMethod.POST,
    url: MainAPIS.apiAuth,
    body: param.toMap(),
    // ... other parameters
    enableLogging: true, // Enable logging only for this method
  );
}
```

This approach gives you fine-grained control over which APIs log their requests and responses, making debugging much more manageable in large applications.
