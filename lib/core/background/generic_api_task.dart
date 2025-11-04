import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'isolate_background_service.dart';
import '../constants/website_constants.dart';
import '../common/clean_logger.dart';

/// Generic API configuration for background tasks
class GenericApiConfig {
  final String apiUrl;
  final String method; // GET, POST, PUT, DELETE
  final Map<String, String> headers;
  final Map<String, dynamic> bodyFields;
  final Map<String, String> queryParams;
  final String taskName;
  final Duration timeout;

  const GenericApiConfig({
    required this.apiUrl,
    this.method = 'POST',
    this.headers = const {},
    this.bodyFields = const {},
    this.queryParams = const {},
    required this.taskName,
    this.timeout = const Duration(seconds: 30),
  });

  /// Create a copy with modified fields
  GenericApiConfig copyWith({
    String? apiUrl,
    String? method,
    Map<String, String>? headers,
    Map<String, dynamic>? bodyFields,
    Map<String, String>? queryParams,
    String? taskName,
    Duration? timeout,
  }) {
    return GenericApiConfig(
      apiUrl: apiUrl ?? this.apiUrl,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      bodyFields: bodyFields ?? this.bodyFields,
      queryParams: queryParams ?? this.queryParams,
      taskName: taskName ?? this.taskName,
      timeout: timeout ?? this.timeout,
    );
  }
}

/// Generic API task that can handle any API call
class GenericApiTask implements IsolateTask {
  final GenericApiConfig config;
  final String accessToken;

  GenericApiTask({
    required this.config,
    required this.accessToken,
  });

  @override
  String get taskName => config.taskName;

  @override
  Future<Map<String, dynamic>> execute() async {
    try {
      // Validate access token
      if (accessToken.isEmpty) {
        CleanLogger.error(
            'GenericApiTask: Access token not provided to isolate');
        return {
          'success': false,
          'error': 'Access token not provided to isolate.',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
      }

      // Build the URI with query parameters
      final uri = _buildUri();

      // Create the HTTP request
      final request = _createRequest(uri);

      // Execute the request with timeout
      final response = await _executeRequest(request);

      // Process the response
      return _processResponse(response);
    } catch (e) {
      // Always print exceptions for debugging
      CleanLogger.exception(
          'GenericApiTask Exception in ${config.taskName}', e);
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }

  /// Build the URI with query parameters and access token
  Uri _buildUri() {
    final queryParams = Map<String, String>.from(config.queryParams);
    queryParams['access_token'] = accessToken;

    return Uri.parse(config.apiUrl).replace(queryParameters: queryParams);
  }

  /// Create the HTTP request based on method
  http.BaseRequest _createRequest(Uri uri) {
    // 🔍 COMPREHENSIVE API REQUEST LOGGING

    if (config.method.toUpperCase() == 'GET') {
      return http.Request(config.method, uri);
    } else {
      final request = http.MultipartRequest(config.method, uri);

      // Add default headers
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add custom headers
      request.headers.addAll(config.headers);

      // Add body fields
      config.bodyFields.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        } else {
          request.fields[key] = value.toString();
        }
      });

      return request;
    }
  }

  /// Execute the HTTP request with timeout
  Future<http.Response> _executeRequest(http.BaseRequest request) async {
    if (request is http.MultipartRequest) {
      final streamedResponse = await request.send().timeout(config.timeout);
      return await http.Response.fromStream(streamedResponse);
    } else {
      return await http
          .get(request.url, headers: request.headers)
          .timeout(config.timeout);
    }
  }

  /// Process the HTTP response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body);

        // Check API status (WoWonder standard)
        if (jsonData['api_status'] == 200 || jsonData['api_status'] == '200') {
          // For stories API, return the full response to preserve structure
          final data =
              config.taskName.contains('Stories') ? jsonData : jsonData['data'];

          CleanLogger.success(
              'GenericApiTask: ${config.taskName} completed successfully');

          return {
            'success': true,
            'data': data,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'message': 'API call completed successfully in background',
            'rawResponse': jsonData,
          };
        } else {
          final errorText =
              jsonData['errors']?['error_text'] ?? 'Unknown API error';
          CleanLogger.error(
              'GenericApiTask: API error in ${config.taskName}: $errorText');
          return {
            'success': false,
            'error': errorText,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
            'rawResponse': jsonData,
          };
        }
      } catch (parseError) {
        CleanLogger.exception(
            'GenericApiTask: JSON parsing failed in ${config.taskName}',
            parseError);
        return {
          'success': false,
          'error': 'JSON parsing failed: $parseError',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'rawResponse': response.body,
        };
      }
    } else {
      CleanLogger.error(
          'GenericApiTask: HTTP error in ${config.taskName}: ${response.statusCode}');
      return {
        'success': false,
        'error': 'HTTP ${response.statusCode}: ${response.body}',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'rawResponse': response.body,
      };
    }
  }
}

/// Pre-configured API configs for common use cases
class ApiConfigs {
  /// Newsfeed API configuration
  static GenericApiConfig newsfeed({
    String? afterPostId,
    String? limit,
    String? postType,
  }) {
    return GenericApiConfig(
      apiUrl: WebsiteConstants.getApiUrl(WebsiteConstants.postsEndpoint),
      method: 'POST',
      headers: {},
      bodyFields: {
        'server_key': WebsiteConstants.serverKey,
        'type': 'get_news_feed',
        'limit': limit ?? '3', // Limit to 3 posts for debugging
        'after_post_id': afterPostId ?? '0',
        'ad_id': '0', // Add ad_id like Xamarin
        'id': '', // Add id like Xamarin
        if (postType != null && postType.isNotEmpty) 'post_type': postType,
      },
      taskName: 'NewsFeedServicesInitialization',
      timeout: const Duration(
          minutes: 5), // Extended timeout for newsfeed operations
    );
  }

  /// Stories API configuration
  static GenericApiConfig stories({
    String? afterStoryId,
    String? limit,
    String? userId,
  }) {
    return GenericApiConfig(
      apiUrl:
          WebsiteConstants.getApiUrl(WebsiteConstants.getUserStoriesEndpoint),
      method: 'POST',
      headers: {},
      bodyFields: {
        'server_key': WebsiteConstants.serverKey,
        'limit': limit ?? '20',
        'offset': afterStoryId ?? '0',
      },
      taskName: 'StoriesServicesInitialization',
      timeout: const Duration(seconds: 30),
    );
  }

  /// Generic API configuration builder
  static GenericApiConfig custom({
    required String apiUrl,
    required String taskName,
    String method = 'POST',
    Map<String, String> headers = const {},
    Map<String, dynamic> bodyFields = const {},
    Map<String, String> queryParams = const {},
    Duration timeout = const Duration(seconds: 30),
  }) {
    return GenericApiConfig(
      apiUrl: apiUrl,
      method: method,
      headers: headers,
      bodyFields: bodyFields,
      queryParams: queryParams,
      taskName: taskName,
      timeout: timeout,
    );
  }
}
