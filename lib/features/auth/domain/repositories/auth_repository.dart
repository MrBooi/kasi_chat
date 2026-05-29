import 'dart:io';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

/// Domain interface for authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<supabase_flutter.User?> signIn({
    required String email,
    required String password,
  });
  /// Sign up with email, password and username
  Future<supabase_flutter.User?> signUp({
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
  supabase_flutter.User? getCurrentUser();
  /// Watch auth state changes
  Stream<supabase_flutter.AuthState> get onAuthStateChange;
  /// Get the current user's details as a domain User entity
  Future<User> getCurrentUserProfile();
}
