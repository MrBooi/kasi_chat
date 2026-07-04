import 'package:kasi_chat/core/domain/domain.dart';
class SignOutUseCase {
  SignOutUseCase(this._repository);
  final AuthRepository _repository;
  Future<void> call() {
    return _repository.signOut();
  }
}
