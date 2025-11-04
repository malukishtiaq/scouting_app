import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import '../../app_settings.dart';

abstract class BaseParams {
  final CancelToken? cancelToken;

  BaseParams({this.cancelToken});

  /// Convert params to map (must implement in child - already required)
  Map<String, dynamic> toMap();

  // ========== CACHE CONFIGURATION (AUTO-MAGIC) ==========

  /// Optional: Manually specify feature name
  /// If not provided, auto-detected from class name
  String? get featureName => null;

  /// Optional: Force disable cache for this request (e.g., force refresh)
  /// DEPRECATED: Use forceRefresh instead
  bool get disableCache => false;

  /// Force bypass cache and fetch fresh data from server
  /// Used for pull-to-refresh - fetches fresh but still caches the result
  /// If true: Skips cache read, fetches from server, saves fresh data to cache
  bool forceRefresh = false;

  /// Optional: Override TTL for this specific request
  int? get cacheTTLMinutes => null;

  // ========== CACHE INVALIDATION (MUTATIONS) ==========

  /// Is this a mutation operation? (create/update/delete)
  /// If true, automatically invalidates this feature's cache after success
  bool get isMutation => false;

  /// Which feature caches should be invalidated after this operation?
  /// Use for cross-feature invalidation (e.g., follow affects friends, following, followers)
  /// If null, no additional invalidation (only auto-invalidates own feature if isMutation=true)
  List<String>? get invalidateCaches => null;

  // ========== AUTO-DETECTION METHODS ==========

  /// Auto-detect feature name from class name
  /// Example: GetPostsParam → 'newsfeed'
  /// Example: GetUserProfileParam → 'profile'
  /// Example: CreateAlbumParam → 'albums'
  String get _autoFeatureName {
    if (featureName != null) return featureName!;

    // Extract feature from class name
    final className = runtimeType.toString();

    // Remove common prefixes/suffixes
    String feature = className
        .replaceAll('Param', '')
        .replaceAll('Get', '')
        .replaceAll('Create', '')
        .replaceAll('Update', '')
        .replaceAll('Delete', '')
        .replaceAll('Fetch', '')
        .replaceAll('Send', '')
        .replaceAll('Load', '')
        .toLowerCase();

    // Map common patterns to AppSettings feature names
    return _mapToAppSettingsFeature(feature);
  }

  /// Map extracted feature name to AppSettings feature keys
  String _mapToAppSettingsFeature(String feature) {
    // Define mapping rules to match AppSettings.cacheFeatures keys
    const featureMap = {
      // Newsfeed / Posts
      'posts': 'newsfeed',
      'post': 'newsfeed',
      'newsfeed': 'newsfeed',
      'timeline': 'newsfeed',
      'userposts': 'posts', // User profile posts (GetUserPostsParam)
      'userphotos': 'photos', // User profile photos (GetUserPhotosParam)
      // Profile / User
      'userprofile': 'profile',
      'profile': 'profile',
      'user': 'profile',
      'userdata': 'profile',
      // Stories
      'story': 'stories',
      'stories': 'stories',
      // Groups
      'group': 'groups',
      'groups': 'groups',
      // Pages
      'page': 'pages',
      'pages': 'pages',
      'mypages': 'pages',
      // Products / Marketplace
      'product': 'products',
      'products': 'products',
      'marketplace': 'products',
      // Comments
      'comment': 'comments',
      'comments': 'comments',
      // Notifications
      'notification': 'notifications',
      'notifications': 'notifications',
      // Messages / Chat
      'message': 'messages',
      'messages': 'messages',
      'chat': 'messages',
      'conversation': 'messages',
      // Live
      'live': 'live',
      'livestream': 'live',
      'stream': 'live',
      // Albums
      'album': 'albums',
      'albums': 'albums',
      // Jobs
      'job': 'jobs',
      'jobs': 'jobs',
      // Reels
      'reel': 'reels',
      'reels': 'reels',
      // Videos
      'video': 'videos',
      'videos': 'videos',
      'uservideos': 'videos',
      // Articles
      'article': 'articles',
      'articles': 'articles',
      // Friends / Following / Followers
      'friends': 'friends',
      'friend': 'friends',
      'following': 'following',
      'followers': 'followers',
      'follower': 'followers',
      'suggestions': 'suggestions',
      'usersuggestions': 'suggestions',
      'nearby': 'nearby',
      'nearbyusers': 'nearby',
    };

    return featureMap[feature] ?? feature;
  }

  /// Check if caching is enabled for this param
  bool get isCacheEnabled {
    if (disableCache) return false;
    return AppSettings.isCacheEnabled(_autoFeatureName);
  }

  /// Should we skip cache read and fetch fresh?
  /// True for pull-to-refresh scenarios
  bool get shouldBypassCache => forceRefresh;

  /// Get cache TTL duration
  Duration get cacheTTL {
    final minutes =
        cacheTTLMinutes ?? AppSettings.getCacheTTL(_autoFeatureName);
    return Duration(minutes: minutes);
  }

  /// Auto-generate cache key from all param values
  /// Creates a unique, stable key based on param content
  String get cacheKey {
    final params = toMap();

    // Remove server_key from cache key (it's always the same)
    params.remove('server_key');

    // Sort keys for consistent hashing
    final sortedKeys = params.keys.toList()..sort();

    // Create stable string representation
    final paramString =
        sortedKeys.map((key) => '$key=${params[key]}').join('&');

    // Create short hash for cleaner keys
    final hash =
        md5.convert(utf8.encode(paramString)).toString().substring(0, 8);

    return '${_autoFeatureName}_$hash';
  }

  /// Get feature name for cache (used by RemoteDataSource)
  String get cacheFeature => _autoFeatureName;
}
