import 'package:flutter/material.dart';
import 'package:kasi_chat/core/config/config.dart';
import 'package:kasi_chat/core/widgets/app_text_field.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _debouncer = Debouncer();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {}
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
    return AppTextField(
      key: const ValueKey('loginEmailTextField'),
      filled: true,
      focusNode: _focusNode,
      hintText: 'Enter your email'.hardcoded,
      enabled: !isLoading,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      onChanged: (v) => _debouncer.run(
        () {},
      ),
      errorText: 'Please enter a valid email address'.hardcoded,
    );
  }
}
