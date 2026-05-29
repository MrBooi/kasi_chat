import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class GetChatUserIdsUseCase {
  GetChatUserIdsUseCase(this._repository);
  final ChatRepository _repository;
  Future<List<String>> call(String chatId) {
    return _repository.getChatUserIds(chatId);
  }
}
