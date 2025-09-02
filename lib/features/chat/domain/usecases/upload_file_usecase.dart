import '../repository/chat_repository.dart';

class UploadFileUseCase {
  final ChatRepository repository;

  UploadFileUseCase(this.repository);

  Future<String> call(String filePath, String conversationId) async {
    return await repository.uploadFile(filePath, conversationId);
  }
} 