import 'package:flutter/material.dart';

class VideoPlayerControls extends StatefulWidget {
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback onPlayPause;
  final VoidCallback onMute;
  final VoidCallback onFullscreen;
  final bool showFullscreenButton;

  const VideoPlayerControls({
    super.key,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlayPause,
    required this.onMute,
    required this.onFullscreen,
    this.showFullscreenButton = true,
  });

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Auto-hide controls after 3 seconds
    _startAutoHideTimer();
  }

  void _startAutoHideTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && widget.isPlaying) {
        _hideControls();
      }
    });
  }

  void _showControlsMethod() {
    if (mounted) {
      setState(() => _showControls = true);
      _animationController.reverse();
      _startAutoHideTimer();
    }
  }

  void _hideControls() {
    if (mounted) {
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() => _showControls = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showControlsMethod,
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: _showControls ? _buildControls() : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top controls (fullscreen)
            if (widget.showFullscreenButton)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildControlButton(
                    icon: Icons.fullscreen,
                    onTap: widget.onFullscreen,
                    tooltip: 'Fullscreen',
                  ),
                ),
              ),

            // Center play/pause button
            Expanded(
              child: Center(
                child: _buildControlButton(
                  icon: widget.isPlaying ? Icons.pause : Icons.play_arrow,
                  onTap: widget.onPlayPause,
                  size: 64,
                  tooltip: widget.isPlaying ? 'Pause' : 'Play',
                ),
              ),
            ),

            // Bottom controls (mute)
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildControlButton(
                  icon: widget.isMuted ? Icons.volume_off : Icons.volume_up,
                  onTap: widget.onMute,
                  tooltip: widget.isMuted ? 'Unmute' : 'Mute',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    double size = 48,
    String? tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: size * 0.5),
        onPressed: onTap,
        tooltip: tooltip,
        iconSize: size * 0.5,
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
