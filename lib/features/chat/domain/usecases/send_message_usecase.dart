import 'package:dartz/dartz.dart';
import '../entities/message.dart';
import '../repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<String, Message>> call(Message message) async {
    return await repository.sendMessage(message);
  }
} 