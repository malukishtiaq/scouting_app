import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class ContactsRepository {
  final DbProvider _dbProvider;
  ContactsRepository(this._dbProvider);

  Future<void> upsertAll(String userId, List<Map<String, Object?>> contacts,
      int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final c in contacts) {
        await txn.insert(
          'contacts',
          {
            'user_id': userId,
            'contact_id': c['contact_id'],
            'json': c['json'],
            'updated_at': updatedAtMs,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
