import 'package:kasi_chat/core/domain/domain.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase(this._repository);
  final AuthRepository _repository;
  Future<void> call(String email) {
    return _repository.resetPassword(email);
  }
}
