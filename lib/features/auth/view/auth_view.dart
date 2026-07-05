import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/features/auth/cubit/auth_cubit.dart';
import 'package:kasi_chat/features/auth/login/view/login_view.dart';
import 'package:kasi_chat/features/auth/sign_up/view/sign_up_view.dart';

class AuthPage extends StatelessWidget {
  /// {@macro auth_page}
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const _AuthView(),
    );
  }
}

/// {@template auth_view}
/// Auth view. Shows login or signup page depending on the state of [AuthCubit].
/// {@endtemplate}
class _AuthView extends StatelessWidget {
  /// {@macro auth_view}
  const _AuthView();

  @override
  Widget build(BuildContext context) {
    final showLogin = context.select<AuthCubit, bool>((b) => b.state);

    return PageTransitionSwitcher(
      reverse: showLogin,
      transitionBuilder:
          (
            child,
            animation,
            secondaryAnimation,
          ) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
      child: showLogin ? const LoginPage() : const SignUpPage(),
    );
  }
}
