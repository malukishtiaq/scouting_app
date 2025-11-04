import 'package:flutter/services.dart';
import 'package:scouting_app/core/providers/session_data.dart';
import 'package:scouting_app/core/constants/website_constants.dart';
import 'package:scouting_app/di/service_locator.dart';

/// Deep Link Handler - Handles referral links and other deep links like Xamarin
class DeepLinkHandler {
  static const MethodChannel _channel = MethodChannel('deep_link_handler');

  // Store deep link data for later use (like Xamarin Intent data)
  static String? _pendingReferralCode;
  static String? _pendingResetCode;
  static String? _pendingActivationEmail;
  static String? _pendingActivationCode;
  static String? _pendingPostId;
  static String? _pendingFundId;

  /// Initialize deep link handling
  static Future<void> initialize() async {
    print('🔗 DeepLinkHandler: Initializing...');

    try {
      // Handle initial link (app was terminated)
      final initialLink = await _channel.invokeMethod('getInitialLink');
      print('🔗 DeepLinkHandler: Initial link: $initialLink');
      if (initialLink != null) {
        _processDeepLink(initialLink);
      }

      // Handle incoming links (app was running)
      _channel.setMethodCallHandler((call) async {
        print('🔗 DeepLinkHandler: Method call received: ${call.method}');
        if (call.method == 'onDeepLink') {
          print(
              '🔗 DeepLinkHandler: Processing incoming deep link: ${call.arguments}');
          _processDeepLink(call.arguments);
        }
      });

      print('🔗 DeepLinkHandler: Initialization complete');
    } catch (e) {
      print('🔗 DeepLinkHandler: Initialization error: $e');
    }
  }

  /// Process deep link and store data (like Xamarin Intent data storage)
  static void _processDeepLink(String url) {
    try {
      print('🔗 Deep link received: $url');

      // Parse URL like Xamarin
      final uri = Uri.parse(url);
      print(
          '🔗 Parsed URI - Host: ${uri.host}, Path: ${uri.path}, Query: ${uri.queryParameters}');

      // Check if it's a referral link like Xamarin
      if (uri.path.contains('register') &&
          uri.queryParameters.containsKey('ref')) {
        final referralCode = uri.queryParameters['ref'] ?? '';
        print('✅ Referral code detected: $referralCode');
        _pendingReferralCode = referralCode;
        return;
      }

      // Handle other deep links like Xamarin
      if (uri.path.contains('index.php?link1=reset-password')) {
        final code = uri.queryParameters['code'] ?? '';
        print('Reset password code: $code');
        _pendingResetCode = code;
        return;
      }

      if (uri.path.contains('index.php?link1=activate')) {
        final email = uri.queryParameters['email'] ?? '';
        final code = uri.queryParameters['code'] ?? '';
        print('Activation email: $email, code: $code');
        _pendingActivationEmail = email;
        _pendingActivationCode = code;
        return;
      }

      if (uri.path.contains('post/') && _isUserLoggedIn()) {
        final postId = uri.path.split('/').last.split('_').first;
        print('Post ID: $postId');
        _pendingPostId = postId;
        return;
      }

      if (uri.path.contains('show_fund/') && _isUserLoggedIn()) {
        final fundId = uri.path.split('/').last;
        print('Fund ID: $fundId');
        _pendingFundId = fundId;
        return;
      }
    } catch (e) {
      print('Error processing deep link: $e');
    }
  }

  /// Get pending referral code and clear it (like Xamarin Intent.GetStringExtra)
  static String? getPendingReferralCode() {
    final code = _pendingReferralCode;
    _pendingReferralCode = null; // Clear after use
    return code;
  }

  /// Set referral code manually (for testing or manual entry)
  static void setReferralCode(String code) {
    print('🔗 DeepLinkHandler: Manually setting referral code: $code');
    _pendingReferralCode = code;
  }

  /// Get pending reset code and clear it
  static String? getPendingResetCode() {
    final code = _pendingResetCode;
    _pendingResetCode = null;
    return code;
  }

  /// Get pending activation data and clear it
  static Map<String, String?> getPendingActivationData() {
    final email = _pendingActivationEmail;
    final code = _pendingActivationCode;
    _pendingActivationEmail = null;
    _pendingActivationCode = null;
    return {'email': email, 'code': code};
  }

  /// Get pending post ID and clear it
  static String? getPendingPostId() {
    final postId = _pendingPostId;
    _pendingPostId = null;
    return postId;
  }

  /// Get pending fund ID and clear it
  static String? getPendingFundId() {
    final fundId = _pendingFundId;
    _pendingFundId = null;
    return fundId;
  }

  /// Check if user is logged in like Xamarin UserDetails.AccessToken
  static bool _isUserLoggedIn() {
    try {
      final sessionData = getIt<SessionData>();
      return sessionData.token != null &&
          sessionData.token!.isNotEmpty &&
          sessionData.userId != null;
    } catch (e) {
      return false;
    }
  }

  /// Handle referral link generation (for sharing)
  static String generateReferralLink(String username) {
    // Use dynamic website URL based on current account type
    // Like Xamarin: https://demo.wowonder.com/register?ref=waelanjo
    final websiteUrl = WebsiteConstants.websiteUrl;
    final referralLink = '$websiteUrl/register?ref=$username';
    print('🔗 DeepLinkHandler generated referral link: $referralLink');
    return referralLink;
  }

  /// Test deep link processing (for debugging)
  static void testDeepLink(String testUrl) {
    print('🧪 Testing deep link: $testUrl');
    _processDeepLink(testUrl);
  }

  /// Test referral link generation and processing
  static void testReferralLink() {
    final testUrl = 'https://baadbaan.host/register?ref=testuser123';
    print('🧪 Testing referral link: $testUrl');
    _processDeepLink(testUrl);
  }
}
