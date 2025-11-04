import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class TimezoneInfo {
  final String timezone;
  final String country;
  final String city;
  final double lat;
  final double lon;

  TimezoneInfo({
    required this.timezone,
    required this.country,
    required this.city,
    required this.lat,
    required this.lon,
  });

  factory TimezoneInfo.fromMap(Map<String, dynamic> map) => TimezoneInfo(
        timezone: map['timezone'] ?? '',
        country: map['country'] ?? '',
        city: map['city'] ?? '',
        lat: (map['lat'] as num?)?.toDouble() ?? 0,
        lon: (map['lon'] as num?)?.toDouble() ?? 0,
      );
}

/// Location Service - Handles GPS and IP-based location detection
/// Registered manually in service_locator.dart (not using @injectable)
class LocationService {
  final Dio _dio;
  LocationService({required Dio dio}) : _dio = dio;

  Future<TimezoneInfo> resolveTimezoneFromIp() async {
    final response = await _dio.get('http://ip-api.com/json/');
    return TimezoneInfo.fromMap(response.data);
  }

  /// Get current device location (GPS)
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ Location services are disabled');
        return null;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('❌ Location permission denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('❌ Location permission permanently denied');
        return null;
      }

      // Get current position
      print('📍 Getting current GPS location...');
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
      );

      print('✅ GPS location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('❌ Error getting location: $e');
      return null;
    }
  }

  /// Get city name from GPS coordinates using reverse geocoding
  Future<String?> getCityFromCoordinates(double lat, double lon) async {
    try {
      print('🌍 Reverse geocoding: $lat, $lon');

      // Use IP-API with coordinates to get city name
      final response = await _dio.get(
        'http://ip-api.com/json/',
        queryParameters: {
          'lat': lat.toString(),
          'lon': lon.toString(),
        },
      );

      final city = response.data['city'] as String?;
      print('🏙️ Resolved city: $city');
      return city;
    } catch (e) {
      print('❌ Error resolving city: $e');
      // Fallback: Use coordinates directly (weather API supports lat,lon)
      return '$lat,$lon';
    }
  }

  /// Get city for weather - tries GPS first, falls back to IP-based location
  Future<String> getCityForWeather() async {
    try {
      // Try GPS location first
      final position = await getCurrentLocation();
      if (position != null) {
        // Use coordinates directly (WeatherAPI supports lat,lon format)
        final coords = '${position.latitude},${position.longitude}';
        print('✅ Using GPS coordinates for weather: $coords');
        return coords;
      }

      // Fallback to IP-based location
      print('📡 Falling back to IP-based location...');
      final timezoneInfo = await resolveTimezoneFromIp();
      if (timezoneInfo.city.isNotEmpty) {
        print('✅ Using IP-based city for weather: ${timezoneInfo.city}');
        return timezoneInfo.city;
      }

      // Final fallback
      print('⚠️ Using default city: London');
      return 'London';
    } catch (e) {
      print('❌ Error getting city for weather: $e');
      return 'London'; // Safe fallback
    }
  }
}
