import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class GiftsRepository {
  final DbProvider _dbProvider;
  GiftsRepository(this._dbProvider);

  Future<void> upsertAll(
      String userId, List<Map<String, Object?>> items, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final item in items) {
        await txn.insert(
          'gifts',
          {
            'user_id': userId,
            'gift_id': item['gift_id'],
            'media_url': item['media_url'],
            'json': item['json'],
            'updated_at': updatedAtMs,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
