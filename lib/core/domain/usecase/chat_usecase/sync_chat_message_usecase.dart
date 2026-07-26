import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class SyncChatMessagesUseCase {
  SyncChatMessagesUseCase(this._repository);
  final ChatRepository _repository;
  Future<void> call(String chatId) {
    return _repository.syncChatMessages(chatId);
  }
}
