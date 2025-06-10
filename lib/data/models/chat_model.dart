import 'message_model.dart';

class ChatModel {
  late final String chatId;
  late final List<String> participants; // 2 userIds
  late final MessageModel? lastMessage;
  late final DateTime updatedAt;

// Optional: isArchived, isMuted
}