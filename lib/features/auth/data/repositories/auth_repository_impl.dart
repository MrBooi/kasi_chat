
import 'dart:io';

import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/domain/entities/user.dart';
import 'package:kasi_chat/features/auth/domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

/// Concrete implementation of AuthRepository calling RemoteDataSource
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);
  final RemoteDataSource _remoteDataSource;
  @override
  Future<supabase_flutter.User?> signIn({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signIn(email: email, password: password);
  }
  @override
  Future<supabase_flutter.User?> signUp({
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
    final user = _remoteDataSource.client.auth.currentUser;
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
  supabase_flutter.User? getCurrentUser() {
    return _remoteDataSource.client.auth.currentUser;
  }
  @override
  Stream<supabase_flutter.AuthState> get onAuthStateChange {
    return _remoteDataSource.client.auth.onAuthStateChange;
  }
  @override
  Future<User> getCurrentUserProfile() async {
    final user = getCurrentUser();
    if (user == null) {
      throw Exception('Not authenticated');
    }
    final response = await _remoteDataSource.client
        .from('users')
        .select()
        .eq('id', user.id)
        .single();
    return (response as Map<String, dynamic>).toUser();
  }
}
