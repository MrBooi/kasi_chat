import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  
  GetChatsUseCase(this._repository);
  final ChatRepository _repository;
  Future<List<Chat>> call() {
    return _repository.getChats();
  }
}