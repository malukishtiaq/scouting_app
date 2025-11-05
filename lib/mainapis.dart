// dotenv removed for boot

import '../core/constants/website_constants.dart';

class MainAPIS {
  MainAPIS._();

  // Use centralized website constants
  static String get websiteUrl {
    final url = WebsiteConstants.apiUrl;
    print('🌐 MainAPIS: Using website URL: $url');
    return url;
  }

  static String get serverKey {
    final key = WebsiteConstants.serverKey;
    return key;
  }

  static String getCoverImage(String mediaContentUrl) {
    if (mediaContentUrl.isNotEmpty) {
      final url = mediaContentUrl
          .replaceAll(r'\\', r'\')
          .replaceAll('endpoint/v1/', '');

      // If URL doesn't start with http/https and doesn't contain website URL, prepend it
      if (!url.startsWith('http') && !url.contains(websiteUrl)) {
        return '$websiteUrl$url'.replaceAll('endpoint/v1/', '');
      }

      return url;
    }
    return '';
  }

  // WoWonder API endpoints (path-only; base URL and tokens handled by network layer)
  // Auth & Account
  static const String apiAuth = "auth";
  static const String apiSocialLogin = "social-login";
  static const String apiCreateAccount = "create-account";
  static const String apiSendResetPasswordEmail = "send-reset-password-email";
  static const String apiResetPassword = "reset_password";
  static const String apiValidationUser = "validation_user";
  static const String apiActiveAccountSms = "active_account_sms";
  static const String apiDeleteAccessToken = "delete-access-token";
  static const String apiDeleteUser = "delete-user";

  // Users & Profiles
  static const String apiGetUserData = "get-user-data";
  static const String apiGetManyUsersData = "get-many-users-data";
  static const String apiGetUserAlbums = "get-user-albums";
  static const String apiCreateAlbum = "create-album";
  static const String apiDeleteAlbum = "delete-album";

  // Images & Videos
  static const String apiGetUserImages = "get-user-images";
  static const String apiUploadImage = "upload-image";
  static const String apiDeleteImage = "delete-image";
  static const String apiGetUserVideos = "get-user-videos";
  static const String apiUploadVideo = "upload-video";
  static const String apiDeleteVideo = "delete-video";
  static const String apiUpdateUserData = "update-user-data";
  static const String apiGetUserSuggestions = "get-user-suggestions";
  static const String apiGetFriends = "get-friends";
  static const String apiGetFriendsBirthday = "get_friends_birthday";
  static const String apiGetUserDataByUsername = "get-user-data-username";
  static const String apiReportUser = "report_user";
  static const String apiResetAvatar = "reset_avatar";
  static const String apiVerification = "verification";

  // Follow / Block
  static const String apiFollowUser = "follow-user";
  static const String apiFollowRequestAction = "follow-request-action";
  static const String apiBlockUser = "block-user";
  static const String apiGetNearbyUsers = "get-nearby-users";
  static const String apiGetBlockedUsers = "get-blocked-users";

  // Pokes
  static const String apiGetPokes = "get-pokes";
  static const String apiCreatePoke = "create-poke";
  static const String apiRemovePoke = "remove-poke";

  // Notifications
  static const String apiGetGeneralData = "get-general-data";
  static const String apiReadActivities = "get-activities";
  static const String apiGetInvites = "get-invites";

  // Stories
  static const String apiCreateStory = "create-story";
  static const String apiDeleteStory = "delete-story";
  static const String apiGetStories = "get-stories";
  static const String apiGetUserStories = "get-user-stories";
  static const String apiGetStoryById = "get_story_by_id";
  static const String apiGetStoryViews = "get_story_views";
  static const String apiReactStory = "react_story";

  // Video Sharing
  static const String apiCreateReel = "create-reel";
  static const String apiShareToPage = "share-to-page";
  static const String apiShareToGroup = "share-to-group";
  static const String apiShareToUser = "share-to-user";
  static const String apiGenerateVideoThumbnail = "generate-video-thumbnail";
  static const String apiGetVideoStatus = "get-video-status";

  // Posts / Reactions
  static const String apiPostActions = "post-actions";
  static const String apiNewPost = "new_post";
  static const String apiGetPost = "posts";
  static const String apiGetPostData = "get-post-data";
  static const String apiGetPopularPost = "most_liked";
  static const String apiGetPostComments = "comments";
  static const String apiHidePost = "hide_post";
  static const String apiGetReactions = "get-reactions";

  // Pages
  static const String apiLikePage = "like-page";
  static const String apiCreatePage = "create-page";
  static const String apiGetPageData = "get-page-data";
  static const String apiPageReviews = "page_reviews";
  static const String apiPageVerification = "page_verification";
  static const String apiMakePageAdmin = "make_page_admin";
  static const String apiDeletePage = "delete_page";
  static const String apiPageAdd = "page_add";
  static const String apiGetMyPages = "get-my-pages";
  static const String apiReportPage = "report_page";

  // Groups
  static const String apiJoinGroup = "join-group";
  static const String apiCreateGroup = "create-group";
  static const String apiGetGroupData = "get-group-data";
  static const String apiGetGroups = "get-my-groups";
  static const String apiGroupChat = "group_chat";
  static const String apiGetGroupMembers = "get_group_members";
  static const String apiMakeGroupAdmin = "make_group_admin";
  static const String apiRemoveGroupMember = "delete_group_member";
  static const String apiGetNotInGroupMembers = "not_in_group_member";
  static const String apiDeleteGroup = "delete_group";
  static const String apiGroupAdd = "group_add";
  static const String apiReportGroup = "report_group";

  // Chat & Messaging
  static const String apiSendMessage = "send-message";
  static const String apiDeleteConversation = "delete-conversation";
  static const String apiGetChats = "get_chats";
  static const String apiSetChatTypingStatus = "set-chat-typing-status";
  static const String apiChangeChatColor = "change-chat-color";
  static const String apiDeleteMessage = "delete_message";
  static const String apiMuteChatsInfo = "mute";
  static const String apiGetArchivedChats = "get_archived_chats";
  static const String apiGetPinChats = "get_pin_chats";
  static const String apiGetPinMessage = "get_pin_message";
  static const String apiPinMessage = "pin_message";
  static const String apiReactMessage = "react_message";
  static const String apiReadChats = "read_chats";
  static const String apiFavoriteMessage = "fav_message";
  static const String apiGetFavoriteMessages = "get_fav_messages";
  static const String apiForwardMessage = "forward_message";
  static const String apiListeningMessage = "listening";
  static const String apiCheckTypeUrl = "check_type";
  static const String apiGetUserMessages = "get_user_messages";

  // Events
  static const String apiGetEvents = "get-events";
  static const String apiGoToEvent = "go-to-event";
  static const String apiInterestEvent = "interest-event";
  static const String apiCreateEvent = "create-event";
  static const String apiGetEventById = "get_event_by_id";

  // Community / General
  static const String apiGetCommunity = "get-community";
  static const String apiIsActive = "is-active";
  static const String apiGetSiteSettings = "get-site-settings";

  // Search & Discover
  static const String apiSearch = "search";
  static const String apiSearchForPosts = "search_for_posts";
  static const String apiNearby = "nearby";
  static const String apiFetchRecommended = "fetch-recommended";

  // Stories/Articles/Blogs/Movies
  static const String apiGetArticles = "get-articles";
  static const String apiGetBlogById = "get-blog-by-id";
  static const String apiBlogs = "blogs";
  static const String apiMoviesComments = "movies_comments";
  static const String apiGetMovies = "get-movies";

  // Market & Products
  static const String apiCreateProduct = "create-product";
  static const String apiEditProduct = "edit-product";
  static const String apiGetProducts = "get-products";
  static const String apiMarket = "market";
  static const String address = "address";

  // Wallet & Payments
  static const String apiWallet = "wallet";
  static const String apiGooglePay = "google_pay";
  static const String apiStripe = "stripe";
  static const String apiRazorPay = "razorpay";
  static const String apiPayStack = "paystack";
  static const String apiCashFree = "cashfree";
  static const String apiPaysera = "paysera";
  static const String apiSecurionPay = "securionpay";
  static const String apiIyziPay = "iyzipay";
  static const String apiAuthorizeNet = "authorize";
  static const String apiFlutteWave = "fluttewave";
  static const String apiAamarPay = "aamarpay";
  static const String apiYooMoney = "yoomoney";
  static const String apiUpgrade = "upgrade";

  // Live
  static const String apiLive = "live";
  static const String apiGetLiveFriends = "get_live_friends";

  // Jobs
  static const String apiJob = "job";

  // Ads & Boost
  static const String apiAds = "ads";
  static const String apiGetBoost = "get_boost";
  static const String apiBoostPage = "boost_page";
  static const String apiAdMob = "admob";

  // Invitations & Activities & Offers
  static const String apiInvitation = "invitation";
  static const String apiMyActivities = "my_activities";
  static const String apiOffers = "offer";
  static const String apiWithdraw = "withdraw";

  // Funding
  static const String apiFunding = "funding";

  // Misc
  static const String apiDeleteConversationAlt = "delete-conversation";
  static const String apiGetNewsFeed = "get_news_feed"; // requires query params
  static const String apiGetNewsFeedCookie =
      "app_api.php?application=phone&type=set_c&c="; // requires query params
  static const String apiGetUsersListInfo =
      "app_api.php?application=phone&type=get_user_list_info";
  static const String apiCommonThings = "common_things";
  static const String apiGetMemories = "get_memories";
  static const String apiDownloadInfo = "download_info";
  static const String apiUploadBankReceipt = "bank";
  static const String apiInvitationAlt = "invitation";
  static const String apiOffersAlt = "offer";
  static const String apiStopNotify = "stop_notify";
  static const String apiAlbums = "albums";
  static const String apiGift = "gift";
  static const String apiPoke = "poke";
  static const String apiGroups = "groups";
  static const String apiEvents = "events";
  static const String apiGetCommunityAlt = "get-community";
  static const String apiTwilio = "twilio";
  static const String apiAgora = "agora";

  // External API Keys for Trending Features
  /// WeatherAPI.com API key - Used for weather forecasts in trending
  static const String weatherApiKey = "a413d0bf31a44369a16140106221804";

  /// OpenExchangeRates.org API key - Used for currency exchange rates
  static const String currencyApiKey = "644761ef2ba94ea5aa84767109d6cf7b";

  /// Default currency base (USD)
  static const String currencyBase = "USD";

  /// Default currency symbols to fetch
  static const String currencySymbols = "EUR,GBP,JPY,AUD,CAD,CHF,CNY,INR";

  // ==========================================
  // NEW SCOUTING API ENDPOINTS
  // ==========================================
  
  // Comments API
  static const String apiCreateComment = "api/comments"; // POST /api/comments/{post_id}
  static const String apiUserComments = "api/posts/comments"; // GET /api/posts/comments
  static const String apiPostComments = "api/posts"; // GET /api/posts/{post_id}/comments
  
  // Likes API
  static const String apiToggleLike = "api/likes"; // POST /api/likes/{post_id}
  static const String apiUserLikes = "api/posts/likes"; // GET /api/posts/likes
  static const String apiPostLikes = "api/posts"; // GET /api/posts/{post_id}/likes
  
  // Member API
  static const String apiMemberRegister = "api/members/register"; // POST /api/members/register
  static const String apiMemberLogin = "api/members/login"; // POST /api/members/login
  static const String apiMemberMe = "api/me"; // GET /api/me
  static const String apiMemberUpdate = "api/profile"; // POST /api/profile
  static const String apiMemberList = "api/members"; // GET /api/members
  static const String apiMemberShow = "api/members"; // GET /api/members/{user_id}
  
  // Posts API
  static const String apiPostsList = "api/posts"; // GET /api/posts
  static const String apiPostsShow = "api/posts"; // GET /api/posts/{post_id}
}
