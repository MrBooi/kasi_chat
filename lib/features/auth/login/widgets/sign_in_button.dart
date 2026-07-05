import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/logger.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/login/cubit/login_cubit.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
    final isLoading = context.select<LoginCubit, bool>(
      (loginCubit) => loginCubit.state.status.isLoading,
    );

    logI('SignInButton isLoading: $isLoading');
    final child = switch (isLoading) {
      true => AppButton.inProgress(style: style, scale: 0.5),
      _ => AppButton.auth(
        'Sign In'.hardcoded,
        () => context.read<LoginCubit>().signInWithEmailAndPassword(),
        style: style,
        outlined: true,
      ),
    };
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: switch (context.screenWidth) {
          > 600 => context.screenWidth * .6,
          _ => context.screenWidth,
        },
      ),
      child: child,
    );
  }
}
