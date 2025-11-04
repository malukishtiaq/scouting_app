import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class ArticlesRepository {
  final DbProvider _dbProvider;
  ArticlesRepository(this._dbProvider);

  Future<void> upsertAll(String userId, List<Map<String, Object?>> articles,
      int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final a in articles) {
        await txn.insert(
            'articles',
            {
              'user_id': userId,
              'article_id': a['article_id'],
              'json': a['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}
