
import 'dart:io';
import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/entities/user.dart';

/// Concrete implementation of AuthRepository calling RemoteDataSource
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);
  final RemoteDataSource _remoteDataSource;
  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signIn(email: email, password: password);
  }
  @override
  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    return _remoteDataSource.signUp(
      email: email,
      password: password,
      username: username,
    );
  }
  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }
  @override
  Future<void> resetPassword(String email) {
    return _remoteDataSource.resetPassword(email);
  }
  @override
  Future<void> updateProfile({
    required String username,
    File? avatarFile,
  }) async {
    final user = _remoteDataSource.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    String? avatarUrl;
    if (avatarFile != null) {
      avatarUrl = await _remoteDataSource.uploadAvatar(
        userId: user.id,
        file: avatarFile,
      );
    }
    await _remoteDataSource.updateProfile(
      userId: user.id,
      username: username,
      avatarUrl: avatarUrl,
    );
  }
  @override
  User? getCurrentUser() {
    return _remoteDataSource.currentUser;
  }
  @override
  Stream<User?> get onAuthStateChange {
    return _remoteDataSource.onAuthStateChange;
  }
  @override
  Future<User> getCurrentUserProfile()  {
    final user = getCurrentUser();
    if (user == null) {
      throw Exception('Not authenticated');
    }
    return _remoteDataSource.getCurrentUserProfile(user.id);
  }
}
