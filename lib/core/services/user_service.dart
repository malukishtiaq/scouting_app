import 'dart:convert';

import '../data/repositories/contacts_repository.dart';
import '../data/repositories/profile_repository.dart';

class UserService {
  final ProfileRepository _profileRepo;
  final ContactsRepository _contactsRepo;
  UserService(this._profileRepo, this._contactsRepo);

  Future<void> saveMyProfile(String userId, Map<String, dynamic> user) async {
    await _profileRepo.upsert(
        userId,
        {
          'name': user['name'],
          'username': user['username'],
          'email': user['email'],
          'avatar_url': user['avatar'],
          'cover_url': user['cover'],
          'json': jsonEncode(user),
        },
        DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> saveFollowing(
      String userId, List<Map<String, dynamic>> following) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _contactsRepo.upsertAll(
      userId,
      following
          .map((e) => {
                'contact_id':
                    e['id']?.toString() ?? e['user_id']?.toString() ?? '',
                'json': jsonEncode(e),
              })
          .toList(),
      now,
    );
  }
}
