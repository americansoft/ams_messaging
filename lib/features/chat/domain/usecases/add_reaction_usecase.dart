import '../repository/chat_repository.dart';

class AddReactionUseCase {
  final ChatRepository repository;

  AddReactionUseCase(this.repository);

  Future<void> call(String messageId, String emoji) async {
    await repository.addReaction(messageId, emoji);
  }
} 