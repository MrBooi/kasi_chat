import 'package:kasi_chat/core/domain/entities/user.dart';
import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._repository);
  final ChatRepository _repository;
  Future<List<User>> call() {
    return _repository.getUsers();
  }
}
