import 'package:flutter/material.dart';
import 'package:kasi_chat/core/config/utilities/extensions/build_context_extension.dart';
import 'package:kasi_chat/core/theme/icons.dart';

/// {@template app_logo}
/// The Application logo that display large Instagram text in a svg format.
/// {@endtemplate}
class AppLogo extends StatelessWidget {
  /// {@macro app_log}
  const AppLogo({
    this.fit = BoxFit.contain,
    super.key,
    this.width,
    this.height,
    this.color,
  });

  /// The fit of the logo.
  final BoxFit fit;

  /// The width of the logo.
  final double? width;

  /// The height of the logo.
  final double? height;

  /// The color of the logo.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 80,
      height: height ?? 80,
      decoration: BoxDecoration(
        color: color ?? context.adaptiveColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        Icomoon.messageFill,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
