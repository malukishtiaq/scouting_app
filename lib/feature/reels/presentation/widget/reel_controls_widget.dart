import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entity/reels_response_entity.dart';

/// Simplified Reels Controls Widget
class ReelControlsWidget extends StatefulWidget {
  final PostDataEntity reel;
  final VideoPlayerController? controller;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const ReelControlsWidget({
    super.key,
    required this.reel,
    this.controller,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  State<ReelControlsWidget> createState() => _ReelControlsWidgetState();
}

class _ReelControlsWidgetState extends State<ReelControlsWidget> {
  late PostDataEntity _currentReel;

  @override
  void initState() {
    super.initState();
    _currentReel = widget.reel;
  }

  @override
  void didUpdateWidget(ReelControlsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reel.id != widget.reel.id) {
      setState(() {
        _currentReel = widget.reel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Spacer(),

          // Main content
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Left side - Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    if (_currentReel.title.isNotEmpty)
                      Text(
                        _currentReel.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (_currentReel.title.isNotEmpty)
                      const SizedBox(height: 8),

                    // Description
                    if (_currentReel.description.isNotEmpty)
                      Text(
                        _currentReel.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right side - Action buttons
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Play/Pause button
                  _buildActionButton(
                    icon: widget.isPlaying ? Icons.pause : Icons.play_arrow,
                    label: '',
                    onTap: widget.onPlayPause,
                  ),
                  const SizedBox(height: 24),

                  // More options
                  _buildActionButton(
                    icon: Icons.more_horiz,
                    label: '',
                    onTap: _showMoreOptions,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Video Info'),
                subtitle: Text('ID: ${_currentReel.id}'),
                onTap: () {
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy link'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report feature coming soon')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
