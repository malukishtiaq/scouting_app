import '../models/video_item.dart';
import '../services/i_video_player.dart';
import '../players/youtube_webview_player.dart';
import '../players/direct_video_player.dart';
import '../players/webview_video_player.dart';
import '../services/video_source_detector.dart';

class VideoPlayerFactory {
  static IVideoPlayer createPlayer(VideoItem item) {
    print('🏭 VideoPlayerFactory: Creating player for video item');
    print('🏭 VideoPlayerFactory: Video ID: ${item.id}');
    print('🏭 VideoPlayerFactory: Video URL: ${item.url}');
    print('🏭 VideoPlayerFactory: Video source: ${item.source}');

    final source = VideoSourceDetector.detectSource(item.url);
    print('🏭 VideoPlayerFactory: Detected source: $source');

    switch (source) {
      case VideoSource.youtube:
        final videoId = VideoSourceDetector.extractYouTubeId(item.url);
        print('🏭 VideoPlayerFactory: Extracted YouTube ID: $videoId');
        if (videoId != null) {
          // Use WebView YouTube player as it's more reliable than native API
          print(
              '✅ VideoPlayerFactory: Creating WebView YouTube player for video ID: $videoId');
          return YouTubeWebViewPlayer(videoId);
        } else {
          print(
              '⚠️ VideoPlayerFactory: Could not extract YouTube ID, falling back to WebView');
          return WebViewVideoPlayer(item.url);
        }
      case VideoSource.vimeo:
        print('✅ VideoPlayerFactory: Creating WebView player for Vimeo video');
        return WebViewVideoPlayer(item.url);
      case VideoSource.direct:
        print(
            '✅ VideoPlayerFactory: Creating DirectVideoPlayer for direct video file');
        return DirectVideoPlayer(item.url);
      case VideoSource.facebook:
        print(
            '✅ VideoPlayerFactory: Creating WebView player for Facebook video');
        return WebViewVideoPlayer(item.url);
      case VideoSource.instagram:
        print(
            '✅ VideoPlayerFactory: Creating WebView player for Instagram video');
        return WebViewVideoPlayer(item.url);
      default:
        print(
            '✅ VideoPlayerFactory: Creating WebView player for other/unknown source');
        return WebViewVideoPlayer(item.url);
    }
  }
}
