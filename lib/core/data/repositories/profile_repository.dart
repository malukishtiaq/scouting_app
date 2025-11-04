import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class ProfileRepository {
  final DbProvider _dbProvider;
  ProfileRepository(this._dbProvider);

  Future<void> upsert(
      String userId, Map<String, Object?> profile, int updatedAtMs) async {
    final db = await _dbProvider.database;
    await db.insert(
        'profile',
        {
          'user_id': userId,
          'name': profile['name'],
          'username': profile['username'],
          'email': profile['email'],
          'avatar_url': profile['avatar_url'],
          'cover_url': profile['cover_url'],
          'json': profile['json'],
          'updated_at': updatedAtMs,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
