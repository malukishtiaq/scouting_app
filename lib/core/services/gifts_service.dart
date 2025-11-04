import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../data/repositories/gifts_repository.dart';

class GiftsService {
  final GiftsRepository _repo;
  GiftsService(this._repo);

  Future<void> saveGifts(String userId, List<Map<String, dynamic>> gifts,
      {bool precache = false}) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertAll(
      userId,
      gifts
          .map((g) => {
                'gift_id':
                    g['id']?.toString() ?? g['gift_id']?.toString() ?? '',
                'media_url': g['media_file'] ?? g['mediaUrl'] ?? '',
                'json': jsonEncode(g),
              })
          .toList(),
      now,
    );

    if (precache) {
      for (final g in gifts) {
        final url = g['media_file'] ?? g['mediaUrl'] ?? '';
        if (url is String && url.isNotEmpty) {
          // best-effort cache
          await DefaultCacheManager().downloadFile(url);
        }
      }
    }
  }
}
