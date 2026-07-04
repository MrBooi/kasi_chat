import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';


class SignUpUseCase {
  SignUpUseCase(this._repository);
  final AuthRepository _repository;
  Future<User?> call({
    required String email,
    required String password,
    required String username,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      username: username,
    );
  }
}
