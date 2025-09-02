import 'package:dio/dio.dart';
import '../../models/message_model.dart';
import '../../models/conversation_model.dart';
import 'mock_chat_data.dart';

abstract class ChatApiService {
  Future<List<ConversationModel>> getConversations();
  Future<ConversationModel> getConversation(String conversationId);
  Future<List<MessageModel>> getMessages(String conversationId);
  Future<MessageModel> sendMessage(MessageModel message);
  Future<void> markMessageAsRead(String messageId);
  Future<void> deleteMessage(String messageId);
  Future<void> markConversationAsRead(String conversationId);
  Future<String> uploadMedia(String filePath, String conversationId);
}

class ChatApiServiceImpl implements ChatApiService {
  final Dio dio;

  ChatApiServiceImpl(this.dio);

  @override
  Future<List<ConversationModel>> getConversations() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return MockChatData.getMockConversations();
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  @override
  Future<ConversationModel> getConversation(String conversationId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      final conversations = MockChatData.getMockConversations();
      return conversations.firstWhere((c) => c.id == conversationId);
    } catch (e) {
      throw Exception('Failed to get conversation: $e');
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      return MockChatData.getMockMessages(conversationId);
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage(MessageModel message) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 200));
      // For now, just return the same message with a new ID
      return MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: message.senderId,
        receiverId: message.receiverId,
        content: message.content,
        type: message.type,
        status: message.status,
        timestamp: DateTime.now(),
        mediaUrl: message.mediaUrl,
        thumbnailUrl: message.thumbnailUrl,
        duration: message.duration,
        metadata: message.metadata,
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<void> markMessageAsRead(String messageId) async {
    try {
      await dio.put('/messages/$messageId/read');
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      await dio.delete('/messages/$messageId');
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  @override
  Future<void> markConversationAsRead(String conversationId) async {
    try {
      await dio.put('/conversations/$conversationId/read');
    } catch (e) {
      throw Exception('Failed to mark conversation as read: $e');
    }
  }

  @override
  Future<String> uploadMedia(String filePath, String conversationId) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'conversationId': conversationId,
      });
      
      final response = await dio.post('/media/upload', data: formData);
      return response.data['data']['url'];
    } catch (e) {
      throw Exception('Failed to upload media: $e');
    }
  }
} 