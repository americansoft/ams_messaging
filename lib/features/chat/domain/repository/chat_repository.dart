import '../entities/message.dart';
import '../entities/conversation.dart';

abstract class ChatRepository {
  // Basic message operations
  Future<List<Message>> getMessages(String conversationId);
  Future<Message> sendMessage(Message message);
  Future<void> deleteMessage(String messageId);
  Future<Message> forwardMessage(String messageId, String targetConversationId);
  
  // Conversation operations
  Future<List<Conversation>> getConversations();
  Future<Conversation> getConversation(String conversationId);
  Future<void> deleteConversation(String conversationId);
  Future<void> markConversationAsRead(String conversationId);
  Future<int> getUnreadCount(String conversationId);
  
  // Message status operations
  Future<void> markMessageAsRead(String messageId);
  Future<void> markMessageAsDelivered(String messageId);
  
  // Reactions
  Future<void> addReaction(String messageId, String emoji);
  Future<void> removeReaction(String messageId, String emoji);
  
  // Search
  Future<List<Message>> searchMessages(String query, {String? conversationId});
  Future<List<Conversation>> searchConversations(String query);
  
  // File operations
  Future<String> uploadFile(String filePath, String conversationId);
  Future<String> downloadMedia(String mediaUrl, String fileName);
  
  // Real-time streams
  Stream<List<Message>> watchMessages(String conversationId);
  Stream<List<Conversation>> watchConversations();
  Stream<int> watchUnreadCount(String conversationId);
  
  // Message replies
  Future<Message> replyToMessage(String originalMessageId, Message replyMessage);
  
  // Typing indicators
  Future<void> sendTypingIndicator(String conversationId, bool isTyping);
  Stream<bool> watchTypingIndicator(String conversationId, String userId);
} 