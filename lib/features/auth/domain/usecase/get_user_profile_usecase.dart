
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/auth/domain/domain.dart';

class GetUserProfileUseCase {

  GetUserProfileUseCase(this._repository);
  final AuthRepository _repository;
  Future<User> call() {
    return _repository.getCurrentUserProfile();
  }
}