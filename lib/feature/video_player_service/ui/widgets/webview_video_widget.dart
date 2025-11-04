import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../players/webview_video_player.dart';

class WebViewVideoWidget extends StatefulWidget {
  final WebViewVideoPlayer player;
  final double aspectRatio;

  const WebViewVideoWidget({
    super.key,
    required this.player,
    required this.aspectRatio,
  });

  @override
  State<WebViewVideoWidget> createState() => _WebViewVideoWidgetState();
}

class _WebViewVideoWidgetState extends State<WebViewVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: widget.player.controller != null
            ? WebViewWidget(
                controller: widget.player.controller!,
              )
            : const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
      ),
    );
  }
}
