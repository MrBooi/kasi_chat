import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/domain/entities/entities.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    required this.chatUser,
    required this.onTap,
    required this.onDismissed,
    required this.currentUserId,
    super.key,
  });
  final (Chat, User) chatUser;
  final VoidCallback onTap;
  final void Function(DismissDirection direction) onDismissed;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final chat = chatUser.$1;
    final user = chatUser.$2;
    // Determine avatar color index based on the first letter of the name
    final colorIndex = user.username.isNotEmpty
        ? user.username.codeUnitAt(0) % 3
        : 0;
    final userId = currentUserId;
    return Dismissible(
      key: Key('chat_${chat.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        child: const Icon(
          Icomoon.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: onDismissed,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xlg),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.emphasizeGrey),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Row(
                children: [
                  // Avatar
                  UserAvatar(
                    userName: user.username,
                    avatarUrl: user.avatarUrl,
                    colorIndex: colorIndex,
                    size: 50,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Chat info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.username,
                              style: UITextStyle.subtitle1.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              _formatTime(chat.lastMessageAt),
                              style: UITextStyle.labelSmall.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),

                        // Message preview
                        Row(
                          children: [
                            if (chat.lastMessageUserId != null &&
                                chat.lastMessageUserId == userId)
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: AppSpacing.xs,
                                ),
                                child: Text(
                                  'You: '.hardcoded,
                                  style: UITextStyle.labelSmall.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            if (chat.lastMessageText != null)
                              Expanded(
                                child: Text(
                                  _getMessagePreview(
                                    MessageType.values.byName(
                                      chat.lastMessageType!,
                                    ),
                                    chat.lastMessageText,
                                  ),
                                  style: UITextStyle.labelSmall.copyWith(
                                    color: AppColors.darkGrey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getMessagePreview(MessageType? messageType, String? text) {
    if (messageType == null) {
      return '';
    }
    // For attachments
    switch (messageType) {
      case MessageType.image:
        return 'Photo'.hardcoded;
      case MessageType.video:
        return 'Video'.hardcoded;
      case MessageType.file:
        return 'File'.hardcoded;
      case MessageType.audio:
        return 'Voice message'.hardcoded;
      case MessageType.text:
        return text ?? '';
    }
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now().toUtc();
    final difference = now.difference(time);
    // For very recent times (less than 1 hour ago)
    if (difference.inHours < 1) {
      final minutes = difference.inMinutes;

      if (minutes < 1) {
        return 'Just now'.hardcoded;
      } else {
        // English only needs a simple singular/plural check
        final suffix = minutes == 1 ? 'minute'.hardcoded : 'minutes'.hardcoded;
        return '$minutes $suffix ago';
      }
    }
    // For today
    else if (time.isToday()) {
      // Format as time only (e.g., "09:41")
      return DateFormat.Hm().format(time);
    }
    // For yesterday
    else if (time.isYesterday()) {
      return 'Yesterday';
    }
    // For this week (less than 7 days ago)
    else if (difference.inDays < 7) {
      // For short time labels we don't need full day name
      return '${time.day}.${time.month.toString().padLeft(2, '0')}';
    }
    // For older dates
    else {
      // Format as date (e.g., "12.01.22")
      return DateFormat('dd.MM.yy').format(time);
    }
  }
}
