import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kasi_chat/core/config/logger.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;
import 'package:uuid/uuid.dart';

/// Concrete implementation of RemoteDataSource using Supabase
class RemoteDataSourceImpl implements RemoteDataSource {
  const RemoteDataSourceImpl(this.client);
  final supabase_flutter.SupabaseClient client;

  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user.fromSupabaseUser();
  }

  @override
  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );

    if (response.user != null) {
      await client.from('users').insert({
        'id': response.user!.id,
        'email': email,
        'username': username,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
    return response.user.fromSupabaseUser();
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updateProfile({
    required String userId,
    required String username,
    String? avatarUrl,
  }) async {
    await client
        .from('users')
        .update({
          'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
        })
        .eq('id', userId);
  }

  @override
  Future<String?> uploadAvatar({
    required String userId,
    required File file,
  }) async {
    final fileExt = path.extension(file.path);
    final fileName = '$userId$fileExt';
    await client.storage
        .from('avatars')
        .upload(
          fileName,
          file,
          fileOptions: const supabase_flutter.FileOptions(upsert: true),
        );
    return client.storage.from('avatars').getPublicUrl(fileName);
  }

  @override
  Future<String?> uploadFile({
    required XFile file,
    required MessageType type,
    required String chatId,
  }) async {
    try {
      final actualFile = File(file.path);
      final bucketName = type.name;
      final userId = client.auth.currentUser?.id ?? 'anonymous';
      final fileName = '${const Uuid().v4()}${path.extension(actualFile.path)}';
      final filePath = '$userId/$chatId/$fileName';
      await client.storage
          .from(bucketName)
          .upload(
            filePath,
            actualFile,
            fileOptions: const supabase_flutter.FileOptions(upsert: true),
          );
      return client.storage.from(bucketName).getPublicUrl(filePath);
    } catch (e) {
      logE('Error uploading file: $e');
      throw Exception('Storage upload failed: $e');
    }
  }

  @override
  Future<void> updateUserStatus({required bool isOnline}) async {
    try {
      final user = client.auth.currentUser;
      if (user != null) {
        await client
            .from('users')
            .update({
              'is_online': isOnline,
            })
            .eq('id', user.id);
      }
    } catch (e) {
      logE('Error updating user status: $e');
    }
  }

  @override
  User? get currentUser => client.auth.currentUser.fromSupabaseUser();

  @override
  Stream<User> get onAuthStateChange => client.auth.onAuthStateChange.map((
    event,
  ) {
    final supabaseUser = event.session?.user;
     if(supabaseUser == null){
      return User.anonymous;
     }
    return supabaseUser.fromSupabaseUser()!;
  });
  
  @override
  Future<User> getCurrentUserProfile(String userId) async {
    final response = await client
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    return response.toUser();
  }
}
