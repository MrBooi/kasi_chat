import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/di/di.dart';
import 'package:kasi_chat/features/chat_list/bloc/chat_list_bloc.dart';
import 'package:kasi_chat/features/chat_list/bloc/delete_chat/delete_chat_cubit.dart';
import 'package:kasi_chat/features/chat_list/widgets/widgets.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(
          create: (_) => sl.get<ChatListBloc>()..add(LoadChats()),
        ),
        BlocProvider(
          create: (context) => sl.get<DeleteChatCubit>(),
        ),
      ],
      child: const _ChatListBody(),
    );
  }
}

class _ChatListBody extends StatelessWidget {
  const _ChatListBody();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ChatListAppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // TODO complete Create chat
        },
        tooltip: 'Create a chat'.hardcoded,
        child: Icon(
          Icomoon.plusS,
          color: context.customAdaptiveColor(),
        ),
      ),
      body: const Column(
        children: [
          SearchTextfield(),
          AppDivider(),
          ChatListSection(),
        ],
      ),
    );
  }
}

// Create a chat
