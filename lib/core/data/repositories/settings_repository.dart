import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class SettingsRepository {
  final DbProvider _dbProvider;
  SettingsRepository(this._dbProvider);

  Future<void> upsert(String userId, String json, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.insert(
        'settings',
        {
          'user_id': userId,
          'json': json,
          'updated_at': updatedAtMs,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, Object?>?> get(String userId) async {
    final db = await _dbProvider.database;
    final rows = await db.query('settings',
        where: 'user_id = ?', whereArgs: [userId], limit: 1);
    if (rows.isEmpty) return null;
    return rows.first;
  }
}
