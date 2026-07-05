import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/app/router/router.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

/// {@template sign_in_into_account_button}
/// Sign up widget that contains sign up button.
/// {@endtemplate}
class SignInIntoAccountButton extends StatelessWidget {
  /// {@macro sign_in_into_account_button}
  const SignInIntoAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {
        context..pop()
        ..pushReplacement(AppRoutes.login.name);
      },
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? '.hardcoded,
              style: context.bodyMedium,
            ),
            TextSpan(
              text: 'Login'.hardcoded,
              style: context.bodyMedium?.apply(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
