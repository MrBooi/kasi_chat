import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/auth/login/cubit/login_cubit.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<LoginCubit>()..resetState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<LoginCubit, bool>(
      (loginCubit) => loginCubit.state.status.isLoading,
    );
    final passwordError = context.select<LoginCubit, String?>(
      (loginCubit) => loginCubit.state.password.errorMessage,
    );
    final showPassword = context.select<LoginCubit, bool>(
      (loginCubit) => loginCubit.state.showPassword,
    );
    return AppTextField(
      key: const ValueKey('loginPasswordTextField'),
      filled: true,
      focusNode: _focusNode,
      hintText: 'Enter your password'.hardcoded,
      enabled: !isLoading,
      obscureText: !showPassword,
      textInputType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) =>
          context.read<LoginCubit>().signInWithEmailAndPassword(),
      onChanged: (v) =>
          _debouncer.run(() => context.read<LoginCubit>().onPasswordChanged(v)),
      errorText: passwordError,
      suffixIcon: Tappable(
        onTap: context.read<LoginCubit>().changePasswordVisibility,
        child: Icon(
          !showPassword ? Icons.visibility : Icons.visibility_off,
          color: context.customAdaptiveColor(light: AppColors.grey),
        ),
      ),
    );
  }
}
