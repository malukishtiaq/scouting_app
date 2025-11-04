import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class PinsRepository {
  final DbProvider _dbProvider;
  PinsRepository(this._dbProvider);

  Future<void> upsertAll(
      String userId, List<Map<String, Object?>> pins, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final p in pins) {
        await txn.insert(
          'pins',
          {
            'user_id': userId,
            'chat_id': p['chat_id'],
            'last_message_id': p['last_message_id'],
            'json': p['json'],
            'updated_at': updatedAtMs,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
