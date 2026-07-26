import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/core/domain/entities/user.dart';
import 'package:kasi_chat/core/domain/usecase/chat_usecase/chat_usecases.dart';

part 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  SearchUserCubit({
    required GetUsersUseCase getUsersUseCase,
  }) : _getUsersUseCase = getUsersUseCase,
       super(SearchUserState.initial());
  final GetUsersUseCase _getUsersUseCase;

  List<User> _allAvailableUsers = [];

  Future<void> loadAvailableUsers(Set<String> existingChatUserIds) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final usersList = await _getUsersUseCase();
      _allAvailableUsers = usersList
          .where((user) => !existingChatUserIds.contains(user.id))
          .toList();
      emit(
        state.copyWith(status: SearchStatus.loaded, users: _allAvailableUsers),
      );
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  void search(String query) {
    if (query.trim().isEmpty) {
      emit(state.copyWith(users: _allAvailableUsers));
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final filtered = _allAvailableUsers
        .where(
          (user) =>
              user.username.toLowerCase().contains(lowercaseQuery) ||
              user.email.toLowerCase().contains(lowercaseQuery),
        )
        .toList();
    emit(state.copyWith(users: filtered));
  }
}
