import 'dart:convert';

import '../data/repositories/articles_repository.dart';

class ArticlesService {
  final ArticlesRepository _repo;
  ArticlesService(this._repo);

  Future<void> saveArticles(
      String userId, List<Map<String, dynamic>> articles) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _repo.upsertAll(
      userId,
      articles
          .map((a) => {
                'article_id':
                    a['id']?.toString() ?? a['article_id']?.toString() ?? '',
                'json': jsonEncode(a),
              })
          .toList(),
      now,
    );
  }
}
