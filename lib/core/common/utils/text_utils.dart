import 'package:flutter/material.dart';

import '../../constants/app/app_constants.dart';
import '../app_config.dart';

class TextUtils {
  TextUtils._();

  /// util function to get the size of a text
  static Size getTextSize(
    String text,
    TextStyle style, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(
          fontFamily: style.fontFamily ??
              (AppConfig()
                      .appLanguage
                      .languageCode
                      .startsWith(AppConstants.LANG_EN)
                  ? 'Montserrat'
                  : 'GESS'),
        ),
      ),
      maxLines: maxLines,
      textDirection:
          AppConfig().appLanguage.languageCode.startsWith(AppConstants.LANG_EN)
              ? TextDirection.ltr
              : TextDirection.rtl,
      textScaler: MediaQuery.of(AppConfig().appContext!).textScaler,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.size;
  }

  /// util function to get the number of a text lines
  static bool getTextLines(
    String text,
    TextStyle style, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    int? maxLines,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(
          fontFamily: style.fontFamily ??
              (AppConfig()
                      .appLanguage
                      .languageCode
                      .startsWith(AppConstants.LANG_EN)
                  ? 'Montserrat'
                  : 'GESS'),
        ),
      ),
      maxLines: maxLines,
      textDirection:
          AppConfig().appLanguage.languageCode.startsWith(AppConstants.LANG_EN)
              ? TextDirection.ltr
              : TextDirection.rtl,
      textScaler: MediaQuery.of(AppConfig().appContext!).textScaler,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
