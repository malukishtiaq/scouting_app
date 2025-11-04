import 'package:flutter/material.dart';
import 'user_profile_widget.dart';

class CommentWithProfileWidget extends StatelessWidget {
  final String commentId;
  final String userId;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final String commentText;
  final String timeAgo;
  final int likesCount;
  final bool isLiked;
  final bool showVerifiedBadge;
  final VoidCallback? onLike;
  final VoidCallback? onReply;
  final VoidCallback? onMore;

  const CommentWithProfileWidget({
    super.key,
    required this.commentId,
    required this.userId,
    this.username,
    this.displayName,
    this.avatarUrl,
    required this.commentText,
    required this.timeAgo,
    this.likesCount = 0,
    this.isLiked = false,
    this.showVerifiedBadge = false,
    this.onLike,
    this.onReply,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile header - clickable to navigate to profile
          CompactUserProfileWidget(
            userId: userId,
            username: username,
            showVerifiedBadge: showVerifiedBadge,
            avatarRadius: 20.0,
          ),
          const SizedBox(height: 8),

          // Comment text
          Text(
            commentText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Comment actions
          Row(
            children: [
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              _buildActionButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                label: likesCount > 0 ? '$likesCount' : null,
                color: isLiked ? Colors.red : Colors.grey[600],
                onPressed: onLike,
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.reply_outlined,
                label: 'Reply',
                color: Colors.grey[600],
                onPressed: onReply,
              ),
              const SizedBox(width: 16),
              _buildActionButton(
                icon: Icons.more_horiz,
                color: Colors.grey[600],
                onPressed: onMore,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? label,
    Color? color,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Example usage in a comments list
class CommentsListWidget extends StatelessWidget {
  final List<CommentData> comments;

  const CommentsListWidget({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CommentWithProfileWidget(
            commentId: comment.commentId,
            userId: comment.userId,
            username: comment.username,
            displayName: comment.displayName,
            avatarUrl: comment.avatarUrl,
            commentText: comment.commentText,
            timeAgo: comment.timeAgo,
            likesCount: comment.likesCount,
            isLiked: comment.isLiked,
            showVerifiedBadge: comment.showVerifiedBadge,
            onLike: () {
              // Handle like action
              print('Liked comment ${comment.commentId}');
            },
            onReply: () {
              // Handle reply action
              print('Reply to comment ${comment.commentId}');
            },
            onMore: () {
              // Handle more options
              print('More options for comment ${comment.commentId}');
            },
          ),
        );
      },
    );
  }
}

/// Data model for comments
class CommentData {
  final String commentId;
  final String userId;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final String commentText;
  final String timeAgo;
  final int likesCount;
  final bool isLiked;
  final bool showVerifiedBadge;

  CommentData({
    required this.commentId,
    required this.userId,
    this.username,
    this.displayName,
    this.avatarUrl,
    required this.commentText,
    required this.timeAgo,
    this.likesCount = 0,
    this.isLiked = false,
    this.showVerifiedBadge = false,
  });
}
