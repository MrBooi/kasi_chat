import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterView();
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      body: AppConstrainedScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
        child: Column(
          children: [
            Gap.v(AppSpacing.xxxlg + AppSpacing.xlg),
          ],
        ),
      ),
    );
  }
}
