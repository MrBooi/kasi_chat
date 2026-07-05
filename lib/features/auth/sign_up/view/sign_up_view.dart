import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/di/di.dart';
import 'package:kasi_chat/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:kasi_chat/features/auth/sign_up/widgets/widgets.dart';
import 'package:kasi_chat/features/auth/widgets/widgets.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
      ),
      body: AppConstrainedScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
        child: Column(
          children: [
            const Gap.v(AppSpacing.xxxlg + AppSpacing.xlg),
            AuthHeader(
              title: 'Kasi Messenger'.hardcoded,
              subtitle: 'Communicate without boundaries'.hardcoded,
            ),
            const Gap.v(AppSpacing.lg),
            const Expanded(
              child: Column(
                children: [
                  SignUpForm(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xlg,
                    ),
                    child: Align(
                      child: SignUpButton(),
                    ),
                  ),
                  Gap.v(AppSpacing.lg),
                  SignInIntoAccountButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
