import 'package:kasi_chat/core/domain/entities/entities.dart';

/// Domain interface for chat and messaging operations
abstract class ChatRepository {
  /// Get the current authenticated user's ID
  String get currentUserId;
  /// Initialize repositories (sync users, chats, and setup realtime sync)
  Future<void> initialize();
  /// Synchronize users list from remote database to local database
  Future<void> syncUsers();
  /// Synchronize chats list from remote database to local database
  Future<void> syncChats();
  /// Synchronize messages for a specific chat from remote to local database
  Future<void> syncChatMessages(String chatId);
  /// Configure and subscribe to realtime updates on tables
  void setupRealtimeSync();
  /// Get chats list from local database
  Future<List<Chat>> getChats();
  /// Get messages for a specific chat from local database
  Future<List<Message>> getMessages(String chatId);
  /// Watch messages stream for a specific chat
  Stream<List<Message>> watchMessages(String chatId);
  /// Watch chats stream
  Stream<List<Chat>> watchChats();
  /// Get a specific chat details by ID
  Future<Chat?> getChatById(String chatId);
  /// Get user IDs associated with a specific chat
  Future<List<String>> getChatUserIds(String chatId);
  /// Get details of a user by ID
  Future<User?> getUserById(String userId);
  /// Search users matching the search query
  Future<List<User>> searchUsers(String query);
  /// Create a new chat with the specified user IDs
  Future<String> createChat(List<String> userIds);
  /// Delete a chat by ID
  Future<void> deleteChat(String chatId);
  /// Send a message within a chat
  Future<void> sendMessage({
    required String chatId,
    required String content,
    MessageType type = MessageType.text,
    String? fileUrl,
  });
  /// Upload a file for a chat message
  Future<String?> uploadFile(dynamic file, MessageType type, String chatId);
  /// Get all users from remote database
  Future<List<User>> getUsers();
  /// Update the current user status on the server
  Future<void> updateUserStatus({required bool isOnline});
  /// Dispose listeners and active streams
  void dispose();
}
