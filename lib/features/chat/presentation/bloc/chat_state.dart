import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<Conversation> conversations;

  const ConversationsLoaded(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class MessagesLoaded extends ChatState {
  final List<Message> messages;
  final String conversationId;

  const MessagesLoaded(this.messages, this.conversationId);

  @override
  List<Object?> get props => [messages, conversationId];
}

class MessageSent extends ChatState {
  final Message message;

  const MessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchResultsLoaded extends ChatState {
  final List<Message> messages;
  final String query;

  const SearchResultsLoaded(this.messages, this.query);

  @override
  List<Object?> get props => [messages, query];
}

class FileUploading extends ChatState {
  final double progress;
  final String fileName;

  const FileUploading(this.progress, this.fileName);

  @override
  List<Object?> get props => [progress, fileName];
}

class FileUploaded extends ChatState {
  final String fileUrl;
  final MessageType messageType;

  const FileUploaded(this.fileUrl, this.messageType);

  @override
  List<Object?> get props => [fileUrl, messageType];
}

class ReactionAdded extends ChatState {
  final String messageId;
  final String emoji;

  const ReactionAdded(this.messageId, this.emoji);

  @override
  List<Object?> get props => [messageId, emoji];
}

class TypingIndicator extends ChatState {
  final String conversationId;
  final String userId;
  final bool isTyping;

  const TypingIndicator(this.conversationId, this.userId, this.isTyping);

  @override
  List<Object?> get props => [conversationId, userId, isTyping];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
} 