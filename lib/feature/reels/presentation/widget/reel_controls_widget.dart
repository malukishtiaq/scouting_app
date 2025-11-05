import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entity/reels_response_entity.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../localization/app_localization.dart';

/// TikTok-style Reels Controls Widget matching Figma design
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
  bool _isLiked = false;
  bool _isFollowing = false;
  int _likeCount = 2300; // From Figma: 2.3k
  int _commentCount = 123; // From Figma
  int _shareCount = 45; // From Figma

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
        // Reset engagement state for new reel
        _isLiked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Play/Pause overlay in center
          if (!widget.isPlaying)
            Center(
              child: GestureDetector(
                onTap: widget.onPlayPause,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.textOnPrimary,
                    size: 50,
                  ),
                ),
              ),
            ),

          // Main content overlay
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                children: [
                  const Spacer(),

                  // Bottom section with player info and engagement
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Left side - Player profile and info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Player profile with follow button
                            Row(
                              children: [
                                // Player avatar
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.surface,
                                  backgroundImage: _currentReel.image.isNotEmpty
                                      ? NetworkImage(_currentReel.image)
                                      : null,
                                  child: _currentReel.image.isEmpty
                                      ? Icon(
                                          Icons.person,
                                          color: AppColors.textSecondary,
                                          size: AppDimensions.iconSmall,
                                        )
                                      : null,
                                ),
                                SizedBox(width: AppDimensions.spacing8),

                                // Player name
                                Expanded(
                                  child: Text(
                                    _currentReel.title.isNotEmpty
                                        ? _currentReel.title
                                        : 'player_flame'.tr,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textOnPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                SizedBox(width: AppDimensions.spacing8),

                                // Follow button
                                GestureDetector(
                                  onTap: _handleFollow,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.spacing16,
                                      vertical: AppDimensions.spacing8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _isFollowing
                                          ? AppColors.surface
                                          : AppColors.primary,
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusSmall,
                                      ),
                                      border: _isFollowing
                                          ? Border.all(
                                              color: AppColors.borderLight,
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      _isFollowing
                                          ? 'following'.tr
                                          : 'follow'.tr,
                                      style:
                                          AppTextStyles.buttonSmall.copyWith(
                                        color: AppColors.textOnPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: AppDimensions.spacing12),

                            // Description
                            if (_currentReel.description.isNotEmpty)
                              Text(
                                _currentReel.description,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textOnPrimary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),

                      SizedBox(width: AppDimensions.spacing16),

                      // Right side - Engagement buttons (TikTok style)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Like button
                          _buildEngagementButton(
                            icon: _isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            label: _formatCount(_likeCount),
                            color: _isLiked ? AppColors.error : null,
                            onTap: _handleLike,
                          ),

                          SizedBox(height: AppDimensions.spacing24),

                          // Comment button
                          _buildEngagementButton(
                            icon: Icons.chat_bubble_outline,
                            label: _formatCount(_commentCount),
                            onTap: _handleComment,
                          ),

                          SizedBox(height: AppDimensions.spacing24),

                          // Share button
                          _buildEngagementButton(
                            icon: Icons.send_outlined,
                            label: _formatCount(_shareCount),
                            onTap: _handleShare,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: AppDimensions.spacing16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build engagement button (TikTok style)
  Widget _buildEngagementButton({
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? AppColors.textOnPrimary,
            size: AppDimensions.iconLarge,
          ),
          SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Format count for display (e.g., 2300 -> 2.3k)
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// Handle like action
  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  /// Handle follow action
  void _handleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowing ? 'followed_player'.tr : 'unfollowed_player'.tr,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// Handle comment action
  void _handleComment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.spacing16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: AppDimensions.spacing16),

                // Title
                Text(
                  'comments'.tr,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing16),

                // Comment count
                Text(
                  '${_formatCount(_commentCount)} ${'comments'.tr}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing24),

                // Coming soon message
                Text(
                  'comments_coming_soon'.tr,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing24),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Handle share action
  void _handleShare() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.spacing16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: AppDimensions.spacing16),

                // Title
                Text(
                  'share'.tr,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing24),

                // Share options
                ListTile(
                  leading: Icon(
                    Icons.copy,
                    color: AppColors.textPrimary,
                  ),
                  title: Text(
                    'copy_link'.tr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'link_copied'.tr,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.surface,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.share,
                    color: AppColors.textPrimary,
                  ),
                  title: Text(
                    'share_external'.tr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'share_coming_soon'.tr,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.surface,
                      ),
                    );
                  },
                ),
                SizedBox(height: AppDimensions.spacing16),
              ],
            ),
          ),
        );
      },
    );
  }
}
