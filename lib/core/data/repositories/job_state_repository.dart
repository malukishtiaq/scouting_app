import 'package:sqflite/sqflite.dart';

import '../db/db_provider.dart';

class JobState {
  final String taskId;
  final String userId;
  final int attempt;
  final int? lastRunAtMs;
  final int? nextRunAtMs;
  final int? backoffUntilMs;
  final String? resultJson;

  JobState({
    required this.taskId,
    required this.userId,
    this.attempt = 0,
    this.lastRunAtMs,
    this.nextRunAtMs,
    this.backoffUntilMs,
    this.resultJson,
  });

  Map<String, Object?> toMap() => {
        'task_id': taskId,
        'user_id': userId,
        'attempt': attempt,
        'last_run_at': lastRunAtMs,
        'next_run_at': nextRunAtMs,
        'backoff_until': backoffUntilMs,
        'result_json': resultJson,
      };

  static JobState fromMap(Map<String, Object?> map) => JobState(
        taskId: map['task_id'] as String,
        userId: map['user_id'] as String,
        attempt: (map['attempt'] as int?) ?? 0,
        lastRunAtMs: map['last_run_at'] as int?,
        nextRunAtMs: map['next_run_at'] as int?,
        backoffUntilMs: map['backoff_until'] as int?,
        resultJson: map['result_json'] as String?,
      );
}

abstract class IJobStateRepository {
  Future<JobState?> getById(String taskId);
  Future<void> upsert(JobState state);
  Future<void> removeByUser(String userId);
}

class JobStateRepository implements IJobStateRepository {
  final DbProvider _dbProvider;
  JobStateRepository(this._dbProvider);

  Future<Database> get _db async => _dbProvider.database;

  @override
  Future<JobState?> getById(String taskId) async {
    final db = await _db;
    final rows = await db.query('job_state',
        where: 'task_id = ?', whereArgs: [taskId], limit: 1);
    if (rows.isEmpty) return null;
    return JobState.fromMap(rows.first);
  }

  @override
  Future<void> upsert(JobState state) async {
    final db = await _db;
    await db.insert('job_state', state.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> removeByUser(String userId) async {
    final db = await _db;
    await db.delete('job_state', where: 'user_id = ?', whereArgs: [userId]);
  }
}
