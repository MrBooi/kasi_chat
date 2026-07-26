import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/features/chat/domain/usecase/domain.dart';

part 'delete_chat_state.dart';

class DeleteChatCubit extends Cubit<DeleteChatState> {
  DeleteChatCubit({
    required DeleteChatUseCase deleteChatUseCase,
  }) : _deleteChatUseCase = deleteChatUseCase,
       super(const DeleteChatState.initial());

  final DeleteChatUseCase _deleteChatUseCase;

  Future<void> deleteChat(String chatId) async {
    emit(state.copyWith(status: DeleteStatus.loading));
    try {
      await _deleteChatUseCase(chatId);
      emit(state.copyWith(status: DeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DeleteStatus.failure));
    }
  }
}
