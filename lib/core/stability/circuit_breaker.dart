import 'dart:async';

/// Generic Circuit Breaker Pattern for any service
/// Prevents cascade failures by temporarily blocking operations when they fail repeatedly
class CircuitBreaker<T> {
  CircuitState _state = CircuitState.closed;
  int _failureCount = 0;
  DateTime? _lastFailureTime;
  Timer? _resetTimer;
  
  // Configuration
  final int _failureThreshold;
  final Duration _resetTimeout;
  final Duration _halfOpenTimeout;
  
  // Callbacks for monitoring
  final void Function(CircuitState)? onStateChanged;
  final void Function(dynamic error)? onFailure;
  
  CircuitBreaker({
    int failureThreshold = 5,
    Duration resetTimeout = const Duration(minutes: 1),
    Duration halfOpenTimeout = const Duration(seconds: 30),
    this.onStateChanged,
    this.onFailure,
  }) : _failureThreshold = failureThreshold,
       _resetTimeout = resetTimeout,
       _halfOpenTimeout = halfOpenTimeout;

  /// Execute an operation with circuit breaker protection
  Future<T> execute(Future<T> Function() operation) async {
    if (_state == CircuitState.open) {
      if (_shouldAttemptReset()) {
        _transitionToHalfOpen();
      } else {
        throw CircuitBreakerException(
          'Circuit is open. Last failure: ${_lastFailureTime?.toIso8601String()}',
          _lastFailureTime,
        );
      }
    }
    
    try {
      final result = await operation();
      _onSuccess();
      return result;
    } catch (e) {
      _onFailure(e);
      rethrow;
    }
  }

  /// Execute with custom error handling
  Future<CircuitBreakerResult<T>> executeSafe(Future<T> Function() operation) async {
    try {
      final result = await execute(operation);
      return CircuitBreakerResult.success(result);
    } catch (e) {
      return CircuitBreakerResult.failure(e);
    }
  }

  /// Manually reset the circuit breaker
  void reset() {
    _failureCount = 0;
    _lastFailureTime = null;
    _resetTimer?.cancel();
    _transitionToClosed();
  }

  /// Get current circuit state
  CircuitState get state => _state;

  /// Get failure count
  int get failureCount => _failureCount;

  /// Get last failure time
  DateTime? get lastFailureTime => _lastFailureTime;

  /// Check if circuit is healthy
  bool get isHealthy => _state == CircuitState.closed;

  /// Check if circuit is open
  bool get isOpen => _state == CircuitState.open;

  /// Check if circuit is half-open
  bool get isHalfOpen => _state == CircuitState.halfOpen;

  void _onSuccess() {
    _failureCount = 0;
    _lastFailureTime = null;
    _resetTimer?.cancel();
    _transitionToClosed();
  }

  void _onFailure(dynamic error) {
    _failureCount++;
    _lastFailureTime = DateTime.now();
    
    onFailure?.call(error);
    
    if (_failureCount >= _failureThreshold) {
      _transitionToOpen();
    }
  }

  bool _shouldAttemptReset() {
    if (_lastFailureTime == null) return false;
    return DateTime.now().difference(_lastFailureTime!) >= _resetTimeout;
  }

  void _transitionToOpen() {
    if (_state != CircuitState.open) {
      _state = CircuitState.open;
      onStateChanged?.call(_state);
      
      // Schedule reset attempt
      _resetTimer = Timer(_resetTimeout, () {
        _transitionToHalfOpen();
      });
    }
  }

  void _transitionToHalfOpen() {
    if (_state != CircuitState.halfOpen) {
      _state = CircuitState.halfOpen;
      onStateChanged?.call(_state);
      
      // Auto-close after half-open timeout
      _resetTimer = Timer(_halfOpenTimeout, () {
        if (_state == CircuitState.halfOpen) {
          _transitionToClosed();
        }
      });
    }
  }

  void _transitionToClosed() {
    if (_state != CircuitState.closed) {
      _state = CircuitState.closed;
      onStateChanged?.call(_state);
    }
  }

  void dispose() {
    _resetTimer?.cancel();
  }
}

/// Circuit breaker states
enum CircuitState {
  closed,    // Normal operation
  open,      // Blocking operations
  halfOpen,  // Testing if service recovered
}

/// Result wrapper for safe execution
class CircuitBreakerResult<T> {
  final bool isSuccess;
  final T? data;
  final dynamic error;

  const CircuitBreakerResult._({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory CircuitBreakerResult.success(T data) => CircuitBreakerResult._(
    isSuccess: true,
    data: data,
  );

  factory CircuitBreakerResult.failure(dynamic error) => CircuitBreakerResult._(
    isSuccess: false,
    error: error,
  );

  /// Get data if successful, throw if failed
  T get dataOrThrow {
    if (isSuccess) return data!;
    throw error ?? Exception('Operation failed');
  }

  /// Execute different functions based on success/failure
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(dynamic error) onFailure,
  ) {
    if (isSuccess) {
      return onSuccess(data!);
    } else {
      return onFailure(error);
    }
  }
}

/// Exception thrown when circuit breaker is open
class CircuitBreakerException implements Exception {
  final String message;
  final DateTime? lastFailureTime;

  const CircuitBreakerException(this.message, this.lastFailureTime);

  @override
  String toString() => 'CircuitBreakerException: $message';
}
