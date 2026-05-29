import 'package:image_picker/image_picker.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/data/database/app_database.dart';
import 'package:kasi_chat/core/data/datasources/remote_data_source.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_flutter;

/// Concrete implementation of ChatRepository coordinating Remote and Local data sources
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource, this._db);
  final RemoteDataSource _remoteDataSource;
  final AppDatabase _db;
  supabase_flutter.SupabaseClient get _client => _remoteDataSource.client;
  @override
  String get currentUserId => _client.auth.currentUser?.id ?? '';
  
  final List<supabase_flutter.RealtimeChannel> _subscriptions = [];
  
  @override
  Future<void> initialize() async {
    await syncUsers();
    await syncChats();
    setupRealtimeSync();
  }

  @override
  Future<void> syncUsers() async {
    try {
      final response = await _client.from('users').select();
      for (final user in response) {
        await _db.upsertUser(user.toUser());
      }
    } catch (e) {
      logE('Error syncing users: $e');
    }
  }

  @override
  Future<void> syncChats() async {
    try {
      final userId = currentUserId;
      if (userId.isEmpty) return;
      final response =
          await _client.from('chats').select().contains('user_ids', [userId]);
      for (final chatData in response) {
        await _db.upsertChat(chatData.toChat());
      }
      for (final chat in response) {
        await syncChatMessages(chat['id'] as String);
      }
    } catch (e) {
      logE('Error syncing chats: $e');
    }
  }

  @override
  Future<void> syncChatMessages(String chatId) async {
    try {
      final response = await _client
          .from('messages')
          .select()
          .eq('chat_id', chatId)
          .order('created_at');
      for (final messageData in response) {
        await _db.upsertMessage(messageData.toMessage());
      }
    } catch (e) {
      logE('Error syncing messages for chat $chatId: $e');
    }
  }

  @override
  void setupRealtimeSync() {
    final userId = currentUserId;
    if (userId.isEmpty) return;
    final channel = _client.channel('db-changes')
    ..onPostgresChanges(
      event: supabase_flutter.PostgresChangeEvent.all,
      schema: 'public',
      table: 'chats',
      filter: supabase_flutter.PostgresChangeFilter(
        type: supabase_flutter.PostgresChangeFilterType.inFilter,
        column: 'user_ids',
        value: [userId],
      ),
      callback: (payload) async {
        if (payload.eventType == supabase_flutter.PostgresChangeEvent.insert ||
            payload.eventType == supabase_flutter.PostgresChangeEvent.update) {
          final chatData = payload.newRecord;
          await _db.upsertChat(chatData.toChat());
        } else if (payload.eventType ==
            supabase_flutter.PostgresChangeEvent.update) {
          final chatId = payload.oldRecord['id'] as String;
          await _db.deleteChat(chatId);
        }
      },
    )
    ..onPostgresChanges(
      event: supabase_flutter.PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      callback: (payload) async {
        final messageData = payload.newRecord;
        final chatId = messageData['chat_id'] as String;
        final chat = await _db.getChatById(chatId);
        if (chat != null) {
          await _db.upsertMessage(messageData.toMessage());
        }
      },
    );
    final subscription = channel.subscribe();
    _subscriptions.add(subscription);
  }

  @override
  Future<List<Chat>> getChats() async {
    try {
      return await _db.getAllChats();
    } catch (e) {
      logE('Error getting chats: $e');
      return [];
    }
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    try {
      return await _db.getChatMessages(chatId);
    } catch (e) {
      logE('Error getting messages: $e');
      return [];
    }
  }

  @override
  Stream<List<Message>> watchMessages(String chatId) =>
      _db.watchChatMessages(chatId);

  @override
  Stream<List<Chat>> watchChats() => _db.watchAllChats();
  @override
  Future<Chat?> getChatById(String chatId) async => _db.getChatById(chatId);

  @override
  Future<List<String>> getChatUserIds(String chatId) async {
    final chat = await _db.getChatById(chatId);
    return chat?.userIds ?? [];
  }

  @override
  Future<User?> getUserById(String userId) async => _db.getUserById(userId);

  @override
  Future<List<User>> searchUsers(String query) async {
    try {
      final currentId = currentUserId;
      if (query.isEmpty) return [];
      final response = await _client
          .from('users')
          .select()
          .neq('id', currentId)
          .or('username.ilike.%$query%,email.ilike.%$query%')
          .limit(20);
      final users = response
          .map<User>(
            (userData) => User(
              id: userData['id'] as String,
              email: userData['email'] as String,
              username: userData['username'] as String,
              avatarUrl: userData['avatar_url'] as String?,
              isOnline: userData['is_online'] as bool? ?? false,
            ),
          )
          .toList();
      for (final user in users) {
        await _db.upsertUser(user);
      }
      return users;
    } catch (e) {
      logE('Error searching users: $e');
      throw Exception('Failed to search users: $e');
    }
  }

  @override
  Future<String> createChat(List<String> userIds) async {
    final userId = currentUserId;
    if (userId.isEmpty) throw Exception('User not authenticated');
    if (!userIds.contains(userId)) {
      userIds.add(userId);
    }
    if (userIds.length == 2) {
      final existingChats = await _db.getAllChats();
      for (final chat in existingChats) {
        final chatUserIds = chat.userIds;
        if (chatUserIds.length == 2 &&
            chatUserIds.contains(userIds[0]) &&
            chatUserIds.contains(userIds[1])) {
          return chat.id;
        }
      }
    }
    try {
      final response = await _client
          .from('chats')
          .insert({
            'user_ids': userIds,
            'name': null,
          })
          .select('id')
          .single();
      final chatId = response['id'] as String;
      final chatData =
          await _client.from('chats').select().eq('id', chatId).single();
      await _db.upsertChat(chatData.toChat());
      return chatId;
    } catch (e) {
      logE('Error creating chat: $e');
      throw Exception('Failed to create chat: $e');
    }
  }

  @override
  Future<void> deleteChat(String chatId) async {
    try {
      await _client.from('chats').delete().eq('id', chatId);
      await _db.deleteChat(chatId);
    } catch (e) {
      logE('Error deleting chat: $e');
      throw Exception('Failed to delete chat: $e');
    }
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required String content,
    MessageType type = MessageType.text,
    String? fileUrl,
  }) async {
    final userId = currentUserId;
    if (userId.isEmpty) throw Exception('User not authenticated');
    try {
      final responseMessage = await _client
          .from('messages')
          .insert({
            'chat_id': chatId,
            'user_id': userId,
            'content': content,
            'type': type.name,
            'file_url': fileUrl,
          })
          .select()
          .single();
          
      final responseChat = await _client.from('chats').select().eq('id', chatId).single();
      
      await _db.upsertMessage(responseMessage.toMessage());
      await _db.upsertChat(responseChat.toChat());
    } catch (e) {
      logE('Error sending message: $e');
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<String?> uploadFile(dynamic file, MessageType type, String chatId) async {
    if (file is! XFile) {
      throw ArgumentError('File must be an XFile');
    }
    return _remoteDataSource.uploadFile(file: file, type: type, chatId: chatId);
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      final currentId = currentUserId;
      final response = await _client
          .from('users')
          .select()
          .neq('id', currentId);
      
      final users = response.map<User>((userData) => userData.toUser()).toList();
      
      for (final user in users) {
        await _db.upsertUser(user);
      }
      return users;
    } catch (e) {
      logE('Error getting users: $e');
      throw Exception('Failed to get users: $e');
    }
  }

  @override
  Future<void> updateUserStatus({required bool isOnline}) async {
    await _remoteDataSource.updateUserStatus(isOnline: isOnline);
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.unsubscribe();
    }
    _subscriptions.clear();
  }
}

extension on supabase_flutter.PostgrestMap {
  Message toMessage() {}
}
