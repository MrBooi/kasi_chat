import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required UserChangeUsecase userChangeUsecase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _userChangeUsecase = userChangeUsecase,

       super(Initial()) {
    _checkCurrentUser();
    _subscribeToAuthChanges();
  }
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UserChangeUsecase _userChangeUsecase;

  StreamSubscription<User?>? _authSubscription;

  void _checkCurrentUser() {
    final user = _getCurrentUserUseCase();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  void _subscribeToAuthChanges() {
    _authSubscription = _userChangeUsecase().listen(
      (user) {
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      },
      onError: (Object e) {
        emit(AuthError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
   unawaited( _authSubscription?.cancel());
    return super.close();
  }
}
