import 'package:dio/dio.dart';

class ExchangeRates {
  final String base;
  final int timestamp;
  final Map<String, double> rates;
  ExchangeRates(
      {required this.base, required this.timestamp, required this.rates});
  factory ExchangeRates.fromMap(Map<String, dynamic> map) => ExchangeRates(
        base: map['base'] ?? '',
        timestamp: map['timestamp'] ?? 0,
        rates: (map['rates'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      );
}

class CurrencyService {
  final Dio _dio;
  final String _appId;

  CurrencyService({required Dio dio, required String appId})
      : _dio = dio,
        _appId = appId;

  Future<ExchangeRates> fetchRates({
    required String base,
    required List<String> symbols,
  }) async {
    final response = await _dio.get(
      'https://openexchangerates.org/api/latest.json',
      queryParameters: {
        'app_id': _appId,
        'base': base,
        'symbols': symbols.join(','),
      },
    );
    return ExchangeRates.fromMap(response.data);
  }
}
