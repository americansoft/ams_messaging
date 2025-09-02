import 'package:dartz/dartz.dart';
import '../entities/conversation.dart';
import '../repository/chat_repository.dart';

class GetConversationsUseCase {
  final ChatRepository repository;

  GetConversationsUseCase(this.repository);

  Future<Either<String, List<Conversation>>> call() async {
    return await repository.getConversations();
  }
} 