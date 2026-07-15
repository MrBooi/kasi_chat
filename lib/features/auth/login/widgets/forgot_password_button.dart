import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/di/di.dart';
import 'package:kasi_chat/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kasi_chat/features/auth/forgot_password/widgets/widgets.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable(
      throttle: true,
      throttleDuration: 650.ms,
      onTap: () async {
        await context.showCustomDialog(
          builder: (context) => BlocProvider.value(
            value: sl.get<ForgotPasswordCubit>(),
            child: ForgotPasswordDialog(
              onSuccess: () {},
            ),
          ),
        );
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
