import 'package:flutter/material.dart';
import '../../models/video_item.dart';
import '../../services/i_video_player_service.dart';
import '../../impl/video_player_service_impl.dart';
import '../widgets/video_feed_item.dart';

class VideoFeedPage extends StatefulWidget {
  final List<VideoItem> items;
  const VideoFeedPage({super.key, required this.items});

  @override
  State<VideoFeedPage> createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage> {
  late final IVideoPlayerService _service;

  @override
  void initState() {
    super.initState();
    _service = VideoPlayerServiceImpl();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, i) =>
          VideoFeedItem(item: widget.items[i], service: _service),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: widget.items.length,
    );
  }
}
