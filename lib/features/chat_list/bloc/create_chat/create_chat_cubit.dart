import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/features/chat/domain/usecase/domain.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit({
    required CreateChatUseCase createChatUseCase,
  }) : _createChatUseCase = createChatUseCase,
       super(const CreateChatState.initial());

  final CreateChatUseCase _createChatUseCase;

  Future<void> createChat(String userId) async {
    emit(state.copyWith(status: CreateStatus.loading));
    try {
      await _createChatUseCase(userId);
      emit(state.copyWith(status: CreateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }
}
