// ignore: constant_identifier_names
import '../../constants/app/app_constants.dart';

enum SocialType { Facebook, Gmail, Apple, LinkedIn }

class SocialUtils {
  SocialUtils._();

  static Map<SocialType, String> socialIcons = {
    SocialType.Facebook: AppConstants.FACEBOOK_ICON,
    SocialType.Gmail: AppConstants.GMAIL_ICON,
    SocialType.LinkedIn: AppConstants.LINKEDIN_ICON,
    SocialType.Apple: AppConstants.APPLE_ICON,
  };
}
