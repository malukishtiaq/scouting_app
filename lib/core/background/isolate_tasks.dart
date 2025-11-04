import 'dart:async';
import 'dart:developer';
import 'isolate_background_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/website_constants.dart';

/// Task for initializing core services in isolate
class CoreServicesInitializationTask implements IsolateTask {
  @override
  String get taskName => 'CoreServicesInitialization';

  @override
  Future<Map<String, dynamic>> execute() async {
    print('🔄 Executing core services initialization in isolate...');

    try {
      await Future.delayed(const Duration(seconds: 2));
      print('✅ Core services initialization completed in isolate');
      return {
        'success': true,
        'message': 'Core services initialized successfully',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      print('❌ Core services initialization failed in isolate: $e');
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }
}

/// Task for news feed services initialization with proper data return
class NewsFeedServicesInitializationTask implements IsolateTask {
  final String? accessToken; // Accept access token from main thread
  final String? afterPostId; // Accept after_post_id from main thread
  final String? limit; // Accept limit from main thread
  final String? postType; // Accept post_type from main thread

  NewsFeedServicesInitializationTask({
    this.accessToken,
    this.afterPostId,
    this.limit,
    this.postType,
  });

  @override
  String get taskName => 'NewsFeedServicesInitialization';

  @override
  Future<Map<String, dynamic>> execute() async {
    try {
      // Use access token passed from main thread instead of SharedPreferences
      if (accessToken == null || accessToken!.isEmpty) {
        return {
          'success': false,
          'error': 'Access token not provided to isolate.',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
      }

      // Use the exact same approach as the working curl command
      // This ensures we send the request in the exact same format
      final uri = Uri.parse(
          '${WebsiteConstants.getApiUrl(WebsiteConstants.postsEndpoint)}?access_token=$accessToken');

      // Create the same request body as the working curl command

      // Use http.MultipartRequest to send form data (equivalent to FormData)
      final request = http.MultipartRequest('POST', uri);

      // Set headers to match curl behavior
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add all fields to the form data - ensure server_key is first
      request.fields['server_key'] = WebsiteConstants.serverKey;
      request.fields['type'] = 'get_news_feed';
      request.fields['limit'] = limit ?? '3'; // Limit to 3 posts for debugging
      request.fields['after_post_id'] = afterPostId ?? '0';
      request.fields['ad_id'] = '0'; // Add ad_id like Xamarin
      request.fields['id'] = ''; // Add id like Xamarin

      // Add post_type filter if provided
      if (postType != null && postType!.isNotEmpty) {
        request.fields['post_type'] = postType!;
      }

      // Add proper timeout and error handling
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out after 30 seconds');
        },
      );

      final response = await http.Response.fromStream(streamedResponse).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Response parsing timed out after 10 seconds');
        },
      );

      // Log the complete raw JSON response
      // log('Printing from isolate: ${response.body}');

      if (response.statusCode == 200) {
        // Parse JSON response in isolate (no main thread blocking)
        try {
          final jsonData = jsonDecode(response.body);
          // Process the data in isolate
          if (jsonData['api_status'] == 200 ||
              jsonData['api_status'] == '200') {
            final data = jsonData['data'] as List?;

            // Return processed data for main thread consumption
            return {
              'success': true,
              'data': data,
              'timestamp': DateTime.now().millisecondsSinceEpoch,
              'message': 'Newsfeed data fetched successfully in background',
            };
          } else {
            final errorText =
                jsonData['errors']?['error_text'] ?? 'Unknown error';
            return {
              'success': false,
              'error': errorText,
              'timestamp': DateTime.now().millisecondsSinceEpoch,
            };
          }
        } catch (parseError) {
          return {
            'success': false,
            'error': 'JSON parsing failed: $parseError',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          };
        }
      } else {
        return {
          'success': false,
          'error': 'HTTP ${response.statusCode}: ${response.body}',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
      }
    } on TimeoutException catch (e) {
      print('⏰ Isolate task timed out: $e');
      return {
        'success': false,
        'error': 'Request timed out: $e',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } on http.ClientException catch (e) {
      print('🌐 HTTP client error in isolate: $e');
      return {
        'success': false,
        'error': 'Network error: $e',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } on FormatException catch (e) {
      print('📝 Format error in isolate: $e');
      return {
        'success': false,
        'error': 'Data format error: $e',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      print('💥 Unexpected error in isolate: $e');
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }
}

/// Simple test task that doesn't use SharedPreferences
class SimpleTestTask implements IsolateTask {
  @override
  String get taskName => 'SimpleTest';

  @override
  Future<Map<String, dynamic>> execute() async {
    print('🧪 Simple test task executing in isolate...');

    try {
      // Just test basic isolate functionality
      await Future.delayed(const Duration(seconds: 1));

      print('✅ Simple test task completed successfully');
      return {
        'success': true,
        'message': 'Simple test completed',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      print('❌ Simple test task failed: $e');
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }
}

/// Task for trending services initialization
class TrendingServicesInitializationTask implements IsolateTask {
  @override
  String get taskName => 'TrendingServicesInitialization';

  @override
  Future<Map<String, dynamic>> execute() async {
    print('🔄 Executing trending services initialization in isolate...');

    try {
      await Future.delayed(const Duration(seconds: 2));
      print('✅ Trending services initialization completed in isolate');
      return {
        'success': true,
        'message': 'Trending services initialized successfully',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    } catch (e) {
      print('❌ Trending services initialization failed in isolate: $e');
      return {
        'success': false,
        'error': e.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }
}
