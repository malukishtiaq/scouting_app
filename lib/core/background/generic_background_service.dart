import 'dart:async';
import 'dart:isolate';
import 'package:injectable/injectable.dart';
import 'generic_api_task.dart';
import '../common/local_storage.dart';

/// Generic background service that can handle any API call
/// This service is designed to be pluggable and reusable for any feature
@singleton
class GenericBackgroundService {
  // Keep track of running isolates
  final Map<String, Isolate> _runningIsolates = {};
  final Map<String, ReceivePort> _receivePorts = {};

  /// Execute any API call in background using generic configuration
  /// This is the main method that makes this service pluggable
  Future<Map<String, dynamic>> executeApiCall({
    required GenericApiConfig config,
    String? accessToken,
    Duration? timeout,
  }) async {
    final token = accessToken ?? LocalStorage.authToken ?? '';

    if (token.isEmpty) {
      return {
        'success': false,
        'error': 'Access token not available',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }

    // Create a completer to wait for isolate result
    final completer = Completer<Map<String, dynamic>>();

    // Start background isolate task and wait for result
    await _startIsolateWithResult(
      config.taskName,
      GenericApiTask(
        config: config,
        accessToken: token,
      ),
      completer,
      timeout: timeout ?? config.timeout,
    );

    // Wait for isolate to complete with timeout
    final result = await completer.future.timeout(
      timeout ?? config.timeout,
      onTimeout: () => {
        'success': false,
        'error': 'Background API call timeout',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );

    return result;
  }

  /// Execute newsfeed API call (backward compatibility)
  Future<Map<String, dynamic>> executeNewsfeedCall({
    String? afterPostId,
    String? limit,
    String? postType,
    String? accessToken,
    Duration? timeout,
  }) async {
    final config = ApiConfigs.newsfeed(
      afterPostId: afterPostId,
      limit: limit,
      postType: postType,
    );

    return await executeApiCall(
      config: config,
      accessToken: accessToken,
      timeout: timeout,
    );
  }

  /// Execute stories API call
  Future<Map<String, dynamic>> executeStoriesCall({
    String? afterStoryId,
    String? limit,
    String? userId,
    String? accessToken,
    Duration? timeout,
  }) async {
    final config = ApiConfigs.stories(
      afterStoryId: afterStoryId,
      limit: limit,
      userId: userId,
    );

    return await executeApiCall(
      config: config,
      accessToken: accessToken,
      timeout: timeout,
    );
  }

  /// Execute custom API call with full configuration
  Future<Map<String, dynamic>> executeCustomApiCall({
    required String apiUrl,
    required String taskName,
    String method = 'POST',
    Map<String, String> headers = const {},
    Map<String, dynamic> bodyFields = const {},
    Map<String, String> queryParams = const {},
    Duration timeout = const Duration(minutes: 5), // Extended default timeout
    String? accessToken,
  }) async {
    final config = GenericApiConfig(
      apiUrl: apiUrl,
      method: method,
      headers: headers,
      bodyFields: bodyFields,
      queryParams: queryParams,
      taskName: taskName,
      timeout: timeout,
    );

    return await executeApiCall(
      config: config,
      accessToken: accessToken,
      timeout: timeout,
    );
  }

  /// Generic method to start any isolate task with result callback
  Future<void> _startIsolateWithResult(
    String taskName,
    GenericApiTask task,
    Completer<Map<String, dynamic>> completer, {
    Duration? timeout,
  }) async {
    // Kill existing isolate if running
    if (_runningIsolates.containsKey(taskName)) {
      _runningIsolates[taskName]?.kill();
      _runningIsolates.remove(taskName);
      _receivePorts[taskName]?.close();
      _receivePorts.remove(taskName);
    }

    // Create new isolate
    final receivePort = ReceivePort();
    _receivePorts[taskName] = receivePort;

    try {
      final isolate = await Isolate.spawn(
        _isolateEntryPoint,
        _IsolateMessage(
          task: task,
          taskName: taskName,
          sendPort: receivePort.sendPort,
        ),
      );

      _runningIsolates[taskName] = isolate;

      // Listen for results and complete the completer
      receivePort.listen((message) {
        if (message is _IsolateResult) {
          // Complete the completer with the result data
          if (message.data is Map<String, dynamic>) {
            completer.complete(message.data as Map<String, dynamic>);
          } else {
            completer.complete({
              'success': false,
              'error': 'Invalid result format from isolate',
              'timestamp': DateTime.now().millisecondsSinceEpoch,
            });
          }

          // Clean up
          _runningIsolates.remove(taskName);
          _receivePorts.remove(taskName);
          receivePort.close();
        } else if (message is _IsolateError) {
          // Complete the completer with error
          completer.complete({
            'success': false,
            'error': message.error,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          });

          // Clean up
          _runningIsolates.remove(taskName);
          _receivePorts.remove(taskName);
          receivePort.close();
        }
      });
    } catch (e) {
      // Complete the completer with error
      completer.complete({
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      _receivePorts.remove(taskName);
      receivePort.close();
      rethrow;
    }
  }

  /// Stop a specific isolate
  void stopIsolate(String taskName) {
    if (_runningIsolates.containsKey(taskName)) {
      _runningIsolates[taskName]?.kill();
      _runningIsolates.remove(taskName);

      if (_receivePorts.containsKey(taskName)) {
        _receivePorts[taskName]?.close();
        _receivePorts.remove(taskName);
      }
    }
  }

  /// Stop all running isolates
  void stopAllIsolates() {
    for (final entry in _runningIsolates.entries) {
      try {
        entry.value.kill();
      } catch (e) {
        // Silently handle errors
      }
    }

    _runningIsolates.clear();

    for (final receivePort in _receivePorts.values) {
      try {
        receivePort.close();
      } catch (e) {
        // Silently handle errors
      }
    }

    _receivePorts.clear();
  }

  /// Check if isolate is running
  bool isIsolateRunning(String taskName) {
    return _runningIsolates.containsKey(taskName);
  }

  /// Get all running isolate names
  List<String> get runningIsolates => _runningIsolates.keys.toList();
}

/// Entry point for generic isolates
void _isolateEntryPoint(_IsolateMessage message) {
  // Note: We can't use logger extension in isolate as it requires service locator
  // The main thread will handle logging when it receives the result

  try {
    // Execute the task in complete isolation
    message.task.execute().then((result) {
      message.sendPort.send(_IsolateResult(
        taskName: message.taskName,
        message: 'Task completed successfully',
        data: result,
      ));
    }).catchError((error) {
      message.sendPort.send(_IsolateError(
        taskName: message.taskName,
        error: error.toString(),
      ));
    });
  } catch (e) {
    message.sendPort.send(_IsolateError(
      taskName: message.taskName,
      error: e.toString(),
    ));
  }
}

/// Message sent to generic isolate
class _IsolateMessage {
  final GenericApiTask task;
  final String taskName;
  final SendPort sendPort;

  _IsolateMessage({
    required this.task,
    required this.taskName,
    required this.sendPort,
  });
}

/// Result from generic isolate
class _IsolateResult {
  final String taskName;
  final String message;
  final dynamic data;

  _IsolateResult({
    required this.taskName,
    required this.message,
    this.data,
  });
}

/// Error from generic isolate
class _IsolateError {
  final String taskName;
  final String error;

  _IsolateError({
    required this.taskName,
    required this.error,
  });
}
