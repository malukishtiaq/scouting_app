import 'package:dio/dio.dart';

class CovidStats {
  final String country;
  final int? casesTotal;
  final int? deathsTotal;
  CovidStats({required this.country, this.casesTotal, this.deathsTotal});

  factory CovidStats.fromMap(Map<String, dynamic> map) => CovidStats(
        country: map['country'] ?? '',
        casesTotal: map['cases']?['total'] as int?,
        deathsTotal: map['deaths']?['total'] as int?,
      );
}

class HealthService {
  final Dio _dio;
  final String _apiKey;
  final String _apiHost;

  HealthService(
      {required Dio dio, required String apiKey, required String apiHost})
      : _dio = dio,
        _apiKey = apiKey,
        _apiHost = apiHost;

  Future<CovidStats> fetchCovidStats(String country) async {
    final response = await _dio.get(
      'https://covid-193.p.rapidapi.com/statistics',
      queryParameters: {'country': country},
      options: Options(headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _apiHost,
      }),
    );
    final list = (response.data['response'] as List?) ?? [];
    if (list.isEmpty) return CovidStats(country: country);
    return CovidStats.fromMap(list.first);
  }
}
