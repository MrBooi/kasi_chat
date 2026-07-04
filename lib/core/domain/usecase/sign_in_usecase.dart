import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';


class SignInUseCase {
  SignInUseCase(this._repository);
  final AuthRepository _repository;
  Future<User?> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
