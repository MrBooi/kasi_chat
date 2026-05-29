import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class WatchMessagesUseCase {
  WatchMessagesUseCase(this._repository);
  final ChatRepository _repository;
  Stream<List<Message>> call(String chatId) {
    return _repository.watchMessages(chatId);
  }
}
