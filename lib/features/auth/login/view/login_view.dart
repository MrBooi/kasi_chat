import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/login/widgets/widgets.dart';
import 'package:kasi_chat/features/auth/widgets/widgets.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body: AppConstrainedScrollView(
        padding: const EdgeInsets.all(AppSpacing.xlg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap.v(AppSpacing.xxlg + AppSpacing.xxxlg),
            AuthHeader(
              title: 'Kasi Messenger'.hardcoded,
              subtitle: 'Communicate without boundaries'.hardcoded,
            ),
            const Gap.v(AppSpacing.lg),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginForm(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: AppSpacing.md,
                      top: AppSpacing.xs,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ForgotPasswordButton(),
                    ),
                  ),
                  Align(child: SignInButton()),
                    Gap.v(AppSpacing.lg),
                   Align(child: SignUpNewAccountButton()),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
