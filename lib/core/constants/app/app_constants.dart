import 'package:flutter/material.dart';

/// Centralizing application constants
class AppConstants {
  AppConstants._();

  static const TITLE_APP_NAME = 'Mss';
  static String COUNTRY_CODE = "+1";
  static String COUNTRY_Name = "";

  static const BoxShadow appShadow = BoxShadow(
    color: Color(0x24000000),
    blurRadius: 14,
    offset: Offset(0, 0),
  );

  /// Pagination constants
  static const paginationLimit = 10;
  static const paginationFirstPage = 0;

  /// Headers
  static const HEADER_AUTH = 'Authorization';
  static const APP_NAME = 'DBName';
  static const HEADER_APP_VERSION = 'appversion';
  static const HEADER_OS = 'os';
  static const HEADER_SESSION = 'session';
  static const HEADER_LANGUAGE = 'Accept-Language';
  static const HEADER_ACCEPT = 'Accept';
  static const SUCCESSFUL = 'Successful!';

  /// Animations
  // ! Hero Tags
  static const PROFILE_PICTURE_HERO = 'profile-picture_tag';

  /// ERROR ANIMATIONS
  static const ANIM_LOTTIE_ERROR =
      "assets/anim/lottie/error/general_error_placeholder.json";
  static const ANIM_LOTTIE_ERROR_403_401 =
      "assets/images/png/error/403-error.png";
  static const ANIM_LOTTIE_ERROR_EMPTY =
      "assets/images/png/error/empty_placeholder.png";
  static const ANIM_LOTTIE_ERROR_INVALID =
      "assets/images/png/error/invalid_error.png";
  static const ANIM_LOTTIE_ERROR_SERVER =
      "assets/images/png/error/500-error.png";
  static const ANIM_LOTTIE_ERROR_TIMEOUT =
      "assets/images/png/error/timout_error.png";
  static const ANIM_LOTTIE_ERROR_UNKNOWING =
      "assets/images/png/error/unknown_error.png";

  // ! Mss animations
  // @ Lottie
  // All lottie animation will be listed here.
  // @ Video Animation
  // All videos will be listed here.
  // @ GIF
  // All gifs will be listed here.
  /// Image
  // All specific images will be listed here.

  // ! Mss Images

  static const APP_LOGO = "assets/images/png/app_logo.png";
  static const APPLE_ICON = "assets/images/png/apple.png";
  static const FACEBOOK_ICON = "assets/images/png/facebook.png";
  static const GMAIL_ICON = "assets/images/png/gmail.png";
  static const LINKEDIN_ICON = "assets/images/png/linkedIn.png";
  static const BACKGROUND_IMAGE = "assets/images/png/background_design.png";
  static const WRONG_CODE = "assets/images/png/wrong_code.png";
  static const PHONE_VERIFIED = "assets/images/png/phone_verified.png";
  static const PHONE_VALIDATION = "assets/images/png/phone_validation.png";
  static const FORGOT_PASSWORD = "assets/images/png/forgot_password.png";
  static const ENTER_PHONE = "assets/images/png/enter_phone.png";
  static const RECTANGULAR_SHADOW = "assets/images/png/rantangular_shadow.png";

  static const FAQ_IMG = 'assets/images/png/mss/faqbanner.png';
  static const EMPTY_IMG_PLACEHOLDER =
      'assets/images/png/empty_image_placeholder.png';
  static const DELETE_ACCOUNT = "assets/images/png/delete_account.png";
  static const DELETE_DATA = "assets/images/png/delete_data.png";
  static const TICK_ICON = "assets/images/png/tick.png";
  static const CROSS_ICON = "assets/images/png/cross.png";

  static const DASHBOARD_FILLED = 'assets/images/png/mss/dashboard_filled.png';
  static const DASHBOARD = 'assets/images/png/mss/dashboard.png';
  static const LOGS_FILLED = 'assets/images/png/mss/logs_filled.png';
  static const LOGS = 'assets/images/png/mss/logs.png';
  static const NOTIFICATION_FILLED =
      'assets/images/png/mss/notification_filled.png';
  static const NOTIFICATION = 'assets/images/png/mss/notification.png';
  static const SETTINGS_FILLED = 'assets/images/png/mss/settings_filled.png';
  static const SETTINGS = 'assets/images/png/mss/settings.png';
  static const TESTIMONIAL_FILLED =
      'assets/images/png/mss/testimonial_filled.png';
  static const TESTIMONIAL = 'assets/images/png/mss/testimonial.png';

