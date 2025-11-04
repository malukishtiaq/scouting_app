import 'package:intl/intl.dart';

class ChatTimeUtils {
  /// Format timestamp to relative time (5 minutes ago, 1 hour ago, etc.)
  static String formatRelativeTime(String timestamp) {
    try {
      final timestampInt = int.tryParse(timestamp);
      if (timestampInt == null) return timestamp;

      final messageTime =
          DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      final now = DateTime.now();
      final difference = now.difference(messageTime);

      // Less than 1 minute
      if (difference.inMinutes < 1) {
        return 'now';
      }

      // Less than 1 hour
      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      }

      // Less than 24 hours
      if (difference.inHours < 24) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      }

      // Less than 7 days
      if (difference.inDays < 7) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      }

      // Less than 4 weeks (1 month)
      if (difference.inDays < 28) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }

      // Less than 12 months
      if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months month${months == 1 ? '' : 's'} ago';
      }

      // More than 1 year
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } catch (e) {
      return timestamp;
    }
  }

  /// Format timestamp to detailed time (for tooltips or detailed view)
  static String formatDetailedTime(String timestamp) {
    try {
      final timestampInt = int.tryParse(timestamp);
      if (timestampInt == null) return timestamp;

      final messageTime =
          DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      final now = DateTime.now();
      final difference = now.difference(messageTime);

      // If same day, show time only
      if (difference.inDays == 0) {
        return DateFormat('h:mm a').format(messageTime);
      }

      // If same year, show month and day
      if (messageTime.year == now.year) {
        return DateFormat('MMM d, h:mm a').format(messageTime);
      }

      // Different year, show full date
      return DateFormat('MMM d, yyyy h:mm a').format(messageTime);
    } catch (e) {
      return timestamp;
    }
  }

  /// Format duration to MM:SS format
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  /// Get message status based on seen field
  static MessageStatus getMessageStatus(String? seen) {
    if (seen == null || seen.isEmpty) {
      return MessageStatus.sent;
    }

    // If seen field has a value, it means the message has been read
    return MessageStatus.read;
  }
}

enum MessageStatus {
  sent, // Single tick - message sent
  delivered, // Double tick - message delivered
  read, // Double tick with color - message read
}

extension MessageStatusExtension on MessageStatus {
  /// Get the appropriate icon for the message status
  String get icon {
    switch (this) {
      case MessageStatus.sent:
        return '✓';
      case MessageStatus.delivered:
        return '✓✓';
      case MessageStatus.read:
        return '✓✓';
    }
  }

  /// Get the color for the message status
  bool get isRead {
    return this == MessageStatus.read;
  }
}
