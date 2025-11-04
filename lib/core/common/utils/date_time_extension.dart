import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toTimeAgo({bool withReplace = true}) {
    try {
      final now = DateTime.now();
      final difference = now.difference(this);

      if (difference.inSeconds <= 60) {
        return 'Just now';
      } else if (difference.inMinutes <= 60) {
        return '${difference.inMinutes} minutes';
      } else if (difference.inHours <= 24) {
        return '${difference.inHours} hours';
      } else if (difference.inDays <= 30) {
        return difference.inDays > 1
            ? '${difference.inDays} days'
            : 'Yesterday';
      } else if (difference.inDays <= 365) {
        return '${(difference.inDays / 30).floor()} months';
      } else {
        return '${(difference.inDays / 365).floor()} years';
      }
    } catch (e) {
      return toString();
    }
  }

  String toShortTime() {
    try {
      final now = DateTime.now();
      final difference = now.difference(this);

      if (difference.inDays == 0) {
        // Today - show time only
        return DateFormat('HH:mm').format(this);
      } else if (difference.inDays <= 30) {
        // Within a month - show date
        return DateFormat('MM-dd').format(this);
      } else {
        // Older - show date with year
        return DateFormat('MM-dd-yyyy').format(this);
      }
    } catch (e) {
      return toString();
    }
  }
}

// Add new String extension
extension StringTimeExtension on String {
  String toTimeAgo({bool withReplace = true}) {
    try {
      // Convert string timestamp to DateTime
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(this) * 1000);
      return dateTime.toTimeAgo(withReplace: withReplace);
    } catch (e) {
      return this;
    }
  }
}

// For Unix timestamp conversion
DateTime unixTimeStampToDateTime(int timeStamp) {
  return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
}

// Helper function to replace time text if needed
String replaceTimeText(String text) {
  // Add any specific text replacements here
  // For example:
  final replacements = {
    'minutes': 'm',
    'hours': 'h',
    'days': 'd',
    'months': 'mo',
    'years': 'y',
  };

  String result = text;
  replacements.forEach((key, value) {
    result = result.replaceAll(key, value);
  });

  return result;
}
