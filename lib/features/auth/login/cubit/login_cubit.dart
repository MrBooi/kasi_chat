import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/domain/usecase/usecases.dart';
import 'package:kasi_chat/core/forms_fields/form_feilds.dart';

part 'login_state.dart';

/// {@template login_cubit}
/// Cubit for login state management. It is used to change login state from
/// initial to in progress, success or error. It also validates email and
/// password fields.
/// {@endtemplate}
class LoginCubit extends Cubit<LoginState> {
  /// {@macro login_cubit}
  LoginCubit({
    required SignInUseCase signInUseCase,
  }) : _signInUseCase = signInUseCase,
       super(const LoginState.initial());

  final SignInUseCase _signInUseCase;

  /// Changes password visibility, making it visible or not.
  void changePasswordVisibility() => emit(
    state.copyWith(showPassword: !state.showPassword),
  );

  /// Emits initial state of login screen.
  void resetState() => emit(const LoginState.initial());

  /// Email value was changed, triggering new changes in state.
  void onEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final shouldValidate = previousEmailState.isNotValid;
    final newEmailState = shouldValidate
        ? Email.dirty(
            newValue,
          )
        : Email.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      email: newEmailState,
    );

    emit(newScreenState);
  }

  /// Email field was unfocused, here is checking if previous state with email
  /// was valid, in order to indicate it in state after unfocus.
  void onEmailUnfocused() {
    final previousScreenState = state;
    final previousEmailState = previousScreenState.email;
    final previousEmailValue = previousEmailState.value;

    final newEmailState = Email.dirty(
      previousEmailValue,
    );
    final newScreenState = previousScreenState.copyWith(
      email: newEmailState,
    );
    emit(newScreenState);
  }

  /// Password value was changed, triggering new changes in state.
  /// Checking whether or not value is valid in [Password] and emmiting new
  /// [Password] validation state.
  void onPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.dirty(
            newValue,
          )
        : Password.pure(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.dirty(
      previousPasswordValue,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  /// Makes whole login state initial, as [Email] and [Password] becomes invalid
  /// and [LogInSubmissionStatus] becomes idle. Solely used if during login
  /// user switched on sign up, therefore login state does not persists and
  /// becomes initial again.
  void idle() {
    const initialState = LoginState.initial();
    emit(initialState);
  }

  Future<void> signInWithEmailAndPassword() async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final isFormValid = FormzValid([email, password]).isFormValid;

    final newState = state.copyWith(
      email: email,
      password: password,
      status: isFormValid ? LogInSubmissionStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      await _signInUseCase(
        email: email.value,
        password: password.value,
      );
      final newState = state.copyWith(status: LogInSubmissionStatus.success);
      emit(newState);
    } catch (e) {
      final newState = state.copyWith(
        status: LogInSubmissionStatus.emailOrPasswordFailure,
        message: e.toString(),
      );
      emit(newState);
    }
  }
}
