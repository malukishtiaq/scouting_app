class WebsiteConstants {
  WebsiteConstants._();

  // ============================================================================
  // SCOUTING API CONFIGURATION (Primary API)
  // ============================================================================

  /// Scouting API base URL - Main API for the application
  static const String scoutingApiUrl = 'https://scouting.terveys.io';
  static const String scoutingWebsiteUrl = 'https://scouting.terveys.io';
  static const String scoutingApiEndpoint = 'https://scouting.terveys.io/api/';

  // DEFAULT URLs - Using Scouting API
  static String get websiteUrl => scoutingWebsiteUrl;
  static String get apiUrl => scoutingApiEndpoint;
  static String get adminUrl => scoutingWebsiteUrl;

  // ============================================================================
  // API CONFIGURATION - SERVER KEY
  // ============================================================================

  /// Server key for Scouting API (if needed in the future)
  /// Currently, the API does not require authentication
  static const String scoutingServerKey = '';

  // DEFAULT Server Key
  static String get serverKey => scoutingServerKey;

  // ============================================================================
  // USER CREDENTIALS (Not needed for Scouting API - public API)
  // ============================================================================

  // Scouting API does not require authentication

  // ============================================================================
  // URL HELPERS
  // ============================================================================

  /// Get full URL for API endpoint
  static String getApiUrl(String endpoint) {
    return '$apiUrl$endpoint';
  }

  /// Get full URL for website page
  static String getWebsiteUrl(String page) {
    return '$websiteUrl$page';
  }

  /// Get full URL for uploads
  static String getUploadUrl(String filePath) {
    return '$websiteUrl/uploads/$filePath';
  }

  /// Get full URL for post
  static String getPostUrl(String postId) {
    return '$websiteUrl/post/$postId';
  }

  /// Get full URL for terms
  static String getTermsUrl() {
    return '$websiteUrl/terms/terms';
  }

  // ============================================================================
  // COMMON ENDPOINTS
  // ============================================================================
  static const String loginEndpoint = 'login';
  static const String registerEndpoint = 'register';
  static const String postsEndpoint = 'posts';
  static const String storiesEndpoint = 'stories';
  static const String chatListEndpoint = 'get-chats';
  static const String messagesEndpoint = 'get-messages';
  static const String sendMessageEndpoint = 'send-message';
  static const String getUserStoriesEndpoint = 'get-user-stories';
}
