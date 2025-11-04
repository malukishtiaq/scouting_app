import 'package:dio/dio.dart';

class SocialEmbedService {
  final Dio _dio;
  SocialEmbedService({required Dio dio}) : _dio = dio;

  Future<String> fetchTwitterOEmbed(String url) async {
    final response = await _dio.get(
      'https://publish.twitter.com/oembed',
      queryParameters: {'url': url},
    );
    return response.data['html']?.toString() ?? '';
  }
}