  /// Svg
  static const SVG_IMAGE_PLACEHOLDER =
      'assets/images/svg/image_placeholder.svg';
  static const VERIFIED = "assets/images/svg/mss/verified.svg";
  static const UNVERIFIED = "assets/images/svg/mss/unverified.svg";
  static const VERIFY_EMAIL = "assets/images/svg/mss/email_verify.svg";
  static const SVG_LIST_PLACEHOLDER = 'assets/images/svg/list_placeholder.svg';
  static const SVG_LIST_TILE_PLACEHOLDER =
      'assets/images/svg/list_tile_placeholder.svg';
  static const SVG_DETAILS_PLACEHOLDER =
      'assets/images/svg/details_placeholder.svg';
  static const AE_FLAG = 'assets/images/svg/ae_flag.svg';
  static const GB_FLAG = 'assets/images/svg/gb_flag.svg';

  // ! Mss svg
  static const BELL_ICON = 'assets/images/svg/mss/addcircle_filled.svg';

  static const ADDCIRCLE_FILLED = 'assets/images/svg/mss/addcircle_filled.svg';
  static const SEARCH_ICON = 'assets/images/svg/mss/search.svg';
  static const TIME_ICON = 'assets/images/svg/mss/time.svg';
  static const LOGOUT_ICON = 'assets/images/svg/mss/logout.svg';
  static const MALE_ICON = 'assets/images/svg/mss/male_icon.svg';
  static const FEMALE_ICON = 'assets/images/svg/mss/female_icon.svg';
  static const CHECK_CIRCLE_ICON =
      'assets/images/svg/mss/check_circle_icon.svg';
  static const NEW_FILTER_ICON = 'assets/images/svg/mss/new_filter.svg';
  static const CAMERA_ICON = 'assets/images/svg/mss/camera_icon.svg';
  static const TRASH_ICON = 'assets/images/svg/mss/trash.svg';
  static const HOME_ICON_ENABLED =
      'assets/images/svg/mss/home_icon_enabled.svg';
  static const HOME_ICON_DISABLED =
      'assets/images/svg/mss/home_icon_disabled.svg';
  static const BOOKINGS_ICON_ENABLED =
      'assets/images/svg/mss/bookings_icon_enabled.svg';
  static const BOOKINGS_ICON_DISABLED =
      'assets/images/svg/mss/bookings_icon_disabled.svg';
  static const OFFERS_ICON_ENABLED =
      'assets/images/svg/mss/offers_icon_enabled.svg';
  static const OFFERS_ICON_DISABLED =
      'assets/images/svg/mss/offers_icon_disabled.svg';
  static const PROFILE_ICON_ENABLED =
      'assets/images/svg/mss/profile_icon_enabled.svg';
  static const PROFILE_ICON_DISABLED =
      'assets/images/svg/mss/profile_icon_disabled.svg';
  static const DOWNWARD_ICON = 'assets/images/svg/mss/downward_arrow.svg';

  static const OTP_SENT_EMAIL = "assets/images/svg/mss/otp_sent_email.svg";
  static const OTP_SENT_PHONE = "assets/images/svg/mss/otp_sent_phone.svg";
  static const OTP_VERIFIED_EMAIL =
      "assets/images/svg/mss/otp_verified_email.svg";
  static const WRONG_OTP_EMAIL = "assets/images/svg/mss/wrong_otp_email.svg";
  static String OTP_VERIFIED_PHONE =
      "assets/images/svg/mss/wrong_otp_phone.svg";
  static String WRONG_OTP_PHONE = 'assets/images/svg/mss/wrong_otp_phone.svg';

  /// ERROR IMAGES
  static const ERROR_403_401 = "assets/images/png/error/403.png";
  static const ERROR_EMPTY = "assets/images/png/error/empty.png";
  static const ERROR_INVALID = "assets/images/png/error/invalid.png";
  static const ERROR_SERVER = "assets/images/png/error/server_error.png";
  static const ERROR_TIMEOUT = "assets/images/png/error/time_out.png";
  static const ERROR_UNKNOWING = "assets/images/png/error/unknowing_error.png";

  /// Languages
  static const LANG_AR = 'ar';
  static const LANG_EN = 'en';

  /// Languages code & output
  static const LANG_AR_CODE = 'AR';
  static const LANG_EN_CODE = 'EN';

  static const LANG_AR_OUTPUT = 'العربية';
  static const LANG_EN_OUTPUT = 'English';

  /// APP constants
  static const MENU_CHANGE_LANG = "assets/png/menu/change_lang.png";
  static const MENU_LOGOUT = "assets/png/menu/logout.png";

  // Verification Code Length.
  static const OTP_LENGTH = 6;

  /// File Sizes
  static const BYTE = 1;
  static const KB = 1024 * BYTE;
  static const MB = 1024 * KB;
  static const GB = 1024 * MB;

  /// Routes
  static const String ROUTE_REELS = '/reels';
}
