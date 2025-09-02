import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/usecases/get_conversations_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/add_reaction_usecase.dart';
import '../../domain/usecases/search_messages_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetConversationsUseCase getConversationsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final AddReactionUseCase addReactionUseCase;
  final SearchMessagesUseCase searchMessagesUseCase;
  final UploadFileUseCase uploadFileUseCase;

  ChatBloc({
    required this.getConversationsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.addReactionUseCase,
    required this.searchMessagesUseCase,
    required this.uploadFileUseCase,
  }) : super(ChatInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<AddReaction>(_onAddReaction);
    on<RemoveReaction>(_onRemoveReaction);
    on<SearchMessages>(_onSearchMessages);
    on<UploadFile>(_onUploadFile);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
    on<SendTypingIndicator>(_onSendTypingIndicator);
    on<ReplyToMessage>(_onReplyToMessage);
    on<ForwardMessage>(_onForwardMessage);
  }

  Future<void> _onLoadConversations(
    LoadConversations event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final conversations = await getConversationsUseCase();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final messages = await getMessagesUseCase(event.conversationId);
      emit(MessagesLoaded(messages, event.conversationId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final message = await sendMessageUseCase(event.message);
      emit(MessageSent(message));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onAddReaction(
    AddReaction event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await addReactionUseCase(event.messageId, event.emoji);
      emit(ReactionAdded(event.messageId, event.emoji));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onRemoveReaction(
    RemoveReaction event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // TODO: Implement remove reaction use case
      emit(ReactionAdded(event.messageId, event.emoji));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSearchMessages(
    SearchMessages event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoading());
      final messages = await searchMessagesUseCase(
        event.query,
        conversationId: event.conversationId,
      );
      emit(SearchResultsLoaded(messages, event.query));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onUploadFile(
    UploadFile event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(FileUploading(0.0, event.filePath.split('/').last));
      
      // Simulate upload progress
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        emit(FileUploading(i / 10, event.filePath.split('/').last));
      }
      
      final fileUrl = await uploadFileUseCase(event.filePath, event.conversationId);
      emit(FileUploaded(fileUrl, event.messageType));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onMarkMessageAsRead(
    MarkMessageAsRead event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // TODO: Implement mark message as read
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendTypingIndicator(
    SendTypingIndicator event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // TODO: Implement typing indicator
      emit(TypingIndicator(event.conversationId, 'current_user', event.isTyping));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onReplyToMessage(
    ReplyToMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // TODO: Implement reply to message
      final message = await sendMessageUseCase(event.replyMessage);
      emit(MessageSent(message));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onForwardMessage(
    ForwardMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // TODO: Implement forward message
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
} 