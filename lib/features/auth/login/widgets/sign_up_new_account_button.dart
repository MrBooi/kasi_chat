
import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

/// {@template sign_up_account_button}
/// Sign up widget that contains sign up button.
/// {@endtemplate}
class SignUpNewAccountButton extends StatelessWidget {
  /// {@macro sign_up_account_button}
  const SignUpNewAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {},
      child: Text.rich(
        overflow: TextOverflow.visible,
        style: context.bodyMedium,
        TextSpan(
          children: [
            TextSpan(text: "Don't have an account? ".hardcoded),
            TextSpan(
              text: 'Sign Up'.hardcoded,
              style: context.bodyMedium?.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
