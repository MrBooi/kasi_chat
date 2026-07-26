import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class GetUserByIdUseCase {
  GetUserByIdUseCase(this._repository);
  final ChatRepository _repository;
  Future<User?> call(String userId) {
    return _repository.getUserById(userId);
  }
}
