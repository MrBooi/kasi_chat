import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/features/app/bloc/app_bloc.dart';
import 'package:kasi_chat/features/chat_list/bloc/chat_list_bloc.dart';
import 'package:kasi_chat/features/chat_list/bloc/delete_chat/delete_chat_cubit.dart';
import 'package:kasi_chat/features/chat_list/widgets/chat_list_item.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ChatListSection extends StatelessWidget {
  const ChatListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<DeleteChatCubit, DeleteChatState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            // TODO SHOW DELETE SNACK BAR
          }
        },
        child: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            if (state is ChatListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChatListLoadedState) {
              return _ChatsListBody(state.chats);
            }

            if (state is ChatListErrorState) {
              return _ChatListError(state.messsage);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ChatsListBody extends StatelessWidget {
  const _ChatsListBody(this.chats);
  final List<(Chat, User)> chats;

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppBloc>().state;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChatListBloc>().add(RefreshChats());
      },
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListItem(
            chatUser: chat,
            onTap: () => context.go(
              '/chat/${chat.$1.id}',
              extra: {'otherUser': chat.$2.toJson()},
            ),
            onDismissed: (_) {
              context.read<DeleteChatCubit>().deleteChat(chat.$1.id);
            },
            currentUserId: appState.user.id,
          );
        },
      ),
    );
  }
}

class _ChatListError extends StatelessWidget {
  const _ChatListError(this.errorMessage);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icomoon.error,
              color: Colors.red,
              size: 48,
            ),
            const Gap.v(AppSpacing.lg),
            Text(
              'Error loading Chats'.hardcoded,
              style: UITextStyle.bodyText2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap.v(AppSpacing.sm),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: UITextStyle.labelSmall,
            ),
            const Gap.v(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                context.read<ChatListBloc>().add(RefreshChats());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: Colors.white,
              ),
              child: Text('Retry'.hardcoded),
            ),
          ],
        ),
      ),
    );
  }
}
