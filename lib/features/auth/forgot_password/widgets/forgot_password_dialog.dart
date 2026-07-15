import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/debouncer.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({
    required this.onSuccess,
    super.key,
  });

  final VoidCallback onSuccess;

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgotPasswordCubit>();
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
    final isLoading = context.select<ForgotPasswordCubit, bool>(
      (cubit) => cubit.state.status.isLoading,
    );
    final emailError = context.select<ForgotPasswordCubit, String?>(
      (cubit) => cubit.state.email.errorMessage,
    );
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          // TODO: implement listener
        }
        if (state.status.isError) {
          // TODO: implement listener
        }
      },
      child: AlertDialog(
        title: Text('Password reset'.hardcoded),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email to receive password reset instructions'
                  .hardcoded,
              style: context.bodyMedium,
            ),
            const Gap.v(AppSpacing.lg),
            AppTextField(
              key: const ValueKey('ForgotPasswordTextField'),
              filled: true,
              focusNode: _focusNode,
              enabled: !isLoading,
              hintText: 'Enter your email'.hardcoded,
              prefixIcon: const Icon(Icomoon.mail),
              textInputType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              onChanged: (v) => _debouncer.run(
                () => context.read<ForgotPasswordCubit>().onEmailChanged(v),
              ),
              errorText: emailError,
            ),
          ],
        ),
        actions: [
          AppButton(
            text: 'Cancel'.hardcoded,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          AppButton(
            text: 'Submit'.hardcoded,
            loading: isLoading,
            onPressed: () {
              context.read<ForgotPasswordCubit>().onSubmit();
            },
          ),
        ],
      ),
    );
  }
}
