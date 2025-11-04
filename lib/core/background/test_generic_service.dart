import 'package:injectable/injectable.dart';
import 'generic_background_service.dart';
import 'generic_api_task.dart';
import '../constants/website_constants.dart';

/// Test class to verify generic background service functionality
@singleton
class TestGenericService {
  final GenericBackgroundService _genericService;

  TestGenericService(this._genericService);

  /// Test newsfeed API call
  Future<void> testNewsfeedCall() async {
    print('🧪 Testing generic newsfeed API call...');

    try {
      final result = await _genericService.executeNewsfeedCall(
        limit: '5',
        afterPostId: '0',
      );

      print('📊 Newsfeed test result: ${result['success']}');
      if (result['success'] == true) {
        print(
            '✅ Newsfeed test successful: ${result['data']?.length ?? 0} posts');
      } else {
        print('❌ Newsfeed test failed: ${result['error']}');
      }
    } catch (e) {
      print('💥 Newsfeed test exception: $e');
    }
  }

  /// Test stories API call
  Future<void> testStoriesCall() async {
    print('🧪 Testing generic stories API call...');

    try {
      final result = await _genericService.executeStoriesCall(
        limit: '5',
        afterStoryId: '0',
      );

      print('📊 Stories test result: ${result['success']}');
      if (result['success'] == true) {
        print(
            '✅ Stories test successful: ${result['data']?.length ?? 0} stories');
      } else {
        print('❌ Stories test failed: ${result['error']}');
      }
    } catch (e) {
      print('💥 Stories test exception: $e');
    }
  }

  /// Test custom API call
  Future<void> testCustomApiCall() async {
    print('🧪 Testing custom API call...');

    try {
      final result = await _genericService.executeCustomApiCall(
        apiUrl: WebsiteConstants.getApiUrl(WebsiteConstants.postsEndpoint),
        taskName: 'CustomTestTask',
        method: 'POST',
        bodyFields: {
          'server_key': WebsiteConstants.serverKey,
          'type': 'get_news_feed',
          'limit': '3',
          'after_post_id': '0',
        },
        timeout: const Duration(seconds: 15),
      );

      print('📊 Custom API test result: ${result['success']}');
      if (result['success'] == true) {
        print(
            '✅ Custom API test successful: ${result['data']?.length ?? 0} items');
      } else {
        print('❌ Custom API test failed: ${result['error']}');
      }
    } catch (e) {
      print('💥 Custom API test exception: $e');
    }
  }

  /// Run all tests
  Future<void> runAllTests() async {
    print('🚀 Starting generic background service tests...');

    await testNewsfeedCall();
    await Future.delayed(const Duration(seconds: 2));

    await testStoriesCall();
    await Future.delayed(const Duration(seconds: 2));

    await testCustomApiCall();

    print('🏁 All generic background service tests completed');
  }
}
