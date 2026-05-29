import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
@immutable
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.username,
    this.avatarUrl,
    this.isOnline = false,
  });
  final String id;
  final String email;
  final String username;
  final String? avatarUrl;
  final bool isOnline;
  User copyWith({
    String? id,
    String? email,
    String? username,
    String? avatarUrl,
    bool? isOnline,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        isOnline: isOnline ?? this.isOnline,
      );
      
        @override
        List<Object?> get props => [
          id,
          email,
          username,
          avatarUrl,
          isOnline
        ];
}
     
