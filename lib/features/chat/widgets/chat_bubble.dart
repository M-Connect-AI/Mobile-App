import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.sender == MessageSender.system) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            message.content ?? '',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }
    final isUser = message.sender == MessageSender.user;
    final colors = Theme.of(context).colorScheme;
    final bubbleColor = isUser
        ? colors.primary
        : colors.surfaceContainerHighest;
    final foreground = isUser ? colors.onPrimary : colors.onSurface;
    final time =
        '${message.createdAt.hour.toString().padLeft(2, '0')}:'
        '${message.createdAt.minute.toString().padLeft(2, '0')}';

    return Semantics(
      label: isUser ? 'Tin nhắn của bạn' : 'Phản hồi của AI',
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * .78,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isUser ? TextDirection.rtl : TextDirection.ltr,
            children: [
              if (!isUser) ...[
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 18,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isUser ? 18 : 5),
                          topRight: Radius.circular(isUser ? 5 : 18),
                          bottomLeft: const Radius.circular(18),
                          bottomRight: const Radius.circular(18),
                        ),
                      ),
                      child: message.type == MessageType.audio
                          ? _AudioContent(message: message, color: foreground)
                          : Text(
                              message.content ?? '',
                              style: TextStyle(
                                color: foreground,
                                fontSize: 15.5,
                                height: 1.4,
                              ),
                            ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 11,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        if (isUser) ...[
                          const SizedBox(width: 5),
                          _MessageStatusIcon(status: message.status),
                        ],
                      ],
                    ),
                    if (message.status == MessageStatus.failed)
                      TextButton.icon(
                        key: Key('retry-${message.id}'),
                        onPressed: () => context.read<ChatBloc>().add(
                          RetryMessage(message.id),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: colors.error,
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.only(left: 4, right: 8),
                        ),
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: const Text('Retry'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AudioContent extends StatelessWidget {
  const _AudioContent({required this.message, required this.color});
  final ChatMessage message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final seconds = message.duration?.inSeconds ?? 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.play_arrow_rounded, color: color, size: 26),
        const SizedBox(width: 6),
        ...List.generate(9, (index) {
          final height = 7.0 + ((index * 7) % 15);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: 2.5,
            height: height,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .72),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
        const SizedBox(width: 9),
        Text(
          '0:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(color: color, fontSize: 13),
        ),
      ],
    );
  }
}

class _MessageStatusIcon extends StatelessWidget {
  const _MessageStatusIcon({required this.status});
  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return switch (status) {
      MessageStatus.sending => SizedBox(
        width: 12,
        height: 12,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          color: colors.onSurfaceVariant,
        ),
      ),
      MessageStatus.failed => Icon(
        Icons.error_outline_rounded,
        size: 14,
        color: colors.error,
      ),
      _ => Icon(Icons.done_all_rounded, size: 14, color: colors.primary),
    };
  }
}
