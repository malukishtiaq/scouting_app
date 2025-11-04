import 'package:injectable/injectable.dart';
import 'package:mutex/mutex.dart';

/// Conceptual Background API to register and manage background tasks.
/// Implementation will be backed by platform schedulers (e.g., workmanager) later.

class BackgroundTask {
  final String
      taskId; // must include userId for isolation: user:<uid>:task:<name>
  final Duration? interval;
  final Duration? initialDelay;
  final Map<String, dynamic> metadata;

  const BackgroundTask({
    required this.taskId,
    this.interval,
    this.initialDelay,
    this.metadata = const {},
  });
}

abstract class BackgroundApi {
  Future<void> registerPeriodic(BackgroundTask task);
  Future<void> registerOneOff(BackgroundTask task);
  Future<void> cancel(String taskId);
  Future<void> cancelAllForUser(String userId);
}

/// Temporary No-op implementation to allow service integration without platform wiring.
@injectable
class NoopBackgroundApi implements BackgroundApi {
  final Mutex _mutex = Mutex();
  final Set<String> _registered = <String>{};

  @override
  Future<void> registerPeriodic(BackgroundTask task) async {
    await _mutex.protect(() async {
      _registered.add(task.taskId);
    });
  }

  @override
  Future<void> registerOneOff(BackgroundTask task) async {
    await _mutex.protect(() async {
      _registered.add(task.taskId);
    });
  }

  @override
  Future<void> cancel(String taskId) async {
    await _mutex.protect(() async {
      _registered.remove(taskId);
    });
  }

  @override
  Future<void> cancelAllForUser(String userId) async {
    await _mutex.protect(() async {
      _registered.removeWhere((id) => id.startsWith('user:$userId:'));
    });
  }
}
