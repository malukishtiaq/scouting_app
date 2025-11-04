/// Simple screen detection service to track current screen
class ScreenDetector {
  static final ScreenDetector _instance = ScreenDetector._internal();
  factory ScreenDetector() => _instance;
  ScreenDetector._internal();

  String? _currentScreen;
  final List<String> _screenHistory = [];

  /// Get current screen name
  String? get currentScreen => _currentScreen;

  /// Get screen history
  List<String> get screenHistory => List.unmodifiable(_screenHistory);

  /// Set current screen
  void setCurrentScreen(String screenName) {
    print('🖥️ ScreenDetector: Current screen changed to: $screenName');
    _currentScreen = screenName;
    _screenHistory.add(screenName);

    // Keep only last 10 screens in history
    if (_screenHistory.length > 10) {
      _screenHistory.removeAt(0);
    }
  }

  /// Check if currently on a specific screen
  bool isOnScreen(String screenName) {
    return _currentScreen == screenName;
  }

  /// Check if currently on any of the specified screens
  bool isOnAnyScreen(List<String> screenNames) {
    return _currentScreen != null && screenNames.contains(_currentScreen);
  }

  /// Check if should run background services
  bool shouldRunBackgroundServices() {
    // Don't run background services on post detail page
    if (isOnScreen('PostDetailScreen')) {
      print(
          '🖥️ ScreenDetector: Background services disabled on PostDetailScreen');
      return false;
    }

    // Don't run background services on video player screens
    if (isOnAnyScreen(['VideoPlayerScreen', 'FullScreenVideoScreen'])) {
      print(
          '🖥️ ScreenDetector: Background services disabled on video screens');
      return false;
    }

    return true;
  }

  /// Clear screen history
  void clearHistory() {
    _screenHistory.clear();
    _currentScreen = null;
  }
}
