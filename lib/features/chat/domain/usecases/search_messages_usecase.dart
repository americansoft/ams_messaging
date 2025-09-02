import '../entities/message.dart';
import '../repository/chat_repository.dart';

class SearchMessagesUseCase {
  final ChatRepository repository;

  SearchMessagesUseCase(this.repository);

  Future<List<Message>> call(String query, {String? conversationId}) async {
    return await repository.searchMessages(query, conversationId: conversationId);
  }
} 