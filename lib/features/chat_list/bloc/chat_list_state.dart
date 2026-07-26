part of 'chat_list_bloc.dart';

sealed class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

final class ChatListInitial extends ChatListState {}

final class ChatListLoadingState extends ChatListState {}

final class ChatListLoadedState extends ChatListState {
  const ChatListLoadedState(this.chats);

  final List<(Chat, User)> chats;

  @override
  List<Object> get props => [chats];
}

final class ChatListErrorState extends ChatListState {
  const ChatListErrorState(this.messsage);

  final String messsage;

  @override
  List<Object> get props => [messsage];
}
