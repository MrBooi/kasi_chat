import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/core/domain/usecase/usecases.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required UserChangeUsecase useChangeUsecase,
    required SignOutUseCase signOutUsecase,
  }) : _useChangeUsecase = useChangeUsecase,
       _signOutUsecase = signOutUsecase,

       super(
         const AppState.unauthenticated(),
       ) {
    on<AppLogoutRequested>(_onAppLogoutRequested);
    on<AppUserChanged>(_onUserChanged);

    _userSubscription = _useChangeUsecase.call().listen(
      _userChanged,
      onError: addError,
    );
  }

  final UserChangeUsecase _useChangeUsecase;
  final SignOutUseCase _signOutUsecase;

  StreamSubscription<User>? _userSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    final user = event.user;

    Future<void> authenticate() async {
      emit(AppState.authenticated(user));
    }

    switch (state.status) {
      case AppStatus.onboardingRequired:
      case AppStatus.authenticated:
      case AppStatus.unauthenticated:
        return !user.isAnonymous && user.isNewUser
            ? emit(AppState.onboardingRequired(user))
            : user.isAnonymous
            ? emit(const AppState.unauthenticated())
            : authenticate();
    }
  }

  Future<void> _onAppLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) => _signOutUsecase.call();

  @override
  Future<void> close() {
    unawaited(_userSubscription?.cancel());
    return super.close();
  }
}
