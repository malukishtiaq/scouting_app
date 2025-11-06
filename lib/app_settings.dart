import 'core/services/account_service.dart';

class AppSettings {
  // ===== CUSTOMER DEMO FEATURE FLAGS =====

  /// Control which features are visible in customer demos
  /// Set to true to show feature, false to hide
  static const Map<String, bool> demoFeatures = {
    'newsfeed': true, // ✅ Demo 1: News feed
    'signup': false, // ❌ Demo 2: Authentication
    'profile': false, // ❌ Demo 3: User profile
    'settings': false, // ❌ Demo 4: Settings
    'chat': false, // ❌ Demo 5: Messaging
    'groups': false, // ❌ Demo 6: Groups
    'pages': false, // ❌ Demo 7: Pages
    'marketplace': false, // ❌ Demo 8: Marketplace
    'reels': false, // ❌ Demo 9: Reels
    'stories': false, // ❌ Demo 10: Stories
  };

  // ===== NOTIFICATION CONFIGURATION =====

  /// Enable/disable push notifications (matches Xamarin ShowNotification)
  static const bool showNotification = true;

  // ===== ONESIGNAL CONFIGURATION =====

  // Talk Kro OneSignal Credentials (com.talkkro.inc)
  static const String talkkroOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a';
  static const String talkkroOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y';

  // My Account OneSignal Credentials (placeholder - will be updated when you provide)
  static const String myOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a'; // TODO: Update with actual My Account OneSignal App ID
  static const String myOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y'; // TODO: Update with actual My Account REST API Key

  // Friendzone OneSignal Credentials (placeholder - will be updated when you provide)
  static const String friendzoneOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a'; // TODO: Update with actual Friendzone OneSignal App ID
  static const String friendzoneOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y'; // TODO: Update with actual Friendzone REST API Key

  // Handshakes4u OneSignal Credentials (placeholder - will be updated when you provide)
  static const String handshakes4uOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a'; // TODO: Update with actual Handshakes4u OneSignal App ID
  static const String handshakes4uOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y'; // TODO: Update with actual Handshakes4u REST API Key

  // Demo OneSignal Credentials (placeholder - will be updated when you provide)
  static const String demoOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a'; // TODO: Update with actual Demo OneSignal App ID
  static const String demoOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y'; // TODO: Update with actual Demo REST API Key

  // Admin OneSignal Credentials (same as My Account)
  static const String adminOnesignalAppId = myOnesignalAppId;
  static const String adminOnesignalRestApiKey = myOnesignalRestApiKey;

  // Regular OneSignal Credentials (same as My Account)
  static const String regularOnesignalAppId = myOnesignalAppId;
  static const String regularOnesignalRestApiKey = myOnesignalRestApiKey;

  // Bhulok OneSignal Credentials (placeholder - will be updated when you provide)
  static const String bhulokOnesignalAppId =
      '9eb184cb-9c24-4a06-bb06-60a20536e18a'; // TODO: Update with actual Bhulok OneSignal App ID
  static const String bhulokOnesignalRestApiKey =
      'os_v2_app_t2yyjs44erfanoygmcraknxbrkyj2gvervpujnndl6wuxb643jc7y2lxzutj7psepqxj54q64zxkb4jtmawecw6ogmb7zbbqwscl56y'; // TODO: Update with actual Bhulok REST API Key

  /// Get OneSignal App ID based on current account type
  static String get onesignalAppId {
    final accountType = _getCurrentAccountType();
    return getOnesignalAppIdByAccount(accountType);
  }

  /// Get OneSignal REST API Key based on current account type
  static String get onesignalRestApiKey {
    final accountType = _getCurrentAccountType();
    return getOnesignalRestApiKeyByAccount(accountType);
  }

  /// Get current account type (helper method)
  static String _getCurrentAccountType() {
    try {
      return AccountService().currentAccountType;
    } catch (e) {
      return 'talkkro'; // Fallback to talkkro
    }
  }

