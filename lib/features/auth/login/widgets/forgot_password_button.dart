
import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable(
      throttle: true,
      throttleDuration: 650.ms,
      onTap: () {
  
      },
      child: Text(
        'Forgot Password?'.hardcoded,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.titleSmall?.copyWith(color: AppColors.blue),
      ),
    );
  }
}
