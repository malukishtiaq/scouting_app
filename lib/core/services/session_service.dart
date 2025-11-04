import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../background/isolate_background_service.dart';
import '../data/db/db_provider.dart';

class SessionService {
  final IsolateBackgroundService isolateService;
  final DbProvider dbProvider;

  SessionService({required this.isolateService, required this.dbProvider});

  Future<void> logout(String userId) async {
    // Stop all running isolates for this user
    isolateService.stopAllIsolates();
    await OneSignal.logout();
    await dbProvider.clearUser(userId);
    // TODO: clear caches and secure storage in implementation phase
  }

  Future<void> deleteAccount(String userId) async {
    // TODO: call server-side delete when wiring account repo
    await logout(userId);
  }
}
