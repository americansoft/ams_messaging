import 'package:uuid/uuid.dart';

String generateChatId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}

String generateUuid() {
  return const Uuid().v4();
}

bool isGroupChat(String chatId) {
  return chatId.startsWith('group_');
}
String getInitials(String fullName) {
  List<String> parts = fullName.trim().split(RegExp(r'\s+'));

  if (parts.isEmpty) return '';

  if (parts.length <= 2) {
    return parts.map((word) => word[0].toUpperCase()).join();
  } else {
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

