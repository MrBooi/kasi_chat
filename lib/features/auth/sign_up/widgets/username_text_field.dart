import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/debouncer.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({super.key});

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onUsernameUnfocused();
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
    final usernameError = context.select<SignUpCubit, String?>(
      (cubit) => cubit.state.username.errorMessage,
    );
    return AppTextField(
      filled: true,
      focusNode: _focusNode,
      hintText: 'Enter userName'.hardcoded,
      textInputAction: TextInputAction.next,
      enabled: !isLoading,
      onChanged: (v) => _debouncer.run(
        () => context.read<SignUpCubit>().onUsernameChanged(v),
      ),
      errorMaxLines: 3,
      errorText: usernameError,
    );
  }
}
