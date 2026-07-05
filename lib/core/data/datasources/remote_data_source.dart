import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';

/// Data source interface for remote operations (Supabase)
abstract class RemoteDataSource {
  Stream<User> get onAuthStateChange;

  User? get currentUser;

  /// Authenticate user via email/password
  Future<User?> signIn({
    required String email,
    required String password,
  });

  /// Create new user via email/password/username
  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  });

  /// Sign out current user
  Future<void> signOut();

  /// Reset password for email
  Future<void> resetPassword(String email);

  /// Update user profile details in public users table
  Future<void> updateProfile({
    required String userId,
    required String username,
    String? avatarUrl,
  });

  /// Upload avatar to storage bucket
  Future<String?> uploadAvatar({
    required String userId,
    required File file,
  });

  /// Upload generic file to storage bucket
  Future<String?> uploadFile({
    required XFile file,
    required MessageType type,
    required String chatId,
  });

  /// Update user online status
  Future<void> updateUserStatus({required bool isOnline});

  /// Get current user profile from public users table
  Future<User> getCurrentUserProfile(String userId);
}
