import 'package:kasi_chat/core/domain/entities/user.dart';
import 'package:kasi_chat/features/auth/domain/domain.dart';

class UserChangeUsecase {
  UserChangeUsecase(this._repository);
  final AuthRepository _repository;

  Stream<User?> call() {
    return _repository.onAuthStateChange;
  }
}
