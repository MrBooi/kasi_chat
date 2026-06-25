import 'package:drift/drift.dart';

class MessagesTable extends Table {
  TextColumn get id => text()();
  TextColumn get chatId => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get type => text()();
  TextColumn get fileUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
