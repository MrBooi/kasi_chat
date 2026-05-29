import 'package:kasi_chat/features/auth/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

class SignUpUseCase {
  SignUpUseCase(this._repository);
  final AuthRepository _repository;
  Future<supabase_flutter.User?> call({
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
