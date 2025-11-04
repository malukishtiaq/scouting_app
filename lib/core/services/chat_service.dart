import 'dart:convert';

import '../data/repositories/pins_repository.dart';

class ChatService {
  final PinsRepository _repo;
  ChatService(this._repo);

  Future<void> savePinnedChats(
      String userId, List<Map<String, dynamic>> chats) async {
    final filtered = chats.where((c) {
      final mute = c['mute'];
      if (mute is Map && (mute['archive']?.toString().toLowerCase() == 'yes'))
        return false;
      return true;
    }).toList();

    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertAll(
      userId,
      filtered
          .map((c) => {
                'chat_id':
                    c['chat_id']?.toString() ?? c['id']?.toString() ?? '',
                'last_message_id': c['last_message']?['last_message_class']
                            ?['id']
                        ?.toString() ??
                    c['lastMessageId']?.toString(),
                'json': jsonEncode(c),
              })
          .toList(),
      now,
    );
  }
}
