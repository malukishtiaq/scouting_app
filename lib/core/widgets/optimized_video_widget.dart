import 'package:flutter/material.dart';
import '../services/viewport_tracker_service.dart';
import '../../feature/video_player_service/ui/widgets/video_feed_item.dart';
import '../../feature/video_player_service/models/video_item.dart';
import '../../feature/video_player_service/services/video_source_detector.dart';
import '../../feature/video_player_service/services/i_video_player_service.dart';
import '../../feature/video_player_service/services/video_player_service_provider.dart';

/// Optimized video widget with lazy initialization
class OptimizedVideoWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final String? title;
  final String trackingKey;
  final BoxFit fit;
  final IVideoPlayerService? service;

  const OptimizedVideoWidget({
    super.key,
    required this.videoUrl,
    required this.trackingKey,
    this.thumbnailUrl,
    this.title,
    this.fit = BoxFit.cover,
    this.service,
  });

  @override
  State<OptimizedVideoWidget> createState() => _OptimizedVideoWidgetState();
}

class _OptimizedVideoWidgetState extends State<OptimizedVideoWidget>
    with AutomaticKeepAliveClientMixin {
  bool _isVisible = false;
  bool _isInitialized = false;
  late final IVideoPlayerService _videoService;

  @override
  void initState() {
    super.initState();
    _videoService = widget.service ?? VideoPlayerServiceProvider.service;
  }

  @override
  bool get wantKeepAlive => false;

  void _onVisibilityChanged(double visibility) {
    final wasVisible = _isVisible;
    _isVisible = visibility > 0.5; // Consider visible if > 50% visible

    // Initialize video only when visible
    if (_isVisible && !_isInitialized && mounted) {
      setState(() {
        _isInitialized = true;
      });
    }

    // Dispose video when scrolled far away
    if (!_isVisible && wasVisible && _isInitialized) {
      // Optionally dispose after some delay
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && !_isVisible) {
          setState(() {
            _isInitialized = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewportTracker(
      trackingKey: widget.trackingKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: _buildVideoContent(),
    );
  }

  Widget _buildVideoContent() {
    // Show thumbnail until initialized
    if (!_isInitialized) {
      return _buildThumbnail();
    }

    // Build actual video player
    return _buildVideoPlayer();
  }

  Widget _buildThumbnail() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Thumbnail image
        if (widget.thumbnailUrl != null)
          Image.network(
            widget.thumbnailUrl!,
            fit: widget.fit,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.black87,
              child: const Center(
                child: Icon(Icons.videocam, size: 48, color: Colors.white54),
              ),
            ),
          )
        else
          Container(
            color: Colors.black87,
            child: const Center(
              child: Icon(Icons.videocam, size: 48, color: Colors.white54),
            ),
          ),
        // Play button overlay
        Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow,
            size: 48,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    final videoItem = VideoItem(
      id: widget.trackingKey,
      url: widget.videoUrl,
      source: VideoSourceDetector.detectSource(widget.videoUrl),
      title: widget.title,
      thumbnailUrl: widget.thumbnailUrl,
    );

    return VideoFeedItem(
      item: videoItem,
      service: _videoService,
    );
  }
}
