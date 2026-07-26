import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class CreateChatUseCase {
  CreateChatUseCase(this._repository);
  final ChatRepository _repository;
  Future<String> call(String userId) {
    return _repository.createChat([userId]);
  }
}
