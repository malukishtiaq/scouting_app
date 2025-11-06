import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../localization/app_localization.dart';
import '../../../posts/domain/entity/posts_response_entity.dart';

class HighlightPostView extends StatefulWidget {
  final PostEntity post;
  final bool isActive;

  const HighlightPostView({
    super.key,
    required this.post,
    required this.isActive,
  });

  @override
  State<HighlightPostView> createState() => _HighlightPostViewState();
}

class _HighlightPostViewState extends State<HighlightPostView> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _isVideo = widget.post.mediaType.toLowerCase() == 'video';
    if (_isVideo) {
      _initializeController();
    }
  }

  @override
  void didUpdateWidget(HighlightPostView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.id != widget.post.id) {
      _disposeController();
      _isVideo = widget.post.mediaType.toLowerCase() == 'video';
      _isInitialized = false;
      _hasError = false;
      if (_isVideo) {
        _initializeController();
      }
    } else if (oldWidget.isActive != widget.isActive &&
        _controller != null &&
        _controller!.value.isInitialized) {
      if (widget.isActive) {
        _controller!.play();
      } else {
        _controller!.pause();
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _initializeController() {
    if (widget.post.mediaUrl.isEmpty) {
      setState(() {
        _hasError = true;
      });
      return;
    }

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.post.mediaUrl),
      );
      _controller!
        ..setLooping(true)
        ..initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isInitialized = true;
            _hasError = false;
          });
          if (widget.isActive) {
            _controller!.play();
          }
        }).catchError((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _hasError = true;
          });
        });
    } catch (_) {
      setState(() {
        _hasError = true;
      });
    }
  }

  void _disposeController() {
    try {
      _controller?.pause();
      _controller?.dispose();
    } catch (_) {
      // Safe disposal
    }
    _controller = null;
  }

  void _togglePlayback() {
    if (!_isVideo || _controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }

    setState(() {});
  }

  String _formatCount(int value) {
    return NumberFormat.compact().format(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isVideo ? _togglePlayback : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildMediaBackground(),
          DecoratedBox(
            decoration: AppDecorations.highlightGradientOverlay,
          ),
          _buildBottomContent(),
          if (_isVideo)
            Center(
              child: AnimatedOpacity(
                opacity: _controller != null &&
                        _controller!.value.isInitialized &&
                        _controller!.value.isPlaying
                    ? 0
                    : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding:
                      const EdgeInsets.all(AppDimensions.spacing12),
                  decoration: AppDecorations.circularOverlay,
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColors.textOnPrimary,
                    size: AppDimensions.iconXXLarge,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaBackground() {
    if (_isVideo) {
      if (_hasError) {
        return Container(
          color: AppColors.surfaceVariant,
          alignment: Alignment.center,
          child: Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: AppDimensions.iconXXLarge,
          ),
        );
      }

      if (!_isInitialized || _controller == null) {
        return Container(
          color: AppColors.surfaceVariant,
          alignment: Alignment.center,
          child: const SizedBox(
            width: AppDimensions.iconXXLarge,
            height: AppDimensions.iconXXLarge,
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 2,
            ),
          ),
        );
      }

      final videoSize = _controller!.value.size;
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: VideoPlayer(_controller!),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: widget.post.mediaUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.surfaceVariant,
        alignment: Alignment.center,
        child: const SizedBox(
          width: AppDimensions.iconXXLarge,
          height: AppDimensions.iconXXLarge,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.surfaceVariant,
        alignment: Alignment.center,
        child: Icon(
          Icons.broken_image,
          color: AppColors.textTertiary,
          size: AppDimensions.iconXXLarge,
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppDimensions.spacing12,
          right: AppDimensions.spacing12,
          bottom: AppDimensions.spacing16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildProfileSection(),
            ),
            const SizedBox(width: AppDimensions.spacing12),
            _buildActionColumn(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: AppDimensions.avatarLarge,
              height: AppDimensions.avatarLarge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.textOnPrimary,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.avatarLarge / 2),
                child: CachedNetworkImage(
                  imageUrl: widget.post.userAvatar,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.surfaceVariant,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.surfaceVariant,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      color: AppColors.textSecondary,
                      size: AppDimensions.iconMedium,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacing8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.user,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.post.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.post.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textOnPrimary,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacing8),
            GestureDetector(
              onTap: () {
                // TODO: Implement follow functionality
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing12,
                  vertical: AppDimensions.spacing6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  'follow'.tr,
                  style: AppTextStyles.buttonSmall.copyWith(
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.post.title.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.spacing8),
          Text(
            widget.post.title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildActionColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HighlightActionButton(
          icon: Icons.favorite_border,
          count: _formatCount(widget.post.likes),
          onTap: () {
            // TODO: Implement like functionality
          },
        ),
        const SizedBox(height: AppDimensions.spacing20),
        _HighlightActionButton(
          icon: Icons.chat_bubble_outline,
          count: _formatCount(widget.post.comments),
          onTap: () {
            // TODO: Implement comment functionality
          },
        ),
        const SizedBox(height: AppDimensions.spacing20),
        _HighlightActionButton(
          icon: Icons.send,
          count: _formatCount(widget.post.shares),
          onTap: () {
            // TODO: Implement share functionality
          },
        ),
      ],
    );
  }
}

class _HighlightActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final VoidCallback? onTap;

  const _HighlightActionButton({
    required this.icon,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacing10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.textOnPrimary,
              size: AppDimensions.iconLarge,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            count,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
