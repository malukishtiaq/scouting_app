/// Centralized time formatting utility for consistent time display across the app
class TimeFormatter {
  /// Formats a time string to a human-readable relative time
  /// Uses server's pre-formatted time when available, otherwise calculates relative time
  static String formatRelativeTime(String? time) {
    if (time == null || time.isEmpty) {
      return 'Just now';
    }

    // Check if time is already in a readable format (like "2 hrs", "3 d", "1 week ago")
    if (_isAlreadyFormattedTime(time)) {
      return time;
    }

    try {
      DateTime dateTime;

      // Try to parse as Unix timestamp first (if it's a number)
      if (time.contains(RegExp(r'^[0-9]+$'))) {
        // It's a Unix timestamp in SECONDS (not milliseconds)
        final timestamp = int.parse(time);
        dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      }
      // Try to parse as month/year format (e.g., "8/2025", "7/2025")
      // This format represents the month and year of post creation
      else if (time.contains(RegExp(r'^[0-9]+/[0-9]{4}$'))) {
        final parts = time.split('/');
        if (parts.length == 2) {
          final month = int.tryParse(parts[0]);
          final year = int.tryParse(parts[1]);
          if (month != null && year != null) {
            // Create a date for the 1st of that month/year
            dateTime = DateTime(year, month, 1);
          } else {
            return 'Recently';
          }
        } else {
          return 'Recently';
        }
      }
      // Try to parse as time_text format (e.g., "08.25.25", "08.24.25")
      // This format appears to be MM.dd.HH or MM.dd.yy
      else if (time.contains(RegExp(r'^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$'))) {
        final parts = time.split('.');
        if (parts.length == 3) {
          final month = int.tryParse(parts[0]);
          final day = int.tryParse(parts[1]);
          final hourOrYear = int.tryParse(parts[2]);
          if (month != null && day != null && hourOrYear != null) {
            // If the third part is > 23, it's likely a year (like 25 for 2025)
            if (hourOrYear > 23) {
              final year = 2000 + hourOrYear; // Convert 25 to 2025
              dateTime = DateTime(year, month, day);
            } else {
              // It's an hour, use current year and month
              final now = DateTime.now();
              dateTime = DateTime(now.year, month, day, hourOrYear);
            }
          } else {
            return 'Recently';
          }
        } else {
          return 'Recently';
        }
      }
      // Try to parse as ISO string
      else {
        dateTime = DateTime.parse(time);
      }

      // Calculate relative time
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      // More granular time display
      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        if (difference.inHours == 1) {
          return '1 hour ago';
        }
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        if (difference.inDays == 1) {
          return 'Yesterday';
        }
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        if (weeks == 1) {
          return '1 week ago';
        }
        return '${weeks} weeks ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        if (months == 1) {
          return '1 month ago';
        }
        return '${months} months ago';
      } else {
        final years = (difference.inDays / 365).floor();
        if (years == 1) {
          return '1 year ago';
        }
        return '${years} years ago';
      }
    } catch (e) {
      return 'Recently';
    }
  }

  /// Checks if the time string is already in a formatted state
  static bool _isAlreadyFormattedTime(String time) {
    // Check for common formatted time patterns
    final formattedPatterns = [
      RegExp(r'^\d+\s*(min|mins|minute|minutes|m)\s*ago?$',
          caseSensitive: false),
      RegExp(r'^\d+\s*(hour|hours|hr|hrs|h)\s*ago?$', caseSensitive: false),
      RegExp(r'^\d+\s*(day|days|d)\s*ago?$', caseSensitive: false),
      RegExp(r'^\d+\s*(week|weeks|w)\s*ago?$', caseSensitive: false),
      RegExp(r'^\d+\s*(month|months)\s*ago?$', caseSensitive: false),
      RegExp(r'^\d+\s*(year|years|y)\s*ago?$', caseSensitive: false),
      RegExp(r'^just\s*now$', caseSensitive: false),
      RegExp(r'^yesterday$', caseSensitive: false),
      RegExp(r'^today$', caseSensitive: false),
    ];

    return formattedPatterns.any((pattern) => pattern.hasMatch(time));
  }

  /// Formats a time string to a short relative time (e.g., "2h ago", "3d ago")
  static String formatShortTime(String? time) {
    if (time == null || time.isEmpty) return 'now';

    try {
      DateTime dateTime;
      if (time.contains(RegExp(r'^[0-9]+$'))) {
        final timestamp = int.parse(time);
        dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      } else if (time.contains(RegExp(r'^[0-9]+/[0-9]{4}$'))) {
        final parts = time.split('/');
        if (parts.length == 2) {
          final month = int.tryParse(parts[0]);
          final year = int.tryParse(parts[1]);
          if (month != null && year != null) {
            dateTime = DateTime(year, month, 1);
          } else {
            return 'now';
          }
        } else {
          return 'now';
        }
      } else if (time.contains(RegExp(r'^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$'))) {
        final parts = time.split('.');
        if (parts.length == 3) {
          final month = int.tryParse(parts[0]);
          final day = int.tryParse(parts[1]);
          final hourOrYear = int.tryParse(parts[2]);
          if (month != null && day != null && hourOrYear != null) {
            if (hourOrYear > 23) {
              final year = 2000 + hourOrYear;
              dateTime = DateTime(year, month, day);
            } else {
              final now = DateTime.now();
              dateTime = DateTime(now.year, month, day, hourOrYear);
            }
          } else {
            return 'now';
          }
        } else {
          return 'now';
        }
      } else {
        dateTime = DateTime.parse(time);
      }

      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m';
      } else {
        return 'now';
      }
    } catch (e) {
      return 'now';
    }
  }

  /// Formats a time string to a detailed date and time
  static String formatDetailedTime(String? time) {
    if (time == null || time.isEmpty) return 'Unknown time';

    try {
      DateTime dateTime;
      if (time.contains(RegExp(r'^[0-9]+$'))) {
        final timestamp = int.parse(time);
        dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      } else if (time.contains(RegExp(r'^[0-9]+/[0-9]{4}$'))) {
        final parts = time.split('/');
        if (parts.length == 2) {
          final month = int.tryParse(parts[0]);
          final year = int.tryParse(parts[1]);
          if (month != null && year != null) {
            dateTime = DateTime(year, month, 1);
          } else {
            return 'Unknown time';
          }
        } else {
          return 'Unknown time';
        }
      } else if (time.contains(RegExp(r'^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$'))) {
        final parts = time.split('.');
        if (parts.length == 3) {
          final month = int.tryParse(parts[0]);
          final day = int.tryParse(parts[1]);
          final hourOrYear = int.tryParse(parts[2]);
          if (month != null && day != null && hourOrYear != null) {
            if (hourOrYear > 23) {
              final year = 2000 + hourOrYear;
              dateTime = DateTime(year, month, day);
            } else {
              final now = DateTime.now();
              dateTime = DateTime(now.year, month, day, hourOrYear);
            }
          } else {
            return 'Unknown time';
          }
        } else {
          return 'Unknown time';
        }
      } else {
        dateTime = DateTime.parse(time);
      }

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (dateToCheck == today) {
        return 'Today at ${_formatTimeOfDay(dateTime)}';
      } else if (dateToCheck == yesterday) {
        return 'Yesterday at ${_formatTimeOfDay(dateTime)}';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${_formatTimeOfDay(dateTime)}';
      }
    } catch (e) {
      return 'Unknown time';
    }
  }

  /// Formats time of day (HH:MM)
  static String _formatTimeOfDay(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Checks if a time string is valid
  static bool isValidTime(String? time) {
    if (time == null || time.isEmpty) return false;

    try {
      if (time.contains(RegExp(r'^[0-9]+$'))) {
        final timestamp = int.parse(time);
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        return dateTime.isAfter(DateTime(1970, 1, 1));
      } else {
        DateTime.parse(time);
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
