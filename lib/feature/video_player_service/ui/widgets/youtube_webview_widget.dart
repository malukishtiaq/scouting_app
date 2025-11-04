import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../players/youtube_webview_player.dart';

class YouTubeWebViewWidget extends StatefulWidget {
  final YouTubeWebViewPlayer player;
  final double aspectRatio;

  const YouTubeWebViewWidget({
    Key? key,
    required this.player,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  State<YouTubeWebViewWidget> createState() => _YouTubeWebViewWidgetState();
}

class _YouTubeWebViewWidgetState extends State<YouTubeWebViewWidget>
    with AutomaticKeepAliveClientMixin {
  bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true; // Keep alive to prevent recreation

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    if (!_isInitialized) {
      try {
        // Initialize the player when widget is created
        await widget.player.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } catch (e) {
        print('❌ YouTubeWebViewWidget: Failed to initialize player: $e');
        if (mounted) {
          setState(() {
            _isInitialized =
                true; // Still mark as initialized to prevent infinite retry
          });
        }
      }
    }
  }

  @override
  void dispose() {
    // Clean up WebView resources to prevent buffer overflow
    widget.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    if (!_isInitialized || widget.player.webViewController == null) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: WebViewWidget(
            controller: widget.player.webViewController!,
          ),
        ),
      ),
    );
  }
}
