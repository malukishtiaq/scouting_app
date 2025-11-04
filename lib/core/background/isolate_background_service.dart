import 'dart:isolate';
import 'dart:async';
import 'package:injectable/injectable.dart';
import 'isolate_tasks.dart';
import '../common/local_storage.dart';

/// Standalone isolate service that runs completely in background
/// No UI thread burden, triggers immediately after login
@singleton
class IsolateBackgroundService {
  // Keep track of running isolates
  final Map<String, Isolate> _runningIsolates = {};
  final Map<String, ReceivePort> _receivePorts = {};

  /// Start core services initialization immediately after login
  /// This runs in complete isolation - no UI thread burden
  Future<void> startCoreServicesInitialization() async {
    print('🚀 Starting core services initialization in isolate...');

    try {
      // Start the isolate immediately (non-blocking)
      _startIsolate(
        'coreServicesInit',
        CoreServicesInitializationTask(),
      );

      print('✅ Core services initialization isolate started');
    } catch (e) {
      print('❌ Failed to start core services isolate: $e');
    }
  }

  /// Start news feed services initialization
  Future<void> startNewsFeedServicesInitialization() async {
    print('🔄 Starting news feed services initialization in isolate...');

    try {
      // Get access token from main thread
      final accessToken = LocalStorage.authToken;
      // Start the isolate immediately (non-blocking)
      _startIsolate(
        'newsFeedServicesInit',
        NewsFeedServicesInitializationTask(accessToken: accessToken),
      );
      print('✅ News feed services initialization isolate started');
    } catch (e) {
      print('❌ Failed to start news feed services isolate: $e');
    }
  }

