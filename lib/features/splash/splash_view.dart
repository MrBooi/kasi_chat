import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icomoon.messageFill,
                color: Colors.white,
                size: 60,
              ),
            ),

            const Gap.h(AppSpacing.xlg),

            // App name
            Text(
              'Kasi Messenger',
              style: UITextStyle.headline3.copyWith(color: AppColors.white),
            ),
            const Gap.h(AppSpacing.md),

            // Tagline
            Text(
              'Communicate without boundaries'.hardcoded,
              style: UITextStyle.caption.copyWith(color: Colors.white70),
            ),
            const Gap.h(AppSpacing.xxlg),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
