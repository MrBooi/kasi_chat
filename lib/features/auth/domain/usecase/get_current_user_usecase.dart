import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/auth/domain/domain.dart';

class GetCurrentUserUseCase {
  
  const GetCurrentUserUseCase(this._repository);
  final AuthRepository _repository;
  User? call() {
    return _repository.getCurrentUser();
  }
}
