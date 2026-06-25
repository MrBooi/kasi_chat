import 'package:drift/drift.dart';

class ChatsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get userIds => text()(); // Stored as JSON string
  TextColumn get lastMessageText => text().nullable()();
  TextColumn get lastMessageUserId => text().nullable()();
  TextColumn get lastMessageType => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
