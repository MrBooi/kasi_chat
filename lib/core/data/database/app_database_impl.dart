import 'package:drift/drift.dart';
import 'package:kasi_chat/core/data/database/database.dart';
import 'package:kasi_chat/core/domain/entities/chat.dart';
import 'package:kasi_chat/core/domain/entities/message.dart';
import 'package:kasi_chat/core/domain/entities/user.dart';


@DriftDatabase(tables: [UsersTable, ChatsTable, MessagesTable])
class AppDatabaseImpl implements AppDatabase {
  AppDatabaseImpl() : super();

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChat(String chatId) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<List<Chat>> getAllChats() {
    // TODO: implement getAllChats
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Chat?> getChatById(String chatId) {
    // TODO: implement getChatById
    throw UnimplementedError();
  }

  @override
  Future<List<Message>> getChatMessages(String chatId) {
    // TODO: implement getChatMessages
    throw UnimplementedError();
  }

  @override
  Future<User?> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<void> upsertChat(Chat chat) {
    // TODO: implement upsertChat
    throw UnimplementedError();
  }

  @override
  Future<void> upsertMessage(Message message) {
    // TODO: implement upsertMessage
    throw UnimplementedError();
  }

  @override
  Future<void> upsertUser(User user) {
    // TODO: implement upsertUser
    throw UnimplementedError();
  }

  @override
  Stream<List<Chat>> watchAllChats() {
    // TODO: implement watchAllChats
    throw UnimplementedError();
  }

  @override
  Stream<List<Message>> watchChatMessages(String chatId) {
    // TODO: implement watchChatMessages
    throw UnimplementedError();
  }
}
