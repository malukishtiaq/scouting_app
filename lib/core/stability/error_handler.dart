import 'dart:async';

/// Generic Error Handler for any service
/// Categorizes errors and provides appropriate fallback strategies
abstract class ErrorHandler<T> {
  /// Handle an error and return a fallback result
  Future<ErrorHandlingResult<T>> handleError(
    dynamic error,
    ErrorContext context,
  );
  
  /// Get the handler name for logging/monitoring
  String get handlerName;
  
  /// Check if this handler can handle the given error
  bool canHandle(dynamic error, ErrorContext context);
}

/// Error handling result
class ErrorHandlingResult<T> {
  final bool isHandled;
  final T? fallbackData;
  final dynamic error;
  final String handlerUsed;
  final ErrorSeverity severity;
  final String? userMessage;
  final Map<String, dynamic> metadata;

  const ErrorHandlingResult._({
    required this.isHandled,
    this.fallbackData,
    this.error,
    required this.handlerUsed,
    required this.severity,
    this.userMessage,
    this.metadata = const {},
  });

  factory ErrorHandlingResult.handled(
    T fallbackData, {
    required String handlerUsed,
    required ErrorSeverity severity,
    String? userMessage,
    Map<String, dynamic> metadata = const {},
  }) => ErrorHandlingResult._(
    isHandled: true,
    fallbackData: fallbackData,
    handlerUsed: handlerUsed,
    severity: severity,
    userMessage: userMessage,
    metadata: metadata,
  );

  factory ErrorHandlingResult.unhandled(
    dynamic error, {
    required String handlerUsed,
    required ErrorSeverity severity,
    String? userMessage,
    Map<String, dynamic> metadata = const {},
  }) => ErrorHandlingResult._(
    isHandled: false,
    error: error,
    handlerUsed: handlerUsed,
    severity: severity,
    userMessage: userMessage,
    metadata: metadata,
  );

  /// Get fallback data if handled, throw if unhandled
  T get dataOrThrow {
    if (isHandled) return fallbackData!;
    throw error ?? Exception('Error was not handled');
  }

  /// Execute different functions based on handled/unhandled
  R fold<R>(
    R Function(T data) onHandled,
    R Function(dynamic error) onUnhandled,
  ) {
    if (isHandled) {
      return onHandled(fallbackData!);
    } else {
      return onUnhandled(error);
    }
  }
}

/// Error context with operation details
class ErrorContext {
  final String operationName;
  final Map<String, dynamic> parameters;
  final int attemptCount;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;
  final StackTrace? stackTrace;

  const ErrorContext({
    required this.operationName,
    required this.parameters,
    this.attemptCount = 0,
    required this.timestamp,
    this.metadata = const {},
    this.stackTrace,
  });

  /// Create a new context for the next attempt
  ErrorContext nextAttempt() => ErrorContext(
    operationName: operationName,
    parameters: parameters,
    attemptCount: attemptCount + 1,
    timestamp: DateTime.now(),
    metadata: metadata,
    stackTrace: stackTrace,
  );

  /// Add metadata to the context
  ErrorContext withMetadata(String key, dynamic value) {
    final newMetadata = Map<String, dynamic>.from(metadata);
    newMetadata[key] = value;
    return ErrorContext(
      operationName: operationName,
      parameters: parameters,
      attemptCount: attemptCount,
      timestamp: timestamp,
      metadata: newMetadata,
      stackTrace: stackTrace,
    );
  }
}

/// Error severity levels
enum ErrorSeverity {
  low,      // Minor issues, can continue
  medium,   // Moderate issues, may affect functionality
  high,     // Serious issues, significant impact
  critical, // Critical issues, service may be unusable
}

/// Error categories for different types of failures
enum ErrorCategory {
  network,      // Network connectivity issues
  timeout,      // Operation timeouts
  authentication, // Auth/authorization failures
  validation,   // Data validation errors
  server,       // Server-side errors
  client,       // Client-side errors
  unknown,      // Unknown error types
}

/// Base error handler with common functionality
abstract class BaseErrorHandler<T> implements ErrorHandler<T> {
  @override
  String get handlerName => runtimeType.toString();

  @override
  bool canHandle(dynamic error, ErrorContext context) => true;

  /// Categorize an error
  ErrorCategory categorizeError(dynamic error) {
    if (error is TimeoutException) return ErrorCategory.timeout;
    if (error.toString().toLowerCase().contains('network')) return ErrorCategory.network;
    if (error.toString().toLowerCase().contains('auth')) return ErrorCategory.authentication;
    if (error.toString().toLowerCase().contains('validation')) return ErrorCategory.validation;
    if (error.toString().toLowerCase().contains('server')) return ErrorCategory.server;
    if (error.toString().toLowerCase().contains('client')) return ErrorCategory.client;
    return ErrorCategory.unknown;
  }

  /// Determine error severity
  ErrorSeverity determineSeverity(dynamic error, ErrorContext context) {
    final category = categorizeError(error);
    
    switch (category) {
      case ErrorCategory.network:
        return context.attemptCount > 3 ? ErrorSeverity.high : ErrorSeverity.medium;
      case ErrorCategory.timeout:
        return context.attemptCount > 2 ? ErrorSeverity.medium : ErrorSeverity.low;
      case ErrorCategory.authentication:
        return ErrorSeverity.critical;
      case ErrorCategory.validation:
        return ErrorSeverity.medium;
      case ErrorCategory.server:
        return ErrorSeverity.high;
      case ErrorCategory.client:
        return ErrorSeverity.medium;
      case ErrorCategory.unknown:
        return ErrorSeverity.high;
    }
  }

