import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class DeleteChatUseCase {
  DeleteChatUseCase(this._repository);
  final ChatRepository _repository;
  Future<void> call(String chatId) {
    return _repository.deleteChat(chatId);
  }
}
