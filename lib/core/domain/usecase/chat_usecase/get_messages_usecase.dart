import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class GetMessagesUseCase {

  GetMessagesUseCase(this._repository);
  final ChatRepository _repository;
  Future<List<Message>> call(String chatId) {
    return _repository.getMessages(chatId);
  }
}
