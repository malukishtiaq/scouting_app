import 'dart:convert';

import '../data/repositories/settings_repository.dart';

class SettingsService {
  final SettingsRepository _repo;
  SettingsService(this._repo);

  Future<void> saveSettings(
      String userId, Map<String, dynamic> settings) async {
    await _repo.upsert(
        userId, jsonEncode(settings), DateTime.now().millisecondsSinceEpoch);
  }
}
