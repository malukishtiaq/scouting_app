import 'package:intl/intl.dart';

import '../app_config.dart';

class LanguageUtils {
  LanguageUtils._();

  /// util function to know if a certain `languageCode`
  /// is a Right-To-Left language
  /// If languageCode then it takes the app language
  static bool isRTL({String? languageCode}) {
    return Bidi.isRtlLanguage(
      languageCode ?? AppConfig().appLanguage.languageCode,
    );
  }

  /// util function to know if a certain `languageCode`
  /// is a Left-To-Right language
  /// If languageCode then it takes the app language
  static bool isLTR({String? languageCode}) {
    return !Bidi.isRtlLanguage(
      languageCode ?? AppConfig().appLanguage.languageCode,
    );
  }
}
