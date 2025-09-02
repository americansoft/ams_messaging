import '../../models/conversation_model.dart';
import '../../models/message_model.dart';
import '../../domain/entities/message.dart';

class MockChatData {
  static List<ConversationModel> getMockConversations() {
    return [
      ConversationModel(
        id: '1',
        participant1Id: 'current_user',
        participant2Id: 'user1',
        lastMessage: MessageModel(
          id: 'msg1',
          senderId: 'user1',
          receiverId: 'current_user',
          content: 'Hey, how are you doing?',
          type: MessageType.text,
          status: MessageStatus.read,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 0,
      ),
      ConversationModel(
        id: '2',
        participant1Id: 'current_user',
        participant2Id: 'user2',
        lastMessage: MessageModel(
          id: 'msg2',
          senderId: 'user2',
          receiverId: 'current_user',
          content: 'Did you see the new update?',
          type: MessageType.text,
          status: MessageStatus.delivered,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 2,
      ),
      ConversationModel(
        id: '3',
        participant1Id: 'current_user',
        participant2Id: 'user3',
        lastMessage: MessageModel(
          id: 'msg3',
          senderId: 'current_user',
          receiverId: 'user3',
          content: '📷 Image',
          type: MessageType.image,
          status: MessageStatus.sent,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          mediaUrl: 'https://via.placeholder.com/300x200',
        ),
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
      ),
      ConversationModel(
        id: '4',
        participant1Id: 'current_user',
        participant2Id: 'user4',
        lastMessage: MessageModel(
          id: 'msg4',
          senderId: 'user4',
          receiverId: 'current_user',
          content: '🎵 Audio',
          type: MessageType.audio,
          status: MessageStatus.read,
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          duration: 30,
        ),
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 0,
      ),
      ConversationModel(
        id: '5',
        participant1Id: 'current_user',
        participant2Id: 'user5',
        lastMessage: MessageModel(
          id: 'msg5',
          senderId: 'user5',
          receiverId: 'current_user',
          content: '🎥 Video',
          type: MessageType.video,
          status: MessageStatus.delivered,
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          mediaUrl: 'https://via.placeholder.com/400x300',
          duration: 45,
        ),
        lastMessageTime: DateTime.now().subtract(const Duration(days: 3)),
        unreadCount: 1,
      ),
    ];
  }

  static List<MessageModel> getMockMessages(String conversationId) {
    return [
      MessageModel(
        id: '1',
        senderId: 'current_user',
        receiverId: conversationId,
        content: 'Hello! How are you?',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      MessageModel(
        id: '2',
        senderId: conversationId,
        receiverId: 'current_user',
        content: 'Hi! I\'m doing great, thanks for asking. How about you?',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      ),
      MessageModel(
        id: '3',
        senderId: 'current_user',
        receiverId: conversationId,
        content: 'I\'m good too! Just working on some new features.',
        type: MessageType.text,
        status: MessageStatus.read,
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
      ),
      MessageModel(
        id: '4',
        senderId: conversationId,
        receiverId: 'current_user',
        content: 'That sounds interesting! Can you tell me more about it?',
        type: MessageType.text,
        status: MessageStatus.delivered,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      MessageModel(
        id: '5',
        senderId: 'current_user',
        receiverId: conversationId,
        content: '📷 Image',
        type: MessageType.image,
        status: MessageStatus.sent,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        mediaUrl: 'https://via.placeholder.com/300x200',
      ),
    ];
  }
} 