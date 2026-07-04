import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';

class GetCurrentUserUseCase {
  
  const GetCurrentUserUseCase(this._repository);
  final AuthRepository _repository;
  User? call() {
    return _repository.getCurrentUser();
  }
}
