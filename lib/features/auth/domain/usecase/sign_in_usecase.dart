import 'package:kasi_chat/features/auth/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

class SignInUseCase {
  SignInUseCase(this._repository);
  final AuthRepository _repository;
  Future<supabase_flutter.User?> call({
    required String email,
    required String password,
  }) {
    return _repository.signIn(email: email, password: password);
  }
}
