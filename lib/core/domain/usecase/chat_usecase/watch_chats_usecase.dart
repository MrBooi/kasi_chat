import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class WatchChatsUseCase {
  WatchChatsUseCase(this._repository);
  final ChatRepository _repository;
  Stream<List<Chat>> call() {
    return _repository.watchChats();
  }
}
