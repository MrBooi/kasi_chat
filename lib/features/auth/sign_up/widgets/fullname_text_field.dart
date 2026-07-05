import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';

class FullNameTextField extends StatefulWidget {
  const FullNameTextField({super.key});

  @override
  State<FullNameTextField> createState() => _FullNameTextFieldState();
}

class _FullNameTextFieldState extends State<FullNameTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onFullNameUnfocused();
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
    final fullNameError = context.select<SignUpCubit, String?>(
      (cubit) => cubit.state.fullName.errorMessage,
    );

    return AppTextField(
      filled: true,
      focusNode: _focusNode,
      hintText: 'Enter Name',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      autofillHints: const [AutofillHints.givenName],
      enabled: !isLoading,
      onChanged: (v) => _debouncer.run(
        () => context.read<SignUpCubit>().onFullNameChanged(v),
      ),
      errorText: fullNameError,
      errorMaxLines: 3,
    );
  }
}
