import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/login/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: AppSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmailTextField(),
        PasswordTextField(),
      ],
    );
  }
}
