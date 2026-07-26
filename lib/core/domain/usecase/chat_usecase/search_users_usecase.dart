import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class SearchUsersUseCase {
  SearchUsersUseCase(this._repository);
  final ChatRepository _repository;
  Future<List<User>> call(String query) {
    return _repository.searchUsers(query);
  }
}
