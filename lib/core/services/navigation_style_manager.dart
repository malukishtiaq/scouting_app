import 'package:shared_preferences/shared_preferences.dart';

/// Local navigation style manager for handling navigation style preferences
class NavigationStyleManager {
  static const String _navigationStyleKey = 'navigation_style';
  static const String _defaultStyle = 'simple';

  static NavigationStyleManager? _instance;
  static NavigationStyleManager get instance {
    _instance ??= NavigationStyleManager._();
    return _instance!;
  }

  NavigationStyleManager._();

  /// Available navigation styles
  static const List<String> availableStyles = [
    'simple',
    'animated',
    'modern',
    'glassmorphism',
  ];

  /// Get current navigation style
  Future<String> getNavigationStyle() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_navigationStyleKey) ?? _defaultStyle;
    } catch (e) {
      print('Error getting navigation style: $e');
      return _defaultStyle;
    }
  }

  /// Set navigation style
  Future<bool> setNavigationStyle(String style) async {
    try {
      if (!availableStyles.contains(style)) {
        print('Invalid navigation style: $style');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_navigationStyleKey, style);
    } catch (e) {
      print('Error setting navigation style: $e');
      return false;
    }
  }

  /// Get navigation style display name
  String getStyleDisplayName(String style) {
    switch (style) {
      case 'simple':
        return 'Simple';
      case 'animated':
        return 'Animated';
      case 'modern':
        return 'Modern';
      case 'glassmorphism':
        return 'Glassmorphism';
      default:
        return 'Simple';
    }
  }

  /// Get navigation style description
  String getStyleDescription(String style) {
    switch (style) {
      case 'simple':
        return 'Clean and minimal design';
      case 'animated':
        return 'Smooth transitions and effects';
      case 'modern':
        return 'Floating design with glassmorphism';
      case 'glassmorphism':
        return 'Blur effects and transparency';
      default:
        return 'Clean and minimal design';
    }
  }

  /// Reset to default style
  Future<bool> resetToDefault() async {
    return await setNavigationStyle(_defaultStyle);
  }
}