  /// Get OneSignal App ID by account type (follows same pattern as WebsiteConstants)
  static String getOnesignalAppIdByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneOnesignalAppId;
      case 'handshakes4u':
        return handshakes4uOnesignalAppId;
      case 'demo':
        return demoOnesignalAppId;
      case 'admin':
        return adminOnesignalAppId;
      case 'regular':
        return regularOnesignalAppId;
      case 'bhulok':
        return bhulokOnesignalAppId;
      case 'talkkro':
        return talkkroOnesignalAppId;
      case 'my':
      default:
        return myOnesignalAppId;
    }
  }

  /// Get OneSignal REST API Key by account type (follows same pattern as WebsiteConstants)
  static String getOnesignalRestApiKeyByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneOnesignalRestApiKey;
      case 'handshakes4u':
        return handshakes4uOnesignalRestApiKey;
      case 'demo':
        return demoOnesignalRestApiKey;
      case 'admin':
        return adminOnesignalRestApiKey;
      case 'regular':
        return regularOnesignalRestApiKey;
      case 'bhulok':
        return bhulokOnesignalRestApiKey;
      case 'talkkro':
        return talkkroOnesignalRestApiKey;
      case 'my':
      default:
        return myOnesignalRestApiKey;
    }
  }

  // ===== FIREBASE CONFIGURATION =====

  // Talk Kro Firebase Configuration (com.talkkro.inc)
  static const String talkkroFirebaseProjectId = 'talk-kro';
  static const String talkkroFirebaseProjectNumber = '766880133838';
  static const String talkkroFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598';
  static const String talkkroFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f';
  static const String talkkroFirebaseStorageBucket =
      'talk-kro.firebasestorage.app';

  // My Account Firebase Configuration (placeholder - will be updated when you provide)
  static const String myFirebaseProjectId =
      'talk-kro'; // TODO: Update with actual My Account Firebase Project ID
  static const String myFirebaseProjectNumber =
      '766880133838'; // TODO: Update with actual My Account Project Number
  static const String myFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598'; // TODO: Update with actual My Account API Key
  static const String myFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f'; // TODO: Update with actual My Account App ID
  static const String myFirebaseStorageBucket =
      'talk-kro.firebasestorage.app'; // TODO: Update with actual My Account Storage Bucket

  // Friendzone Firebase Configuration (placeholder - will be updated when you provide)
  static const String friendzoneFirebaseProjectId =
      'talk-kro'; // TODO: Update with actual Friendzone Firebase Project ID
  static const String friendzoneFirebaseProjectNumber =
      '766880133838'; // TODO: Update with actual Friendzone Project Number
  static const String friendzoneFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598'; // TODO: Update with actual Friendzone API Key
  static const String friendzoneFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f'; // TODO: Update with actual Friendzone App ID
  static const String friendzoneFirebaseStorageBucket =
      'talk-kro.firebasestorage.app'; // TODO: Update with actual Friendzone Storage Bucket

  // Handshakes4u Firebase Configuration (placeholder - will be updated when you provide)
  static const String handshakes4uFirebaseProjectId =
      'talk-kro'; // TODO: Update with actual Handshakes4u Firebase Project ID
  static const String handshakes4uFirebaseProjectNumber =
      '766880133838'; // TODO: Update with actual Handshakes4u Project Number
  static const String handshakes4uFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598'; // TODO: Update with actual Handshakes4u API Key
  static const String handshakes4uFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f'; // TODO: Update with actual Handshakes4u App ID
  static const String handshakes4uFirebaseStorageBucket =
      'talk-kro.firebasestorage.app'; // TODO: Update with actual Handshakes4u Storage Bucket

  // Demo Firebase Configuration (placeholder - will be updated when you provide)
  static const String demoFirebaseProjectId =
      'talk-kro'; // TODO: Update with actual Demo Firebase Project ID
  static const String demoFirebaseProjectNumber =
      '766880133838'; // TODO: Update with actual Demo Project Number
  static const String demoFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598'; // TODO: Update with actual Demo API Key
  static const String demoFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f'; // TODO: Update with actual Demo App ID
  static const String demoFirebaseStorageBucket =
      'talk-kro.firebasestorage.app'; // TODO: Update with actual Demo Storage Bucket

  // Admin Firebase Configuration (same as My Account)
  static const String adminFirebaseProjectId = myFirebaseProjectId;
  static const String adminFirebaseProjectNumber = myFirebaseProjectNumber;
  static const String adminFirebaseApiKey = myFirebaseApiKey;
  static const String adminFirebaseAppId = myFirebaseAppId;
  static const String adminFirebaseStorageBucket = myFirebaseStorageBucket;

  // Regular Firebase Configuration (same as My Account)
  static const String regularFirebaseProjectId = myFirebaseProjectId;
  static const String regularFirebaseProjectNumber = myFirebaseProjectNumber;
  static const String regularFirebaseApiKey = myFirebaseApiKey;
  static const String regularFirebaseAppId = myFirebaseAppId;
  static const String regularFirebaseStorageBucket = myFirebaseStorageBucket;

  // Bhulok Firebase Configuration (placeholder - will be updated when you provide)
  static const String bhulokFirebaseProjectId =
      'talk-kro'; // TODO: Update with actual Bhulok Firebase Project ID
  static const String bhulokFirebaseProjectNumber =
      '766880133838'; // TODO: Update with actual Bhulok Project Number
  static const String bhulokFirebaseApiKey =
      'AIzaSyDnisvUZal29Gi5mBDEhntBciyCZI8S598'; // TODO: Update with actual Bhulok API Key
  static const String bhulokFirebaseAppId =
      '1:766880133838:android:e90a4d4e6dc130a1ff169f'; // TODO: Update with actual Bhulok App ID
  static const String bhulokFirebaseStorageBucket =
      'talk-kro.firebasestorage.app'; // TODO: Update with actual Bhulok Storage Bucket

  /// Get Firebase Project ID based on current account type
  static String get firebaseProjectId {
    final accountType = _getCurrentAccountType();
    return getFirebaseProjectIdByAccount(accountType);
  }

  /// Get Firebase Project Number based on current account type
  static String get firebaseProjectNumber {
    final accountType = _getCurrentAccountType();
    return getFirebaseProjectNumberByAccount(accountType);
  }

  /// Get Firebase API Key based on current account type
  static String get firebaseApiKey {
    final accountType = _getCurrentAccountType();
    return getFirebaseApiKeyByAccount(accountType);
  }

  /// Get Firebase App ID based on current account type
  static String get firebaseAppId {
    final accountType = _getCurrentAccountType();
    return getFirebaseAppIdByAccount(accountType);
  }

  /// Get Firebase Storage Bucket based on current account type
  static String get firebaseStorageBucket {
    final accountType = _getCurrentAccountType();
    return getFirebaseStorageBucketByAccount(accountType);
  }

  /// Get Firebase Project ID by account type (follows same pattern as WebsiteConstants)
  static String getFirebaseProjectIdByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneFirebaseProjectId;
      case 'handshakes4u':
        return handshakes4uFirebaseProjectId;
      case 'demo':
        return demoFirebaseProjectId;
      case 'admin':
        return adminFirebaseProjectId;
      case 'regular':
        return regularFirebaseProjectId;
      case 'bhulok':
        return bhulokFirebaseProjectId;
      case 'talkkro':
        return talkkroFirebaseProjectId;
      case 'my':
      default:
        return myFirebaseProjectId;
    }
  }

  /// Get Firebase Project Number by account type
  static String getFirebaseProjectNumberByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneFirebaseProjectNumber;
      case 'handshakes4u':
        return handshakes4uFirebaseProjectNumber;
      case 'demo':
        return demoFirebaseProjectNumber;
      case 'admin':
        return adminFirebaseProjectNumber;
      case 'regular':
        return regularFirebaseProjectNumber;
      case 'bhulok':
        return bhulokFirebaseProjectNumber;
      case 'talkkro':
        return talkkroFirebaseProjectNumber;
      case 'my':
      default:
        return myFirebaseProjectNumber;
    }
  }

  /// Get Firebase API Key by account type
  static String getFirebaseApiKeyByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneFirebaseApiKey;
      case 'handshakes4u':
        return handshakes4uFirebaseApiKey;
      case 'demo':
        return demoFirebaseApiKey;
      case 'admin':
        return adminFirebaseApiKey;
      case 'regular':
        return regularFirebaseApiKey;
      case 'bhulok':
        return bhulokFirebaseApiKey;
      case 'talkkro':
        return talkkroFirebaseApiKey;
      case 'my':
      default:
        return myFirebaseApiKey;
    }
  }

  /// Get Firebase App ID by account type
  static String getFirebaseAppIdByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneFirebaseAppId;
      case 'handshakes4u':
        return handshakes4uFirebaseAppId;
      case 'demo':
        return demoFirebaseAppId;
      case 'admin':
        return adminFirebaseAppId;
      case 'regular':
        return regularFirebaseAppId;
      case 'bhulok':
        return bhulokFirebaseAppId;
      case 'talkkro':
        return talkkroFirebaseAppId;
      case 'my':
      default:
        return myFirebaseAppId;
    }
  }

  /// Get Firebase Storage Bucket by account type
  static String getFirebaseStorageBucketByAccount(String accountType) {
    switch (accountType) {
      case 'friendzone':
        return friendzoneFirebaseStorageBucket;
      case 'handshakes4u':
        return handshakes4uFirebaseStorageBucket;
      case 'demo':
        return demoFirebaseStorageBucket;
      case 'admin':
        return adminFirebaseStorageBucket;
      case 'regular':
        return regularFirebaseStorageBucket;
      case 'bhulok':
        return bhulokFirebaseStorageBucket;
      case 'talkkro':
        return talkkroFirebaseStorageBucket;
      case 'my':
      default:
        return myFirebaseStorageBucket;
    }
  }

  // ===== CACHE CONFIGURATION =====

  /// Master cache toggle - disables ALL caching if false
  static const bool enableCaching = true; // ✅ ENABLED for videos

  /// Feature-specific cache toggles (enable/disable per feature)
  /// Set to true to enable caching for that feature
  /// ⚠️ LOW-MEMORY MODE: Most caches DISABLED to prevent NO_MEMORY errors
  static const Map<String, bool> cacheFeatures = {
    'newsfeed': false, // Posts/timeline
    'profile': false, // User profiles
    'stories': false, // Stories
    'groups': false, // Groups list - ❌ DISABLED (low memory)
    'pages': false, // Pages list - ❌ DISABLED (low memory)
    'products': false, // Marketplace products - ❌ DISABLED (low memory)
    'albums': false, // Albums
    'jobs': false, // Jobs
    'reels': false, // Reels
    'videos':
        false, // Videos - ❌ DISABLED (low memory, video controllers handle this)
    'articles': false, // Articles - ❌ DISABLED (low memory)
    'following': false, // Following list - ❌ DISABLED (low memory)
    'followers': false, // Followers list - ❌ DISABLED (low memory)
    'friends': false, // Friends list - ❌ DISABLED (low memory)
    'suggestions': false, // User suggestions - ❌ DISABLED (low memory)
    'nearby': false, // Nearby users - ❌ DISABLED (low memory)
    'comments': false, // Comments (too dynamic)
    'notifications': false, // Notifications - ❌ DISABLED (low memory)
    'activities': false, // Last activities - ❌ DISABLED (low memory)
    'birthdays': false, // Friends birthday - ❌ DISABLED (low memory)
    'messages': false, // Messages/Chat (real-time)
    'live': false, // Live streams (real-time)
    'funding': true, // Funding campaigns - ✅ ENABLED (semi-static)
    // Trending feature caches - ❌ DISABLED (low memory)
    'trending': false, // General trending data
    'general_data': false, // Trending hashtags, pro users, promoted pages
    'my_groups': false, // User groups for shortcuts
    'my_pages': false, // User pages for shortcuts
    'weather': false, // Weather widget
    'exchange_currency': false, // Exchange currency widget
    // User profile data caches - ❌ DISABLED (low memory)
    'posts': false, // User posts - ❌ DISABLED (low memory)
    'photos': false, // User photos - ❌ DISABLED (low memory)
  };

  /// Cache TTL (Time To Live) per feature in minutes
  /// How long cached data stays valid before refreshing
  static const Map<String, int> cacheTTL = {
    'newsfeed': 30, // 30 minutes
    'profile': 60, // 1 hour
    'stories': 15, // 15 minutes
    'groups': 120, // 2 hours
    'pages': 120, // 2 hours
    'products': 15, // 15 minutes
    'albums': 60, // 1 hour
    'jobs': 120, // 2 hours
    'reels': 30, // 30 minutes
    'videos': 60, // 1 hour
    'articles': 15, // 15 minutes - Updated for trending feature
    'following': 30, // 30 minutes
    'followers': 30, // 30 minutes
    'friends': 30, // 30 minutes
    'suggestions': 60, // 1 hour - suggestions don't change often
    'nearby': 15, // 15 minutes - location-based, refresh more often
    'notifications': 15, // 15 minutes - notification lists cache
    'activities': 15, // 15 minutes - last activities cache
    'birthdays': 15, // 15 minutes - friends birthday cache
    'funding': 60, // 60 minutes - funding campaigns cache
    // Trending feature TTLs - ALL set to 15 minutes as requested
    'trending': 15, // 15 minutes
    'general_data': 15, // 15 minutes - hashtags, pro users, promoted pages
    'my_groups': 15, // 15 minutes - user groups for shortcuts
    'my_pages': 15, // 15 minutes - user pages for shortcuts
    'weather': 15, // 15 minutes - weather data
    'exchange_currency': 15, // 15 minutes - currency rates
    // User profile data caches
    'posts':
        30, // 30 minutes - user posts don't change very often (GetUserPostsParam)
    'photos':
        60, // 60 minutes - user photos change even less often (GetUserPhotosParam)
  };

  /// Check if caching is enabled for a feature
  static bool isCacheEnabled(String feature) {
    if (!enableCaching) return false;
    return cacheFeatures[feature] ?? false;
  }

  /// Get cache TTL for a feature (in minutes)
  static int getCacheTTL(String feature) {
    return cacheTTL[feature] ?? 30; // Default 30 minutes
  }

  // ===== ADS CONFIGURATION =====

  // Global ads toggle
  static const bool showAds = false;

  // Provider-level toggles
  static const bool showGoogleBannerAds = false; // Disabled - already tested
  static const bool showGoogleInterstitialAds =
      true; // Keep enabled - needs testing
  static const bool showGoogleRewardedAds =
      true; // Keep enabled - needs testing
  static const bool showGoogleNativeAds = false; // Disabled - already tested
  static const bool showGoogleAppOpenAds = false; // Disabled - already tested

  static const bool showFbBannerAds = false;
  static const bool showAppLovinBannerAds = false;

  // Type-level gates
  static const bool showBannerAds = false;
  static const bool showInterstitialAds = false;
  static const bool showRewardedAds = false;
  static const bool showNativeAds = false;

  // AdMob specific toggles (mirroring Xamarin AppSettings.cs)
  static const bool showAdMobBanner = false; // Disabled - already tested
  static const bool showAdMobInterstitial =
      true; // Keep enabled - needs testing
  static const bool showAdMobRewardVideo =
      false; // Keep enabled - needs testing
  static const bool showAdMobNative = false; // Disabled - already tested
  static const bool showAdMobAppOpen = false; // Disabled - already tested
  static const bool showAdMobRewardedInterstitial =
      false; // Keep enabled - needs testing

  // Socket Configuration (mirroring Xamarin AppSettings.cs)
  static const SocketConnectionType connectionType = SocketConnectionType
      .socket; // Socket server is working - use real-time connection
  static const String socketPort =
      "449"; // HTTPS socket port for SSL connections

  // Live Streaming Configuration (mirroring Xamarin AppSettings.cs)
  static const bool showLive = true;
  static const String agoraAppIdLive = "87cf340b152e4dd886e4be75f236ef04";

  // Agora App Certificate (from site settings API)
  // Retrieved from demo.wowonder.com site settings: agora_chat_app_certificate
  static String agoraAppCertificate =
      "d80ed7a542f04887a86b80d9190df060"; // Updated with new certificate

  // Other existing settings
  static const bool isDarkMode = false;
  static const bool isRightToLeft = false;
  static const bool showDeleteData = false;
  static const bool showDeleteAccount = false;
  static const bool showMemoryManagement = false;
  static const bool showInAppPurchase = false;
  static const bool showSubscription = false;
  static const bool showGift = false;
}

/// Socket connection type options
enum SocketConnectionType {
  /// Use Socket.IO for real-time communication
  socket,

  /// Use REST API for communication
  restApi,
}
