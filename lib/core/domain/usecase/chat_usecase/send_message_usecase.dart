import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  SendMessageUseCase(this._repository);
  final ChatRepository _repository;
  Future<void> call({
    required String chatId,
    required String content,
    MessageType type = MessageType.text,
    String? fileUrl,
  }) {
    return _repository.sendMessage(
      chatId: chatId,
      content: content,
      type: type,
      fileUrl: fileUrl,
    );
  }
}
