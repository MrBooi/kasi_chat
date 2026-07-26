part of 'create_chat_cubit.dart';

enum CreateStatus {
  initial,
  loading,
  success,
  failure;

  bool get isSuccess => this == CreateStatus.success;
  bool get isLoading => this == CreateStatus.loading;
  bool get isError => this == CreateStatus.failure;
}

class CreateChatState extends Equatable {
  const CreateChatState._({required this.status, this.errorMessage});

  const CreateChatState.initial()
    : this._(
        status: CreateStatus.initial,
      );

  final CreateStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  CreateChatState copyWith({
    CreateStatus? status,
    String? errorMessage,
  }) {
    return CreateChatState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
