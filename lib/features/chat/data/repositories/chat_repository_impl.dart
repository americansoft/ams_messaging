import 'package:dartz/dartz.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasources/remote/chat_api_service.dart';
import '../models/message_model.dart';
import '../models/conversation_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiService apiService;

  ChatRepositoryImpl(this.apiService);

  @override
  Future<Either<String, List<Message>>> getMessages(String conversationId) async {
    try {
      final messages = await apiService.getMessages(conversationId);
      return Right(messages.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Message>> sendMessage(Message message) async {
    try {
      final messageModel = MessageModel.fromEntity(message);
      final sentMessage = await apiService.sendMessage(messageModel);
      return Right(sentMessage.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markMessageAsRead(String messageId) async {
    try {
      await apiService.markMessageAsRead(messageId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteMessage(String messageId) async {
    try {
      await apiService.deleteMessage(messageId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> forwardMessage(String messageId, List<String> conversationIds) async {
    try {
      // Implementation for forwarding messages
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Conversation>>> getConversations() async {
    try {
      final conversations = await apiService.getConversations();
      return Right(conversations.map((c) => c.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Conversation>> getConversation(String conversationId) async {
    try {
      final conversation = await apiService.getConversation(conversationId);
      return Right(conversation.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Conversation>> createConversation(String participant1Id, String participant2Id) async {
    try {
      // Implementation for creating conversation
      final conversation = ConversationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        participant1Id: participant1Id,
        participant2Id: participant2Id,
        lastMessageTime: DateTime.now(),
      );
      return Right(conversation.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteConversation(String conversationId) async {
    try {
      // Implementation for deleting conversation
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markConversationAsRead(String conversationId) async {
    try {
      await apiService.markConversationAsRead(conversationId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, int>> getUnreadCount(String conversationId) async {
    try {
      // Implementation for getting unread count
      return const Right(0);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<List<Message>> watchMessages(String conversationId) {
    // Implementation for real-time message updates
    return Stream.empty();
  }

  @override
  Stream<List<Conversation>> watchConversations() {
    // Implementation for real-time conversation updates
    return Stream.empty();
  }

  @override
  Stream<int> watchUnreadCount(String conversationId) {
    // Implementation for real-time unread count updates
    return Stream.empty();
  }

  @override
  Future<Either<String, String>> uploadMedia(String filePath, String conversationId) async {
    try {
      final mediaUrl = await apiService.uploadMedia(filePath, conversationId);
      return Right(mediaUrl);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> downloadMedia(String mediaUrl, String localPath) async {
    try {
      // Implementation for downloading media
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
} 