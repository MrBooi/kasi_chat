import 'package:kasi_chat/features/auth/domain/domain.dart';

class SignOutUseCase {
  SignOutUseCase(this._repository);
  final AuthRepository _repository;
  Future<void> call() {
    return _repository.signOut();
  }
}
