import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Retry configuration for failed image loads
class RetryConfig {
  final int maxAttempts;
  final Duration initialDelay;
  final double multiplier;
  final Duration maxDelay;

  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.multiplier = 2.0,
    this.maxDelay = const Duration(seconds: 8),
  });

  Duration getDelay(int attempt) {
    final delayMs = initialDelay.inMilliseconds * (multiplier * attempt);
    final cappedDelay =
        Duration(milliseconds: delayMs.toInt()).compareTo(maxDelay) > 0
            ? maxDelay
            : Duration(milliseconds: delayMs.toInt());
    return cappedDelay;
  }
}

/// Error classification for better handling
enum ImageErrorType {
  network, // Network connectivity issues
  notFound, // 404, image doesn't exist
  timeout, // Request timeout
  serverError, // 5xx errors
  invalidUrl, // Malformed URL
  unknown, // Other errors
}

/// Service to handle image loading with retry logic
class ImageRetryService {
  static final ImageRetryService _instance = ImageRetryService._internal();
  factory ImageRetryService() => _instance;
  ImageRetryService._internal();

  final RetryConfig defaultConfig = const RetryConfig();

  /// Classify error type for better handling
  ImageErrorType classifyError(dynamic error) {
    if (error is SocketException) {
      return ImageErrorType.network;
    } else if (error is TimeoutException) {
      return ImageErrorType.timeout;
    } else if (error is HttpException) {
      if (error.message.contains('404')) {
        return ImageErrorType.notFound;
      } else if (error.message.contains('5')) {
        return ImageErrorType.serverError;
      }
    } else if (error.toString().contains('Invalid URL')) {
      return ImageErrorType.invalidUrl;
    }
    return ImageErrorType.unknown;
  }

  /// Get user-friendly error message
  String getErrorMessage(ImageErrorType errorType) {
    switch (errorType) {
      case ImageErrorType.network:
        return 'Check your internet connection';
      case ImageErrorType.notFound:
        return 'Image not found';
      case ImageErrorType.timeout:
        return 'Loading timed out';
      case ImageErrorType.serverError:
        return 'Server error, try again later';
      case ImageErrorType.invalidUrl:
        return 'Invalid image URL';
      case ImageErrorType.unknown:
        return 'Failed to load image';
    }
  }

  /// Check if error is retryable
  bool isRetryable(ImageErrorType errorType) {
    switch (errorType) {
      case ImageErrorType.network:
      case ImageErrorType.timeout:
      case ImageErrorType.serverError:
        return true;
      case ImageErrorType.notFound:
      case ImageErrorType.invalidUrl:
      case ImageErrorType.unknown:
        return false;
    }
  }

  /// Execute function with retry logic
  Future<T> executeWithRetry<T>({
    required Future<T> Function() action,
    RetryConfig? config,
    void Function(int attempt, Duration delay)? onRetry,
  }) async {
    final retryConfig = config ?? defaultConfig;
    int attempt = 0;
    dynamic lastError;

    while (attempt < retryConfig.maxAttempts) {
      try {
        return await action();
      } catch (error) {
        lastError = error;
        attempt++;

        final errorType = classifyError(error);

        if (!isRetryable(errorType) || attempt >= retryConfig.maxAttempts) {
          debugPrint('❌ Image load failed (${errorType.name}): $error');
          rethrow;
        }

        final delay = retryConfig.getDelay(attempt);
        debugPrint(
            '🔄 Retry attempt $attempt after ${delay.inSeconds}s (${errorType.name})');

        onRetry?.call(attempt, delay);
        await Future.delayed(delay);
      }
    }

    throw lastError ?? Exception('Max retry attempts reached');
  }
}
