part of 'search_user_cubit.dart';

enum SearchStatus {
  initial,
  loading,
  loaded,
  failure;

  bool get isLoaded => this == SearchStatus.loaded;
  bool get isLoading => this == SearchStatus.loading;
  bool get isError => this == SearchStatus.failure;
}

class SearchUserState extends Equatable {
  const SearchUserState._({
    required this.status,
    required this.users,
    this.selectedUser,
  });

  SearchUserState.initial()
    : this._(
        status: SearchStatus.initial,
        users: [],
      );

  final SearchStatus status;
  final List<User> users;
  final User? selectedUser;

  @override
  List<Object?> get props => [status, users, selectedUser];

  SearchUserState copyWith({
    SearchStatus? status,
    List<User>? users,
    User? selectedUser,
  }) {
    return SearchUserState._(
      status: status ?? this.status,
      selectedUser: selectedUser ?? this.selectedUser,
      users: users ?? this.users,
    );
  }
}
