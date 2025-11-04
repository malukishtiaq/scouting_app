import 'package:dio/dio.dart';

class WeatherCurrent {
  final double tempC;
  final String conditionText;
  WeatherCurrent({required this.tempC, required this.conditionText});
  factory WeatherCurrent.fromMap(Map<String, dynamic> map) => WeatherCurrent(
        tempC: (map['temp_c'] as num).toDouble(),
        conditionText: map['condition']?['text'] ?? '',
      );
}

class WeatherLocation {
  final String name;
  final String country;
  WeatherLocation({required this.name, required this.country});
  factory WeatherLocation.fromMap(Map<String, dynamic> map) => WeatherLocation(
        name: map['name'] ?? '',
        country: map['country'] ?? '',
      );
}

class GetWeatherObject {
  final WeatherLocation location;
  final WeatherCurrent current;
  GetWeatherObject({required this.location, required this.current});
  factory GetWeatherObject.fromMap(Map<String, dynamic> map) =>
      GetWeatherObject(
        location: WeatherLocation.fromMap(map['location'] ?? {}),
        current: WeatherCurrent.fromMap(map['current'] ?? {}),
      );
}

class WeatherService {
  final Dio _dio;
  final String _apiKey;

  WeatherService({required Dio dio, required String apiKey})
      : _dio = dio,
        _apiKey = apiKey;

  Future<GetWeatherObject> fetchWeather({
    required String city,
    String lang = 'en',
  }) async {
    final response = await _dio.get(
      'https://api.weatherapi.com/v1/forecast.json',
      queryParameters: {
        'key': _apiKey,
        'q': city,
        'lang': lang,
      },
    );
    return GetWeatherObject.fromMap(response.data);
  }
}
