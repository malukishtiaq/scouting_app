import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:injectable/injectable.dart';

@injectable
class DbProvider {
  static const _dbName = 'app_data.db';
  static const _dbVersion = 5; // Incremented for generic_cache table

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await _createSchema(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // handle migrations here
        if (oldVersion < 2) {
          // Add stories table for version 2
          await db.execute('''
            CREATE TABLE IF NOT EXISTS stories (
              user_id TEXT NOT NULL,
              story_id TEXT NOT NULL,
              json TEXT NOT NULL,
              created_at INTEGER NOT NULL,
              expires_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL,
              PRIMARY KEY (user_id, story_id)
            );
          ''');
          await db.execute(
              'CREATE INDEX IF NOT EXISTS idx_stories_user_created ON stories(user_id, created_at DESC);');
          await db.execute(
              'CREATE INDEX IF NOT EXISTS idx_stories_expires ON stories(expires_at);');
        }
        if (oldVersion < 3) {
          // Add raw posts table for version 3
          await db.execute('''
            CREATE TABLE IF NOT EXISTS posts_raw (
              user_id TEXT NOT NULL,
              post_id TEXT NOT NULL,
              json_raw TEXT NOT NULL,
              fetched_at INTEGER NOT NULL,
              PRIMARY KEY (user_id, post_id)
            );
          ''');
          await db.execute(
              'CREATE INDEX IF NOT EXISTS idx_posts_raw_user_fetched ON posts_raw(user_id, fetched_at DESC);');
        }
        if (oldVersion < 4) {
          // Ensure posts_raw table exists for version 4
          await db.execute('''
            CREATE TABLE IF NOT EXISTS posts_raw (
              user_id TEXT NOT NULL,
              post_id TEXT NOT NULL,
              json_raw TEXT NOT NULL,
              fetched_at INTEGER NOT NULL,
              PRIMARY KEY (user_id, post_id)
            );
          ''');
          await db.execute(
              'CREATE INDEX IF NOT EXISTS idx_posts_raw_user_fetched ON posts_raw(user_id, fetched_at DESC);');
        }
        if (oldVersion < 5) {
          // Add generic_cache table for version 5
          await db.execute('''
            CREATE TABLE IF NOT EXISTS generic_cache (
              feature TEXT NOT NULL,
              cache_key TEXT NOT NULL,
              item_id TEXT NOT NULL,
              json TEXT NOT NULL,
              cached_at INTEGER NOT NULL,
              PRIMARY KEY (feature, cache_key, item_id)
            );
          ''');
          await db.execute(
              'CREATE INDEX IF NOT EXISTS idx_generic_cache_feature_key ON generic_cache(feature, cache_key, cached_at DESC);');
        }
      },
    );
  }

  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS job_state (
        task_id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        attempt INTEGER NOT NULL DEFAULT 0,
        last_run_at INTEGER,
        next_run_at INTEGER,
        backoff_until INTEGER,
        result_json TEXT
      );
    ''');
    await db.execute(
        'CREATE INDEX IF NOT EXISTS idx_job_state_user ON job_state(user_id);');
    await _applySchemaFromString(db);
  }

  Future<void> _applySchemaFromString(Database db) async {
    const schema = '''
-- user-scoped tables
CREATE TABLE IF NOT EXISTS settings (
  user_id TEXT PRIMARY KEY,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS gifts (
  user_id TEXT NOT NULL,
  gift_id TEXT NOT NULL,
  media_url TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, gift_id)
);
CREATE INDEX IF NOT EXISTS idx_gifts_user ON gifts(user_id);

CREATE TABLE IF NOT EXISTS profile (
  user_id TEXT PRIMARY KEY,
  name TEXT,
  username TEXT,
  email TEXT,
  avatar_url TEXT,
  cover_url TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS contacts (
  user_id TEXT NOT NULL,
  contact_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY(user_id, contact_id)
);
CREATE INDEX IF NOT EXISTS idx_contacts_user ON contacts(user_id);

CREATE TABLE IF NOT EXISTS pins (
  user_id TEXT NOT NULL,
  chat_id TEXT NOT NULL,
  last_message_id TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, chat_id)
);
CREATE INDEX IF NOT EXISTS idx_pins_user ON pins(user_id);

