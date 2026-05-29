import 'package:kasi_chat/features/auth/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

class GetCurrentUserUseCase {
  
  const GetCurrentUserUseCase(this._repository);
  final AuthRepository _repository;
  supabase_flutter.User? call() {
    return _repository.getCurrentUser();
  }
}
