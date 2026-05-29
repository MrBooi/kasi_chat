import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
@immutable
class Message extends Equatable {
  const Message({
    required this.id,
    required this.chatId,
    required this.type,
    required this.createdAt,
    this.userId,
    this.isRead,
    this.content,
    this.fileUrl,
  });
  final String id;
  final String chatId;
  final String? userId;
  final String? content;
  final String type;
  final String? fileUrl;
  final bool? isRead;
  final DateTime createdAt;
  Message copyWith({
    String? id,
    String? chatId,
    String? userId,
    String? content,
    String? type,
    String? fileUrl,
    bool? isRead,
    DateTime? createdAt,
  }) =>
      Message(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        userId: userId ?? this.userId,
        content: content ?? this.content,
        type: type ?? this.type,
        fileUrl: fileUrl ?? this.fileUrl,
        createdAt: createdAt ?? this.createdAt,
        isRead: isRead ?? this.isRead,
      );
      
        @override
        List<Object?> get props => [
          id,chatId,
          userId,
          content,
          type,
          fileUrl,
          isRead,
          createdAt
          ];
}
