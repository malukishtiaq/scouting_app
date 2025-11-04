import '../models/video_item.dart';

class VideoSourceDetector {
  /// Detect video source type from URL
  static VideoSource detectSource(String url) {
    print('🔍 VideoSourceDetector: Detecting source for URL: $url');
    final lowerUrl = url.toLowerCase();

    if (lowerUrl.contains('youtube.com') || lowerUrl.contains('youtu.be')) {
      print('📺 VideoSourceDetector: Detected YouTube video');
      return VideoSource.youtube;
    } else if (lowerUrl.contains('vimeo.com')) {
      print('🎬 VideoSourceDetector: Detected Vimeo video');
      return VideoSource.vimeo;
    } else if (lowerUrl.contains('facebook.com') ||
        lowerUrl.contains('fb.com')) {
      print('📘 VideoSourceDetector: Detected Facebook video');
      return VideoSource.facebook;
    } else if (lowerUrl.contains('instagram.com')) {
      print('📷 VideoSourceDetector: Detected Instagram video');
      return VideoSource.instagram;
    } else if (lowerUrl.contains('dailymotion.com')) {
      print('🎥 VideoSourceDetector: Detected Dailymotion video');
      return VideoSource.other; // Will use WebView player
    } else if (lowerUrl.contains('playtube')) {
      print('🎮 VideoSourceDetector: Detected Playtube video');
      return VideoSource.other; // Will use WebView player
    } else if (_isDirectVideoFile(lowerUrl)) {
      print('📹 VideoSourceDetector: Detected direct video file');
      return VideoSource.direct;
    } else {
      print('🌐 VideoSourceDetector: Detected other/unknown video source');
      return VideoSource.other;
    }
  }

  /// Check if URL is a direct video file
  static bool _isDirectVideoFile(String url) {
    final videoExtensions = [
      '.mp4',
      '.avi',
      '.mov',
      '.wmv',
      '.flv',
      '.webm',
      '.mkv',
      '.m4v'
    ];

    return videoExtensions.any((ext) => url.endsWith(ext));
  }

  /// Extract YouTube video ID from URL
  static String? extractYouTubeId(String url) {
    final regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
      caseSensitive: false,
    );

    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  /// Extract Vimeo video ID from URL
  static String? extractVimeoId(String url) {
    final regExp = RegExp(
      r'vimeo\.com\/(?:.*#|.*\/videos\/)?([0-9]+)',
      caseSensitive: false,
    );

    final match = regExp.firstMatch(url);
    return match?.group(1);
  }
}
