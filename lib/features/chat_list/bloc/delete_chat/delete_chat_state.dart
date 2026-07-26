part of 'delete_chat_cubit.dart';

enum DeleteStatus {
  initial,
  loading,
  success,
  failure;

  bool get isSuccess => this == DeleteStatus.success;
  bool get isLoading => this == DeleteStatus.loading;
  bool get isError => this == DeleteStatus.failure;
}

class DeleteChatState extends Equatable {
  const DeleteChatState._({required this.status});

  const DeleteChatState.initial()
    : this._(
        status: DeleteStatus.initial,
      );

  final DeleteStatus status;

  @override
  List<Object?> get props => [status];

  DeleteChatState copyWith({
    DeleteStatus? status,
  }) {
    return DeleteChatState._(
      status: status ?? this.status,
    );
  }
}