  /// Start news feed services initialization with result callback
  Future<void> startNewsFeedServicesInitializationWithResult({
    required Completer<Map<String, dynamic>> completer,
    required String accessToken,
    String? afterPostId,
    String? limit,
    String? postType,
  }) async {
    print('🔄 Starting news feed services initialization with result...');
    print('🔑 Isolate Service: Access token length: ${accessToken.length}');
    print('📄 Isolate Service: After post ID: $afterPostId');
    print('📄 Isolate Service: Limit: $limit');
    print('🎯 Isolate Service: Post Type: $postType');

    try {
      await _startIsolateWithResult(
        'newsFeedServicesInit',
        NewsFeedServicesInitializationTask(
          accessToken: accessToken,
          afterPostId: afterPostId,
          limit: limit,
          postType: postType,
        ),
        completer,
      );

      print('✅ News feed services initialization isolate started with result');
    } catch (e) {
      print('❌ Failed to start news feed services isolate: $e');
      completer.complete({
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  /// Start trending services initialization
  Future<void> startTrendingServicesInitialization() async {
    print('🔄 Starting trending services initialization in isolate...');

    try {
      // Start the isolate immediately (non-blocking)
      _startIsolate(
        'trendingServicesInit',
        TrendingServicesInitializationTask(),
      );
      print('✅ Trending services initialization isolate started');
    } catch (e) {
      print('❌ Failed to start trending services initialization isolate: $e');
    }
  }

  /// Generic method to start any isolate task
  Future<void> _startIsolate(String taskName, IsolateTask task) async {
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

      // Listen for results
      receivePort.listen((message) {
        print('📡 Isolate $taskName sent message: ${message.runtimeType}');

        if (message is _IsolateResult) {
          print('✅ Isolate $taskName completed: ${message.message}');

          // Clean up
          _runningIsolates.remove(taskName);
          _receivePorts.remove(taskName);
          receivePort.close();
        } else if (message is _IsolateError) {
          print('❌ Isolate $taskName failed: ${message.error}');

          // Clean up
          _runningIsolates.remove(taskName);
          _receivePorts.remove(taskName);
          receivePort.close();
        }
      });
    } catch (e) {
      print('❌ Failed to spawn isolate $taskName: $e');
      _receivePorts.remove(taskName);
      receivePort.close();
      rethrow;
    }
  }

  /// Generic method to start any isolate task with result callback
  Future<void> _startIsolateWithResult(
    String taskName,
    IsolateTask task,
    Completer<Map<String, dynamic>> completer,
  ) async {
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
          print('✅ Isolate $taskName completed: ${message.message}');

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
          print('❌ Isolate $taskName failed: ${message.error}');

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
      print('❌ Failed to spawn isolate $taskName: $e');

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

      print('🛑 Isolate $taskName stopped');
    }
  }

  /// Stop all running isolates
  void stopAllIsolates() {
    print('🛑 Stopping all isolates...');
    print('🛑 Currently running isolates: ${_runningIsolates.keys.toList()}');

    for (final entry in _runningIsolates.entries) {
      try {
        entry.value.kill();
        print('🛑 Stopped isolate: ${entry.key}');
      } catch (e) {
        print('⚠️ Failed to stop isolate ${entry.key}: $e');
      }
    }

    _runningIsolates.clear();

    for (final receivePort in _receivePorts.values) {
      try {
        receivePort.close();
      } catch (e) {
        print('⚠️ Failed to close receive port: $e');
      }
    }

    _receivePorts.clear();

    print('🛑 All isolates stopped and cleaned up');
  }

  /// Test method to manually trigger newsfeed isolate
  Future<void> testNewsFeedIsolate() async {
    print('🧪 Testing newsfeed isolate manually...');

    try {
      // Get access token from main thread
      final accessToken = LocalStorage.authToken;
      await _startIsolate(
        'testNewsFeed',
        NewsFeedServicesInitializationTask(accessToken: accessToken),
      );
      print('✅ Test newsfeed isolate started');
    } catch (e) {
      print('❌ Failed to start test newsfeed isolate: $e');
    }
  }

  /// Test method to manually trigger simple isolate
  Future<void> testSimpleIsolate() async {
    print('🧪 Testing simple isolate manually...');

    try {
      await _startIsolate(
        'testSimple',
        SimpleTestTask(),
      );
      print('✅ Test simple isolate started');
    } catch (e) {
      print('❌ Failed to start test simple isolate: $e');
    }
  }

  /// Check if isolate is running
  bool isIsolateRunning(String taskName) {
    return _runningIsolates.containsKey(taskName);
  }

  /// Get all running isolate names
  List<String> get runningIsolates => _runningIsolates.keys.toList();
}

/// Entry point for isolates
void _isolateEntryPoint(_IsolateMessage message) {
  print('🚀 Isolate entry point called for task: ${message.taskName}');

  try {
    // Execute the task in complete isolation
    message.task.execute().then((result) {
      print(
          '✅ Isolate task ${message.taskName} completed with result: $result');
      message.sendPort.send(_IsolateResult(
        taskName: message.taskName,
        message: 'Task completed successfully',
        data: result,
      ));
    }).catchError((error) {
      print('❌ Isolate task ${message.taskName} failed with error: $error');
      message.sendPort.send(_IsolateError(
        taskName: message.taskName,
        error: error.toString(),
      ));
    });
  } catch (e) {
    print('💥 Isolate task ${message.taskName} crashed with exception: $e');
    message.sendPort.send(_IsolateError(
      taskName: message.taskName,
      error: e.toString(),
    ));
  }
}

/// Message sent to isolate
class _IsolateMessage {
  final IsolateTask task;
  final String taskName;
  final SendPort sendPort;

  _IsolateMessage({
    required this.task,
    required this.taskName,
    required this.sendPort,
  });
}

/// Result from isolate
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

/// Error from isolate
class _IsolateError {
  final String taskName;
  final String error;

  _IsolateError({
    required this.taskName,
    required this.error,
  });
}

/// Base class for isolate tasks
abstract class IsolateTask {
  String get taskName;
  Future<dynamic> execute();
}
