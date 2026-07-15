import 'package:flutter/widgets.dart';
import 'package:kasi_chat/core/colors/app_colors.dart';
import 'package:kasi_chat/core/config/utilities/extensions/show_dialog.dart';

class ModalOption {

  ModalOption({
    this.name,
    this.icon,
    this.iconData,
    this.child,
    VoidCallback? onTap,
    this.noAction,
    this.nameColor,
    this.distractive = false,
    this.actionTitle,
    this.actionContent,
    this.actionNoText,
    this.actionYesText,
  }) : _onTap = onTap;
  final String? name;
  final Color? nameColor;
  final Widget? icon;
  final IconData? iconData;
  final Widget? child;
  final BuildContextCallback? noAction;
  final String? actionTitle;
  final String? actionContent;
  final String? actionNoText;
  final String? actionYesText;
  final bool distractive;

  final VoidCallback? _onTap;

  void onTap(BuildContext context) => distractive
      ? context.confirmAction(
          title: actionTitle ?? name!,
          content: actionContent,
          noText: actionNoText ?? 'Cancel',
          yesText: actionYesText ?? 'Yes',
          noAction: noAction,
          fn: () => _onTap?.call(),
        )
      : _onTap?.call();

  Color? get distractiveColor => distractive ? AppColors.red : null;

  ModalOption copyWith({
    String? name,
    Color? nameColor,
    Widget? icon,
    IconData? iconData,
    Widget? child,
    BuildContextCallback? noAction,
    String? actionTitle,
    String? actionContent,
    String? actionNoText,
    String? actionYesText,
    bool? distractive,
  }) {
    return ModalOption(
      name: name ?? this.name,
      nameColor: nameColor ?? this.nameColor,
      icon: icon ?? this.icon,
      iconData: iconData ?? this.iconData,
      child: child ?? this.child,
      noAction: noAction ?? this.noAction,
      actionTitle: actionTitle ?? this.actionTitle,
      actionContent: actionContent ?? this.actionContent,
      actionNoText: actionNoText ?? this.actionNoText,
      actionYesText: actionYesText ?? this.actionYesText,
      distractive: distractive ?? this.distractive,
    );
  }
}
