import 'dart:io';

import 'package:kasi_chat/features/auth/domain/domain.dart';

class UpdateProfileUseCase {
  UpdateProfileUseCase(this._repository);
  final AuthRepository _repository;

  Future<void> call({required String username, File? avatarFile}) {
    return _repository.updateProfile(
      username: username,
      avatarFile: avatarFile,
    );
  }
}
