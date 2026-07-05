import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/debouncer.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onEmailUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<SignUpCubit, bool>(
      (cubit) => cubit.state.submissionStatus.isLoading,
    );
    final emailError = context.select<SignUpCubit, String?>(
      (cubit) => cubit.state.email.errorMessage,
    );
    return AppTextField(
      filled: true,
      focusNode: _focusNode,
      hintText: 'Enter email'.hardcoded,
      enabled: !isLoading,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      onChanged: (v) => _debouncer.run(
        () => context.read<SignUpCubit>().onEmailChanged(v),
      ),
      errorText: emailError,
    );
  }
}
