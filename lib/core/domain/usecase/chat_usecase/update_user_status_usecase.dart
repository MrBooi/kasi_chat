import 'package:kasi_chat/core/domain/repositories/chat_repository.dart';

class UpdateUserStatusUseCase {
  UpdateUserStatusUseCase(this._repository);
  final ChatRepository _repository;
  Future<void> call({required bool isOnline}) {
    return _repository.updateUserStatus(isOnline: isOnline);
  }
}
