import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/usecase/chat_usecase/chat_usecases.dart';
import 'package:kasi_chat/core/domain/usecase/get_current_user_usecase.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc({
    required GetChatsUseCase getChatsUseCase,
    required WatchChatsUseCase watchChatsUseCase,
    required GetUserByIdUseCase getUserByIdUseCase,
    required GetChatUserIdsUseCase getChatUserIdsUseCase,
    required SyncChatsUseCase syncChatsUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _getChatsUseCase = getChatsUseCase,
       _watchChatsUseCase = watchChatsUseCase,
       _getUserByIdUseCase = getUserByIdUseCase,
       _getChatUserIdsUseCase = getChatUserIdsUseCase,
       _syncChatsUseCase = syncChatsUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(ChatListInitial()) {
    on<LoadChats>(_onLoadChats);
    on<RefreshChats>(_onRefreshChats);
  }
  final GetChatsUseCase _getChatsUseCase;
  final WatchChatsUseCase _watchChatsUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;
  final GetChatUserIdsUseCase _getChatUserIdsUseCase;
  final SyncChatsUseCase _syncChatsUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  StreamSubscription<List<Chat>>? _chatSubscription;
  Timer? _debounceTimer;

  Future<void> _onLoadChats(
    LoadChats event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoadingState());
    try {
      final chatsListResult = await _loadChatsList();

      emit(ChatListLoadedState(chatsListResult));

      await _setupChatSubscription(emit);
    } catch (e) {
      emit(ChatListErrorState(e.toString()));
    }
  }

  Future<void> _onRefreshChats(
    RefreshChats event,
    Emitter<ChatListState> emit,
  ) async {
    try {
      await _syncChatsUseCase();

      final chatsListResult = await _loadChatsList();

      emit(ChatListLoadedState(chatsListResult));
    } catch (e) {
      emit(ChatListErrorState(e.toString()));
    }
  }

  Future<String> _getOtherUserId(Chat chat) async {
    final currentUser = _getCurrentUserUseCase();
    final currentUserId = currentUser?.id ?? '';
    final userIdsResult = await _getChatUserIdsUseCase(chat.id);
    return userIdsResult.firstWhere(
      (id) => id == currentUserId,
      orElse: () => '',
    );
  }

  Future<List<(Chat, User)>> _loadChatsList() async {
    final chatListResult = await _getChatsUseCase();
    final chatUserPairs = <(Chat, User)>[];
    for (final chat in chatListResult) {
      final otherUserId = await _getOtherUserId(chat);
      if (otherUserId.isNotEmpty) {
        final otherUser = await _getUserByIdUseCase(otherUserId);
        if (otherUser != null) {
          chatUserPairs.add((chat, otherUser));
        }
      }
    }

    return chatUserPairs;
  }

  bool _areChatsEqual(List<Chat> list1, List<Chat> list2) {
    if (list1.length != list2.length) return false;

    for (var i = 0; i < list1.length; i++) {

      if (list1[i].id != list2[i].id) return false;

      final lastMessageAt1 = list1[i].lastMessageAt;
      final lastMessageAt2 = list2[i].lastMessageAt;

      if ((lastMessageAt1 == null) != (lastMessageAt2 == null)) return false;

      if (lastMessageAt1 != null && lastMessageAt2 != null) {
        if (lastMessageAt1.compareTo(lastMessageAt2) != 0) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> _setupChatSubscription(
    Emitter<ChatListState> emit,
  ) async {
    await _chatSubscription?.cancel();
    List<Chat>? lastChats;

    _chatSubscription = _watchChatsUseCase.call().listen(
      (chats) {
        final isDifferent =
            lastChats == null ||
            lastChats!.length != chats.length ||
            !_areChatsEqual(lastChats!, chats);

        if (!isDifferent) return;
        lastChats = List.of(chats);

        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
          if (isClosed) return;

          add(RefreshChats());
        });
      },
      onError: (Object e) {
        if (!isClosed) {
          emit(ChatListErrorState(e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    unawaited(_chatSubscription?.cancel());
    _debounceTimer?.cancel();
    return super.close();
  }
}
