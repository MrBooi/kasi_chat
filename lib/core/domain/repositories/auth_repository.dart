import 'dart:io';
import 'package:kasi_chat/core/domain/entities/entities.dart';

/// Domain interface for authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  });
  /// Sign up with email, password and username
  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  });
  /// Sign out the current user
  Future<void> signOut();
  /// Reset password for a given email
  Future<void> resetPassword(String email);
  /// Update the current user's profile info and avatar file
  Future<void> updateProfile({
    required String username,
    File? avatarFile,
  });
  /// Get the currently authenticated Supabase user
  User? getCurrentUser();
  /// Watch auth state changes
  Stream<User?> get onAuthStateChange;
  /// Get the current user's details as a domain User entity
  Future<User> getCurrentUserProfile();
}
