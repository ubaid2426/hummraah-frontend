// lib/utils/date_formatter.dart
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatTime(DateTime time, {String pattern = 'hh:mm a'}) {
    return DateFormat(pattern).format(time);
  }

  static String formatDateTime(DateTime dateTime, {String pattern = 'dd MMM yyyy, hh:mm a'}) {
    return DateFormat(pattern).format(dateTime);
  }

  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    }
    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    }
    return 'Just now';
  }

  static String getHijriDate(DateTime date) {
    // This would use a proper Hijri calendar library
    // For now, return a formatted string
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  static String getDayName(int day) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[day - 1];
  }

  static String getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  static String formatRemainingTime(DateTime target) {
    final now = DateTime.now();
    final difference = target.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays}d ${difference.inHours.remainder(24)}h';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    }
    return 'Less than a minute';
  }
}