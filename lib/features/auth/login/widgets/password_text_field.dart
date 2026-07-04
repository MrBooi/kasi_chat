import 'package:flutter/material.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/core.dart';
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
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
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
     const bool isLoading = false; // Replace with actual state management logic
    bool showPassword = false; // Replace with actual state management logic
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
      onFieldSubmitted: (_) {},
      onChanged: (v) => _debouncer.run(
        () {}
      ),
      errorText: 'Please enter your password'.hardcoded,
      suffixIcon: Tappable(
        backgroundColor: AppColors.transparent,
        onTap: (){},
        child: Icon(
          !showPassword ? Icons.visibility : Icons.visibility_off,
          color: context.customAdaptiveColor(light: AppColors.grey),
        ),
      ),
    );
  }
}
