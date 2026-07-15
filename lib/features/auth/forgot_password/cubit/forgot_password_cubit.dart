import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:kasi_chat/core/config/submission_status_message.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/domain/domain.dart';
import 'package:kasi_chat/core/forms_fields/fields/email.dart';
import 'package:kasi_chat/core/forms_fields/fields/formz_valid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _resetPasswordUseCase = resetPasswordUseCase,
       super(const ForgotPasswordState.initial());

  final ResetPasswordUseCase _resetPasswordUseCase;

  /// Emits initial state of login screen.
  void resetState() => emit(const ForgotPasswordState.initial());

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

  Future<void> onSubmit() async {
    final email = Email.dirty(state.email.value);
    final isFormValid = FormzValid([email]).isFormValid;

    final newState = state.copyWith(
      email: email,
      status: isFormValid ? ForgotPasswordStatus.loading : null,
    );

    emit(newState);

    if (!isFormValid) return;

    try {
      await _resetPasswordUseCase(state.email.value);
      final newState = state.copyWith(status: ForgotPasswordStatus.success);
      if (isClosed) return;
      emit(newState);
    } catch (error, stackTrace) {
      _errorFormatter(error, stackTrace);
    }
  }

  void _errorFormatter(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    final status = switch (error) {
      AuthException(:final statusCode) => switch (statusCode?.parse) {
        HttpStatus.tooManyRequests => ForgotPasswordStatus.tooManyRequests,
        _ => ForgotPasswordStatus.failure,
      },
      _ => ForgotPasswordStatus.failure,
    };

    emit(state.copyWith(status: status));
  }
}
