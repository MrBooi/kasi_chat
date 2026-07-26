import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/app/router/app_routes.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ChatListAppBar extends StatelessWidget {
  const ChatListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Chats'.hardcoded,
        style: context.titleLarge,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icomoon.person,
            color: context.customAdaptiveColor(),
          ),
          onPressed: () => context.push(AppRoutes.profile.route),
          tooltip: 'Go to profile'.hardcoded,
        ),
        IconButton(
          icon: Icon(
            Icomoon.outRight,
            color: context.customAdaptiveColor(),
          
          ),
          onPressed: () {
            // TODO Logout
          },
          tooltip: 'Log out'.hardcoded,
        ),
      ],
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 50,
    );
  }
}
