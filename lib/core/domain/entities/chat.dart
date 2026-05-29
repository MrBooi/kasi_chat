import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Chat extends Equatable {
  const Chat({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userIds,
    this.name,
    this.lastMessageText,
    this.lastMessageUserId,
    this.lastMessageType,
    this.lastMessageAt,
  });
  final String id;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> userIds;
  final String? lastMessageText;
  final String? lastMessageUserId;
  final String? lastMessageType;
  final DateTime? lastMessageAt;
  Chat copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? userIds,
    String? lastMessageText,
    String? lastMessageUserId,
    String? lastMessageType,
    DateTime? lastMessageAt,
  }) =>
      Chat(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userIds: userIds ?? this.userIds,
        lastMessageText: lastMessageText ?? this.lastMessageText,
        lastMessageUserId: lastMessageUserId ?? this.lastMessageUserId,
        lastMessageType: lastMessageType ?? this.lastMessageType,
        lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      );
      
        @override
        List<Object?> get props => [
          id,
          name,
          createdAt,
          updatedAt,
          userIds,
          lastMessageText,
          lastMessageUserId,
          lastMessageType,
          lastMessageAt
        ];
}
