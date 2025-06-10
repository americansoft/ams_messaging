
import 'package:intl/intl.dart';

class DateFormatter {
  static String chatTimestamp(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String fullDate(DateTime date) {
    return DateFormat('yyyy-MM-dd – hh:mm a').format(date);
  }

  static String storyTime(DateTime date) {
    return DateFormat('dd MMM, hh:mm a').format(date);
  }

  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('MMM d').format(date);
  }
}
