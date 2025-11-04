import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class CommunityRepository {
  final DbProvider _dbProvider;
  CommunityRepository(this._dbProvider);

  Future<void> upsertSuggestedUsers(
      String userId, List<Map<String, Object?>> users, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final u in users) {
        await txn.insert(
            'community_suggested_users',
            {
              'user_id': userId,
              'suggested_user_id': u['suggested_user_id'],
              'json': u['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> upsertSuggestedGroups(
      String userId, List<Map<String, Object?>> groups, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final g in groups) {
        await txn.insert(
            'community_suggested_groups',
            {
              'user_id': userId,
              'group_id': g['group_id'],
              'json': g['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> upsertSuggestedPages(
      String userId, List<Map<String, Object?>> pages, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final p in pages) {
        await txn.insert(
            'community_suggested_pages',
            {
              'user_id': userId,
              'page_id': p['page_id'],
              'json': p['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> upsertMyGroups(
      String userId, List<Map<String, Object?>> groups, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final g in groups) {
        await txn.insert(
            'groups_mine',
            {
              'user_id': userId,
              'group_id': g['group_id'],
              'json': g['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> upsertMyPages(
      String userId, List<Map<String, Object?>> pages, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.transaction((txn) async {
      for (final p in pages) {
        await txn.insert(
            'pages_mine',
            {
              'user_id': userId,
              'page_id': p['page_id'],
              'json': p['json'],
              'updated_at': updatedAtMs,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }
}