CREATE TABLE IF NOT EXISTS community_suggested_users (
  user_id TEXT NOT NULL,
  suggested_user_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, suggested_user_id)
);

CREATE TABLE IF NOT EXISTS community_suggested_groups (
  user_id TEXT NOT NULL,
  group_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE IF NOT EXISTS community_suggested_pages (
  user_id TEXT NOT NULL,
  page_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, page_id)
);

CREATE TABLE IF NOT EXISTS groups_mine (
  user_id TEXT NOT NULL,
  group_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE IF NOT EXISTS pages_mine (
  user_id TEXT NOT NULL,
  page_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, page_id)
);

CREATE TABLE IF NOT EXISTS articles (
  user_id TEXT NOT NULL,
  article_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, article_id)
);

-- Newsfeed offline-first tables
CREATE TABLE IF NOT EXISTS posts (
  user_id TEXT NOT NULL,
  post_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, post_id)
);
CREATE INDEX IF NOT EXISTS idx_posts_user_updated ON posts(user_id, updated_at DESC);

CREATE TABLE IF NOT EXISTS stories (
  user_id TEXT NOT NULL,
  story_id TEXT NOT NULL,
  json TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  expires_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, story_id)
);
CREATE INDEX IF NOT EXISTS idx_stories_user_created ON stories(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_stories_expires ON stories(expires_at);

CREATE TABLE IF NOT EXISTS posts_raw (
  user_id TEXT NOT NULL,
  post_id TEXT NOT NULL,
  json_raw TEXT NOT NULL,
  fetched_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, post_id)
);
CREATE INDEX IF NOT EXISTS idx_posts_raw_user_fetched ON posts_raw(user_id, fetched_at DESC);

CREATE TABLE IF NOT EXISTS feed_meta (
  user_id TEXT PRIMARY KEY,
  last_refresh_at INTEGER NOT NULL,
  etag TEXT,
  version INTEGER DEFAULT 1
);

-- Generic cache table for multi-feature caching
CREATE TABLE IF NOT EXISTS generic_cache (
  feature TEXT NOT NULL,
  cache_key TEXT NOT NULL,
  item_id TEXT NOT NULL,
  json TEXT NOT NULL,
  cached_at INTEGER NOT NULL,
  PRIMARY KEY (feature, cache_key, item_id)
);
CREATE INDEX IF NOT EXISTS idx_generic_cache_feature_key ON generic_cache(feature, cache_key, cached_at DESC);
''';
    final batch = db.batch();
    for (final stmt in schema.split(';')) {
      final sql = stmt.trim();
      if (sql.isEmpty) continue;
      batch.execute('$sql;');
    }
    await batch.commit(noResult: true);
  }

  Future<void> clearUser(String userId) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('job_state', where: 'user_id = ?', whereArgs: [userId]);
      // Add other per-user tables here in future migrations
    });
  }

  Future<void> clearAll() async {
    final db = await database;
    final tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    for (final row in tables) {
      final name = row['name'] as String;
      if (name.startsWith('sqlite_')) continue;
      await db.delete(name);
    }
  }

  /// Clear the entire database and recreate it (for schema updates)
  Future<void> recreateDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _dbName);

    // Close existing database
    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    // Delete the database file
    try {
      await deleteDatabase(path);
    } catch (e) {
      print('Warning: Could not delete database file: $e');
    }

    // Recreate the database
    _db = await _open();
  }

  /// Check if posts_raw table exists and recreate database if not
  Future<void> ensurePostsRawTable() async {
    final db = await database;
    try {
      // Check if posts_raw table exists
      final result = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='posts_raw'");

      if (result.isEmpty) {
        print('🔧 posts_raw table missing, recreating database...');
        await recreateDatabase();
      }
    } catch (e) {
      print('❌ Error checking posts_raw table: $e');
      // If there's an error, recreate the database
      await recreateDatabase();
    }
  }
}
