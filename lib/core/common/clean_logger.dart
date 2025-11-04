import 'package:flutter/foundation.dart';

/// Centralized logging utility with controllable debug printing
/// Only prints exceptions and errors by default
class CleanLogger {
  // Debug mode flags
  static bool _enableDebugLogs = false;
  static bool _enableInfoLogs = false;
  static bool _enableWarningLogs = true;
  static bool _enableErrorLogs = true;
  static bool _enableExceptionLogs = true;

  /// Enable/disable different log levels
  static void configureLogging({
    bool enableDebug = false,
    bool enableInfo = false,
    bool enableWarning = true,
    bool enableError = true,
    bool enableException = true,
  }) {
    _enableDebugLogs = enableDebug;
    _enableInfoLogs = enableInfo;
    _enableWarningLogs = enableWarning;
    _enableErrorLogs = enableError;
    _enableExceptionLogs = enableException;
  }

  /// Debug logging (only in debug mode and when enabled)
  static void debug(String message) {
    if (kDebugMode && _enableDebugLogs) {
      print('🐛 DEBUG: $message');
    }
  }

  /// Info logging (only in debug mode and when enabled)
  static void info(String message) {
    if (kDebugMode && _enableInfoLogs) {
      print('ℹ️ INFO: $message');
    }
  }

  /// Warning logging (always enabled)
  static void warning(String message) {
    if (_enableWarningLogs) {
      print('⚠️ WARNING: $message');
    }
  }

  /// Error logging (always enabled)
  static void error(String message) {
    if (_enableErrorLogs) {
      print('❌ ERROR: $message');
    }
  }

  /// Exception logging (always enabled)
  static void exception(String message,
      [dynamic error, StackTrace? stackTrace]) {
    if (_enableExceptionLogs) {
      print('💥 EXCEPTION: $message');
      if (error != null) {
        print('💥 Error details: $error');
      }
      if (stackTrace != null) {
        print('💥 Stack trace: $stackTrace');
      }
    }
  }

  /// JSON logging for large responses (only in debug mode and when enabled)
  static void logJson(String label, dynamic jsonData) {
    if (kDebugMode && _enableDebugLogs) {
      print('📄 $label: ${jsonData.toString()}');
    }
  }

  /// Object logging for debugging (only in debug mode and when enabled)
  static void logObject(String label, dynamic object) {
    if (kDebugMode && _enableDebugLogs) {
      print('📦 $label: ${object.toString()}');
    }
  }

  /// Performance logging (only in debug mode and when enabled)
  static void performance(String operation, Duration duration) {
    if (kDebugMode && _enableDebugLogs) {
      print('⚡ PERFORMANCE: $operation took ${duration.inMilliseconds}ms');
    }
  }

  /// API logging (only in debug mode and when enabled)
  static void api(String endpoint, String method, int statusCode) {
    if (kDebugMode && _enableDebugLogs) {
      print('🌐 API: $method $endpoint -> $statusCode');
    }
  }

  /// Success logging (only in debug mode and when enabled)
  static void success(String message) {
    if (kDebugMode && _enableDebugLogs) {
      print('✅ SUCCESS: $message');
    }
  }
}
