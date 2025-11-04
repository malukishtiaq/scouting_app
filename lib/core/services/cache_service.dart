import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<void> trimCaches() async {
    await DefaultCacheManager().emptyCache();
    final tempDir = await getTemporaryDirectory();
    await _deleteDir(tempDir);
  }

  Future<void> _deleteDir(Directory dir) async {
    if (!await dir.exists()) return;
    try {
      await dir.delete(recursive: true);
    } catch (_) {
      // best-effort
    }
  }
}
