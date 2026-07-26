import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class SyncChatsUseCase {

  SyncChatsUseCase(this._repository);
  final ChatRepository _repository;
  Future<void> call() {
    return _repository.syncChats();
  }
}
