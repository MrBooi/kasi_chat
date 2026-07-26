import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class UploadFileUseCase {

  UploadFileUseCase(this._repository);
  final ChatRepository _repository;
  Future<String?> call(dynamic file, MessageType type, String chatId) {
    return _repository.uploadFile(file, type, chatId);
  }
}
