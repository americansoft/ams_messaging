import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
extension TimestampToDate on Timestamp {
  DateTime get toDateSafe => toDate();
}

extension DateTimeFormatting on DateTime {
  String get timeOnly => DateFormat('hh:mm a').format(this);
  String get dayOnly => DateFormat('EEE, MMM d').format(this);
}

extension Capitalize on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
