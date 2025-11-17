import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entity/reels_response_entity.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_dimensions.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../localization/app_localization.dart';

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
  late int _likeCount;
  late int _commentCount;
  late int _shareCount;
  bool _isLiked = false;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _syncFromWidget();
  }

  @override
  void didUpdateWidget(ReelControlsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reel.id != widget.reel.id) {
      setState(() {
        _syncFromWidget();
        _isLiked = false;
        _isFollowing = false;
      });
    }
  }

  void _syncFromWidget() {
    _currentReel = widget.reel;
    _likeCount = widget.reel.likeCount < 0 ? 0 : widget.reel.likeCount;
    _commentCount =
        widget.reel.commentCount < 0 ? 0 : widget.reel.commentCount;
    _shareCount = widget.reel.shareCount < 0 ? 0 : widget.reel.shareCount;
  }

  String get _displayName {
    if (_currentReel.publisherName.isNotEmpty) {
      return _currentReel.publisherName;
    }
    if (_currentReel.title.isNotEmpty) {
      return _currentReel.title;
    }
    return 'reels_default_name'.tr;
  }

  String get _displaySubtitle {
    if (_currentReel.publisherUsername.isNotEmpty) {
      return '@${_currentReel.publisherUsername}';
    }
    return 'reels_default_role'.tr;
  }

  String get _supportingDescription {
    if (_currentReel.description.isNotEmpty) {
      return _currentReel.description;
    }
    if (_currentReel.title.isNotEmpty) {
      return _currentReel.title;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: AppDecorations.highlightGradientOverlay,
            ),
          ),
          if (!widget.isPlaying) _buildPlayOverlay(),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: _buildInfoSection()),
                      SizedBox(width: AppDimensions.spacing16),
                      _buildActionColumn(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayOverlay() {
    return Center(
      child: GestureDetector(
        onTap: widget.onPlayPause,
        child: Container(
          width: AppDimensions.spacing56,
          height: AppDimensions.spacing56,
          decoration: AppDecorations.circularOverlay,
          alignment: Alignment.center,
          child: Icon(
            Icons.play_arrow,
            color: AppColors.textOnPrimary,
            size: AppDimensions.iconXXLarge,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderRow(),
        SizedBox(height: AppDimensions.spacing12),
        if (_supportingDescription.isNotEmpty)
          Text(
            _supportingDescription,
            style: AppTextStyles.bodyMediumOnPrimary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _displayName,
                style: AppTextStyles.h6.copyWith(
                  color: AppColors.textOnPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppDimensions.spacing4),
              Text(
                _displaySubtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spacing12),
        _buildFollowButton(),
      ],
    );
  }

  Widget _buildAvatar() {
    final avatarUrl = _currentReel.publisherAvatar.isNotEmpty
        ? _currentReel.publisherAvatar
        : _currentReel.image;
    return Container(
      width: AppDimensions.avatarLarge,
      height: AppDimensions.avatarLarge,
      decoration: AppDecorations.avatarWithShadow,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        child: avatarUrl.isNotEmpty
            ? Image.network(
                avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildAvatarFallback(),
              )
            : _buildAvatarFallback(),
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      color: AppColors.surfaceVariant,
      alignment: Alignment.center,
      child: Icon(
        Icons.person,
        color: AppColors.textSecondary,
        size: AppDimensions.iconLarge,
      ),
    );
  }

  Widget _buildFollowButton() {
    final decoration = _isFollowing
        ? AppDecorations.secondaryButton
        : AppDecorations.primaryButton;
    final label = _isFollowing ? 'following'.tr : 'follow'.tr;

    return GestureDetector(
      onTap: _handleFollow,
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing8,
        ),
        child: Text(
          label,
          style: AppTextStyles.buttonSmall.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildActionColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(
          icon: _isLiked ? Icons.favorite : Icons.favorite_border,
          label: _formatCount(_likeCount),
          iconColor: _isLiked ? AppColors.error : AppColors.textOnPrimary,
          onTap: _handleLike,
        ),
        SizedBox(height: AppDimensions.spacing24),
        _buildActionButton(
          icon: Icons.chat_bubble_outline,
          label: _formatCount(_commentCount),
          onTap: _handleComment,
        ),
        SizedBox(height: AppDimensions.spacing24),
        _buildActionButton(
          icon: Icons.send_outlined,
          label: _formatCount(_shareCount),
          onTap: _handleShare,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = AppColors.textOnPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppDimensions.spacing40,
            height: AppDimensions.spacing40,
            decoration: AppDecorations.circularOverlay,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor,
              size: AppDimensions.iconLarge,
            ),
          ),
          SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeCount += 1;
      } else if (_likeCount > 0) {
        _likeCount -= 1;
      }
    });
  }

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
                _buildHandleBar(),
                SizedBox(height: AppDimensions.spacing16),
                Text(
                  'comments'.tr,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing16),
                Text(
                  '${_formatCount(_commentCount)} ${'comments'.tr}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing24),
                Text(
                  'comments_coming_soon'.tr,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.spacing24),
              ],
            ),
          ),
        );
      },
    );
  }

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
                _buildHandleBar(),
                SizedBox(height: AppDimensions.spacing16),
                Text(
                  'share'.tr,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.spacing24),
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

  Widget _buildHandleBar() {
    return Container(
      width: AppDimensions.spacing40,
      height: AppDimensions.dividerThicknessThick,
      decoration: AppDecorations.dividerThick,
    );
  }
}
