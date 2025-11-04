import 'package:injectable/injectable.dart';
import 'generic_background_service.dart';
import 'generic_api_task.dart';
import '../constants/website_constants.dart';

/// Integration test to verify generic background service with stories
@singleton
class GenericBackgroundIntegrationTest {
  final GenericBackgroundService _genericService;

  GenericBackgroundIntegrationTest(this._genericService);

  /// Test the complete flow: stories API call using generic service
  Future<void> testStoriesIntegration() async {
    print('🧪 Starting Stories Integration Test...');

    try {
      // Test 1: Direct stories API call
      print('📱 Test 1: Direct stories API call');
      final storiesResult = await _genericService.executeStoriesCall(
        limit: '10',
        afterStoryId: '0',
      );

      _logResult('Stories API Call', storiesResult);

      // Test 2: Custom stories configuration
      print('📱 Test 2: Custom stories configuration');
      final customStoriesConfig = ApiConfigs.stories(
        afterStoryId: '0',
        limit: '5',
      );

      final customStoriesResult = await _genericService.executeApiCall(
        config: customStoriesConfig,
      );

      _logResult('Custom Stories Config', customStoriesResult);

      // Test 3: Newsfeed for comparison
      print('📱 Test 3: Newsfeed API call (for comparison)');
      final newsfeedResult = await _genericService.executeNewsfeedCall(
        limit: '5',
        afterPostId: '0',
      );

      _logResult('Newsfeed API Call', newsfeedResult);

      print('✅ Stories Integration Test completed successfully!');
    } catch (e) {
      print('💥 Stories Integration Test failed: $e');
    }
  }

  /// Test custom API configuration
  Future<void> testCustomApiConfiguration() async {
    print('🧪 Starting Custom API Configuration Test...');

    try {
      // Create a custom stories-like configuration
      final customConfig = GenericApiConfig(
        apiUrl: WebsiteConstants.getApiUrl(WebsiteConstants.storiesEndpoint),
        method: 'POST',
        headers: {'Custom-Header': 'Test-Value'},
        bodyFields: {
          'server_key': WebsiteConstants.serverKey,
          'type': 'get_stories',
          'limit': '3',
          'after_story_id': '0',
          'custom_param': 'test_value',
        },
        queryParams: {'test_query': 'test_value'},
        taskName: 'CustomStoriesTest',
        timeout: const Duration(seconds: 15),
      );

      final result = await _genericService.executeApiCall(
        config: customConfig,
      );

      _logResult('Custom API Configuration', result);

      print('✅ Custom API Configuration Test completed successfully!');
    } catch (e) {
      print('💥 Custom API Configuration Test failed: $e');
    }
  }

  /// Test error handling
  Future<void> testErrorHandling() async {
    print('🧪 Starting Error Handling Test...');

    try {
      // Test with invalid URL
      const invalidConfig = GenericApiConfig(
        apiUrl: 'https://invalid-url-that-does-not-exist.com/api/test',
        method: 'POST',
        bodyFields: {'test': 'value'},
        taskName: 'ErrorTest',
        timeout: const Duration(seconds: 5),
      );

      final result = await _genericService.executeApiCall(
        config: invalidConfig,
      );

      _logResult('Error Handling Test', result);

      print('✅ Error Handling Test completed successfully!');
    } catch (e) {
      print('💥 Error Handling Test failed: $e');
    }
  }

  /// Run all integration tests
  Future<void> runAllIntegrationTests() async {
    print('🚀 Starting Generic Background Service Integration Tests...');
    print('=' * 60);

    await testStoriesIntegration();
    print('-' * 40);

    await testCustomApiConfiguration();
    print('-' * 40);

    await testErrorHandling();
    print('-' * 40);

    print('🏁 All Integration Tests Completed!');
    print('=' * 60);
  }

  /// Helper method to log results consistently
  void _logResult(String testName, Map<String, dynamic> result) {
    print('📊 $testName Result:');
    print('  Success: ${result['success']}');
    print('  Error: ${result['error'] ?? 'None'}');
    print('  Data Length: ${result['data']?.length ?? 0}');
    print('  Timestamp: ${result['timestamp']}');

    if (result['success'] == true && result['data'] != null) {
      print('  ✅ API call successful');
    } else {
      print('  ❌ API call failed: ${result['error']}');
    }
    print('');
  }
}
