import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import 'message_model.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.id,
    required super.participant1Id,
    required super.participant2Id,
    super.lastMessage,
    required super.lastMessageTime,
    super.unreadCount = 0,
    super.isGroup = false,
    super.groupName,
    super.groupAvatar,
    super.groupParticipants,
  });

  factory ConversationModel.fromEntity(Conversation conversation) {
    return ConversationModel(
      id: conversation.id,
      participant1Id: conversation.participant1Id,
      participant2Id: conversation.participant2Id,
      lastMessage: conversation.lastMessage,
      lastMessageTime: conversation.lastMessageTime,
      unreadCount: conversation.unreadCount,
      isGroup: conversation.isGroup,
      groupName: conversation.groupName,
      groupAvatar: conversation.groupAvatar,
      groupParticipants: conversation.groupParticipants,
    );
  }

  Conversation toEntity() {
    return Conversation(
      id: id,
      participant1Id: participant1Id,
      participant2Id: participant2Id,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
      unreadCount: unreadCount,
      isGroup: isGroup,
      groupName: groupName,
      groupAvatar: groupAvatar,
      groupParticipants: groupParticipants,
    );
  }
} 