import 'dart:convert';
import 'dart:io';

class GiphyMeta {
  final int status;
  final String? msg;
  GiphyMeta({required this.status, this.msg});
  factory GiphyMeta.fromMap(Map<String, dynamic> map) => GiphyMeta(
        status: map['status'] ?? 0,
        msg: map['msg'],
      );
}

class GiphyImage {
  final String url;
  final int? width;
  final int? height;
  GiphyImage({required this.url, this.width, this.height});
  factory GiphyImage.fromMap(Map<String, dynamic> map) => GiphyImage(
        url: map['url'] ?? '',
        width: int.tryParse(map['width']?.toString() ?? ''),
        height: int.tryParse(map['height']?.toString() ?? ''),
      );
}

class GiphyDatum {
  final String id;
  final String title;
  final GiphyImage? original;
  GiphyDatum({required this.id, required this.title, this.original});
  factory GiphyDatum.fromMap(Map<String, dynamic> map) => GiphyDatum(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        original: map['images'] != null && map['images']['original'] != null
            ? GiphyImage.fromMap(map['images']['original'])
            : null,
      );
}

class MediaService {
  final HttpClient _httpClient;
  final String _giphyApiKey;

  MediaService({HttpClient? httpClient, required String giphyApiKey})
      : _httpClient = httpClient ?? HttpClient(),
        _giphyApiKey = giphyApiKey;

  Future<List<GiphyDatum>> searchGiphy({
    required String query,
    int limit = 45,
    String rating = 'g',
    int offset = 0,
  }) async {
    try {
      final uri = Uri.parse('https://api.giphy.com/v1/gifs/search').replace(
        queryParameters: {
          'api_key': _giphyApiKey,
          'q': query,
          'limit': limit.toString(),
          'rating': rating,
          'offset': offset.toString(),
        },
      );

      final request = await _httpClient.getUrl(uri);
      request.headers.set(
        'User-Agent',
        'Mozilla/5.0 (Linux; Android 13; SM-A146B Build/TQ3A.230705.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/124.0.0.0 Mobile Safari/537.36',
      );
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      final responseData = json.decode(responseBody) as Map<String, dynamic>;

      final data = (responseData['data'] as List?) ?? [];
      return data.map((e) => GiphyDatum.fromMap(e)).toList();
    } catch (e) {
      print('Error searching Giphy: $e');
      return [];
    }
  }

  Future<List<GiphyDatum>> trendingGiphy({
    int limit = 45,
    String rating = 'g',
    int offset = 0,
  }) async {
    try {
      final uri = Uri.parse('https://api.giphy.com/v1/gifs/trending').replace(
        queryParameters: {
          'api_key': _giphyApiKey,
          'limit': limit.toString(),
          'rating': rating,
          'offset': offset.toString(),
        },
      );

      final request = await _httpClient.getUrl(uri);
      request.headers.set(
        'User-Agent',
        'Mozilla/5.0 (Linux; Android 13; SM-A146B Build/TQ3A.230705.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/124.0.0.0 Mobile Safari/537.36',
      );
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      final responseData = json.decode(responseBody) as Map<String, dynamic>;

      final data = (responseData['data'] as List?) ?? [];
      return data.map((e) => GiphyDatum.fromMap(e)).toList();
    } catch (e) {
      print('Error searching Giphy: $e');
      return [];
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
