import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/website_constants.dart';
import '../constants/shared_preference/shared_preference_keys.dart';

/// Service to manage account-related data
/// Simplified for Scouting API (no account switching needed)
class AccountService {
  static final AccountService _instance = AccountService._internal();
  factory AccountService() => _instance;
  AccountService._internal();

  /// Get the current account type (always 'scouting' for Scouting API)
  String get currentAccountType => 'scouting';

  /// Initialize the service
  Future<void> initialize() async {
    if (kDebugMode) {
      print('🔧 AccountService: Initialized for Scouting API');
      print('📍 API URL: ${WebsiteConstants.apiUrl}');
      print('🌐 Website URL: ${WebsiteConstants.websiteUrl}');
    }
  }

  /// Get server key (empty for Scouting API - no authentication required)
  String getCurrentServerKey() {
    return WebsiteConstants.serverKey;
  }

  /// Clear saved data (for logout)
  Future<void> clearAccountType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(SharedPreferenceKeys.KEY_ACCOUNT_TYPE);
      await prefs.remove(SharedPreferenceKeys.KEY_SERVER_KEY);
      await prefs.remove(SharedPreferenceKeys.KEY_WEBSITE_URL);

      if (kDebugMode) {
        print('✅ AccountService: Account data cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error clearing account data: $e');
      }
    }
  }
}
