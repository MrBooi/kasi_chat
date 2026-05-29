import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  CreateChatUseCase(this._repository);
  final ChatRepository _repository;
  Future<String> call(List<String> userIds) {
    return _repository.createChat(userIds);
  }
}
