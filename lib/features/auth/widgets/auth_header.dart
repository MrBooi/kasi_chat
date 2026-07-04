import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    super.key,
    this.subtitle,
  });
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      // App logo
      const AppLogo(color: AppColors.lightBlue),

      const Gap.v(AppSpacing.xlg),

      // Title
      Text(
        title,
        style: UITextStyle.headline3.copyWith(color: Colors.white),

        textAlign: TextAlign.center,
      ),

      // Subtitle
      if (subtitle != null) ...[
        const Gap.v(0),
        Text(
          subtitle!,
          style: UITextStyle.caption.copyWith(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ],
  );
}
