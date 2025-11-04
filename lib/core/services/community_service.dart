import 'dart:convert';

import '../data/repositories/community_repository.dart';

class CommunityService {
  final CommunityRepository _repo;
  CommunityService(this._repo);

  Future<void> saveSuggestedUsers(
      String userId, List<Map<String, dynamic>> users) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertSuggestedUsers(
      userId,
      users
          .map((u) => {
                'suggested_user_id':
                    u['user_id']?.toString() ?? u['id']?.toString() ?? '',
                'json': jsonEncode(u),
              })
          .toList(),
      now,
    );
  }

  Future<void> saveSuggestedGroups(
      String userId, List<Map<String, dynamic>> groups) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertSuggestedGroups(
      userId,
      groups
          .map((g) => {
                'group_id':
                    g['group_id']?.toString() ?? g['id']?.toString() ?? '',
                'json': jsonEncode(g),
              })
          .toList(),
      now,
    );
  }

  Future<void> saveSuggestedPages(
      String userId, List<Map<String, dynamic>> pages) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertSuggestedPages(
      userId,
      pages
          .map((p) => {
                'page_id':
                    p['page_id']?.toString() ?? p['id']?.toString() ?? '',
                'json': jsonEncode(p),
              })
          .toList(),
      now,
    );
  }

  Future<void> saveMyGroups(
      String userId, List<Map<String, dynamic>> groups) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertMyGroups(
      userId,
      groups
          .map((g) => {
                'group_id':
                    g['group_id']?.toString() ?? g['id']?.toString() ?? '',
                'json': jsonEncode(g),
              })
          .toList(),
      now,
    );
  }

  Future<void> saveMyPages(
      String userId, List<Map<String, dynamic>> pages) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertMyPages(
      userId,
      pages
          .map((p) => {
                'page_id':
                    p['page_id']?.toString() ?? p['id']?.toString() ?? '',
                'json': jsonEncode(p),
              })
          .toList(),
      now,
    );
  }
}
