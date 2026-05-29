import 'package:kasi_chat/core/domain/entities/entities.dart';

abstract class AppDatabase {
 
  Future<void> upsertUser(User user);
  Future<User?> getUserById(String userId);
  Future<List<User>> getAllUsers();

  Future<void> upsertChat(Chat chat);
  Future<Chat?> getChatById(String chatId);
  Future<List<Chat>> getAllChats();
  Stream<List<Chat>> watchAllChats();
  Future<void> deleteChat(String chatId);

  Future<void> upsertMessage(Message message);
  Future<List<Message>> getChatMessages(String chatId);
  Stream<List<Message>> watchChatMessages(String chatId);

  Future<void> close();
}