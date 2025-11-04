import 'package:injectable/injectable.dart';

import 'api/background_api.dart';

@singleton
class BackgroundTasksRegistrar {
  final NoopBackgroundApi _bg;
  BackgroundTasksRegistrar(this._bg);

  Future<void> registerCoreTasks(String userId) async {
    await _bg.registerPeriodic(BackgroundTask(
      taskId: 'user:$userId:settings.refresh',
      interval: const Duration(hours: 12),
      initialDelay: const Duration(minutes: 5),
    ));

    await _bg.registerPeriodic(BackgroundTask(
      taskId: 'user:$userId:gifts.sync',
      interval: const Duration(days: 1),
      initialDelay: const Duration(hours: 1),
    ));

    await _bg.registerPeriodic(BackgroundTask(
      taskId: 'user:$userId:user.profile.refresh',
      interval: const Duration(hours: 6),
      initialDelay: const Duration(minutes: 10),
    ));

    await _bg.registerPeriodic(BackgroundTask(
      taskId: 'user:$userId:chat.pins.sync',
      interval: const Duration(minutes: 30),
      initialDelay: const Duration(minutes: 15),
    ));

    // Chats list periodic sync
    await _bg.registerPeriodic(BackgroundTask(
      taskId: 'user:$userId:chat.list.sync',
      interval: const Duration(minutes: 1),
      initialDelay: const Duration(minutes: 1),
    ));
  }

  Future<void> unregisterAll(String userId) async {
    await _bg.cancelAllForUser(userId);
  }
}
