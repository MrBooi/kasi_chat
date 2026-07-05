import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:kasi_chat/features/auth/sign_up/widgets/widgets.dart';

/// {@template sign_up_form}
/// Sign up form that contains email and password fields.
/// {@endtemplate}
class SignUpForm extends StatefulWidget {
  /// {@macro sign_up_form}
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignupState>(
      listener: (context, state) {
        if (state.submissionStatus.isError) {}
      },
      listenWhen: (p, c) => p.submissionStatus != c.submissionStatus,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          EmailTextField(),
          FullNameTextField(),
          UsernameTextField(),
          PasswordTextField(),
        ],
      ),
    );
  }
}
