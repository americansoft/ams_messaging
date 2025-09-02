import 'package:dartz/dartz.dart';
import '../entities/message.dart';
import '../repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<String, List<Message>>> call(String conversationId) async {
    return await repository.getMessages(conversationId);
  }
} 