  /// Generate user-friendly error message
  String generateUserMessage(dynamic error, ErrorContext context) {
    final category = categorizeError(error);
    
    switch (category) {
      case ErrorCategory.network:
        return 'Connection issue. Please check your internet connection.';
      case ErrorCategory.timeout:
        return 'Operation is taking longer than expected. Please try again.';
      case ErrorCategory.authentication:
        return 'Authentication failed. Please log in again.';
      case ErrorCategory.validation:
        return 'Invalid data provided. Please check your input.';
      case ErrorCategory.server:
        return 'Server is experiencing issues. Please try again later.';
      case ErrorCategory.client:
        return 'Something went wrong. Please try again.';
      case ErrorCategory.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

/// Network error handler
class NetworkErrorHandler<T> extends BaseErrorHandler<T> {
  final T? _fallbackData;
  final Duration _retryDelay;

  NetworkErrorHandler({
    T? fallbackData,
    Duration retryDelay = const Duration(seconds: 5),
  }) : _fallbackData = fallbackData,
       _retryDelay = retryDelay;

  @override
  String get handlerName => 'NetworkErrorHandler';

  @override
  bool canHandle(dynamic error, ErrorContext context) {
    return categorizeError(error) == ErrorCategory.network;
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
        metadata: {
          'retryDelay': _retryDelay.inMilliseconds,
          'attemptCount': context.attemptCount,
        },
      );
    }

    return ErrorHandlingResult.unhandled(
      error,
      handlerUsed: handlerName,
      severity: severity,
      userMessage: userMessage,
      metadata: {
        'retryDelay': _retryDelay.inMilliseconds,
        'attemptCount': context.attemptCount,
      },
    );
  }
}

/// Timeout error handler
class TimeoutErrorHandler<T> extends BaseErrorHandler<T> {
  final T? _fallbackData;
  final Duration _extendedTimeout;

  TimeoutErrorHandler({
    T? fallbackData,
    Duration extendedTimeout = const Duration(seconds: 30),
  }) : _fallbackData = fallbackData,
       _extendedTimeout = extendedTimeout;

  @override
  String get handlerName => 'TimeoutErrorHandler';

  @override
  bool canHandle(dynamic error, ErrorContext context) {
    return categorizeError(error) == ErrorCategory.timeout;
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
        metadata: {
          'extendedTimeout': _extendedTimeout.inMilliseconds,
          'attemptCount': context.attemptCount,
        },
      );
    }

    return ErrorHandlingResult.unhandled(
      error,
      handlerUsed: handlerName,
      severity: severity,
      userMessage: userMessage,
      metadata: {
        'extendedTimeout': _extendedTimeout.inMilliseconds,
        'attemptCount': context.attemptCount,
      },
    );
  }
}

/// Authentication error handler
class AuthenticationErrorHandler<T> extends BaseErrorHandler<T> {
  final Future<void> Function()? _onAuthFailure;

  AuthenticationErrorHandler({Future<void> Function()? onAuthFailure})
      : _onAuthFailure = onAuthFailure;

  @override
  String get handlerName => 'AuthenticationErrorHandler';

  @override
  bool canHandle(dynamic error, ErrorContext context) {
    return categorizeError(error) == ErrorCategory.authentication;
  }

  @override
  Future<ErrorHandlingResult<T>> handleError(
    dynamic error,
    ErrorContext context,
  ) async {
    // Always handle auth errors by triggering auth failure callback
    if (_onAuthFailure != null) {
      try {
        await _onAuthFailure!();
      } catch (e) {
        // Ignore errors in auth failure callback
      }
    }

    return ErrorHandlingResult.unhandled(
      error,
      handlerUsed: handlerName,
      severity: ErrorSeverity.critical,
      userMessage: generateUserMessage(error, context),
      metadata: {
        'authFailureCallback': _onAuthFailure != null,
        'attemptCount': context.attemptCount,
      },
    );
  }
}

/// Error handler orchestrator
class ErrorHandlerOrchestrator<T> {
  final List<ErrorHandler<T>> handlers;
  final ErrorHandler<T>? defaultHandler;

  ErrorHandlerOrchestrator({
    required List<ErrorHandler<T>> handlers,
    this.defaultHandler,
  }) : handlers = handlers;

  /// Handle an error using available handlers
  Future<ErrorHandlingResult<T>> handleError(
    dynamic error,
    ErrorContext context,
  ) async {
    // Try to find a handler that can handle this error
    for (final handler in handlers) {
      if (handler.canHandle(error, context)) {
        try {
          final result = await handler.handleError(error, context);
          if (result.isHandled) {
            return result;
          }
        } catch (e) {
          // Handler failed, continue to next
          continue;
        }
      }
    }

    // Use default handler if available
    if (defaultHandler != null) {
      try {
        return await defaultHandler!.handleError(error, context);
      } catch (e) {
        // Default handler also failed
      }
    }

    // No handler could handle the error
    return ErrorHandlingResult.unhandled(
      error,
      handlerUsed: 'none',
      severity: ErrorSeverity.critical,
      userMessage: 'An unexpected error occurred',
      metadata: {
        'attemptCount': context.attemptCount,
        'availableHandlers': handlers.map((h) => h.handlerName).toList(),
      },
    );
  }

  /// Add a new error handler
  void addHandler(ErrorHandler<T> handler) {
    handlers.add(handler);
  }

  /// Remove an error handler
  void removeHandler(ErrorHandler<T> handler) {
    handlers.remove(handler);
  }

  /// Get all available handlers
  List<ErrorHandler<T>> get allHandlers => List.unmodifiable(handlers);
}
