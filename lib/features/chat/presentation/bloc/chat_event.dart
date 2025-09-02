import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadConversations extends ChatEvent {
  const LoadConversations();
}

class LoadMessages extends ChatEvent {
  final String conversationId;

  const LoadMessages(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class SendMessage extends ChatEvent {
  final Message message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class AddReaction extends ChatEvent {
  final String messageId;
  final String emoji;

  const AddReaction(this.messageId, this.emoji);

  @override
  List<Object?> get props => [messageId, emoji];
}

class RemoveReaction extends ChatEvent {
  final String messageId;
  final String emoji;

  const RemoveReaction(this.messageId, this.emoji);

  @override
  List<Object?> get props => [messageId, emoji];
}

class SearchMessages extends ChatEvent {
  final String query;
  final String? conversationId;

  const SearchMessages(this.query, {this.conversationId});

  @override
  List<Object?> get props => [query, conversationId];
}

class UploadFile extends ChatEvent {
  final String filePath;
  final String conversationId;
  final MessageType messageType;

  const UploadFile(this.filePath, this.conversationId, this.messageType);

  @override
  List<Object?> get props => [filePath, conversationId, messageType];
}

class MarkMessageAsRead extends ChatEvent {
  final String messageId;

  const MarkMessageAsRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class SendTypingIndicator extends ChatEvent {
  final String conversationId;
  final bool isTyping;

  const SendTypingIndicator(this.conversationId, this.isTyping);

  @override
  List<Object?> get props => [conversationId, isTyping];
}

class ReplyToMessage extends ChatEvent {
  final String originalMessageId;
  final Message replyMessage;

  const ReplyToMessage(this.originalMessageId, this.replyMessage);

  @override
  List<Object?> get props => [originalMessageId, replyMessage];
}

class ForwardMessage extends ChatEvent {
  final String messageId;
  final String targetConversationId;

  const ForwardMessage(this.messageId, this.targetConversationId);

  @override
  List<Object?> get props => [messageId, targetConversationId];
} 