import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
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

  static bool isSameDay(DateTime a, DateTime b) {
    final aLocal = a.toLocal();
    final bLocal = b.toLocal();

    return aLocal.year == bLocal.year &&
        aLocal.month == bLocal.month &&
        aLocal.day == bLocal.day;
  }
  static bool isYesterday(DateTime input) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    final inputDate = DateTime(input.year, input.month, input.day);

    return inputDate == yesterday;
  }
  static bool isWithinLast7Days(DateTime createdAt) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return createdAt.isAfter(sevenDaysAgo);
  }

  static bool isAfterLastYear(DateTime createdAt) {
    final oneYearAgo = DateTime.now().subtract(const Duration(days: 365));
    return createdAt.isAfter(oneYearAgo);
  }
  static String formatFromNow(DateTime? time) {
    if (time == null) return 'N/A';
    return Jiffy.parseFromDateTime(time).fromNow();
  }
}
