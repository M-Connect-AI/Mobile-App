import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/app_toast.dart';
import '../../../../common/components/app_text_style.dart';
import '../../../../common/components/irh_button.dart';
import '../../../../common/extensions/responsive_extension.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../domain/model/chat_message.dart';
import '../../../../generated/l10n.dart';
import '../bloc/chat_bloc.dart';

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
    return Semantics(
      label: isUser ? S.of(context).yourMessage : S.of(context).aiResponse,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * .78,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Container(
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
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      message.type == MessageType.audio
                          ? _AudioContent(message: message, color: foreground)
                          : Text(
                              message.status == MessageStatus.processing
                                  ? '${message.content ?? ''} ▍'
                                  : message.content ?? '',
                              style: TextStyle(
                                color: foreground,
                                fontSize: 15.5,
                                height: 1.4,
                              ),
                            ),
                      if (!isUser && message.confirmation != null) ...[
                        8.height.heightBox,
                        _ConfirmationCard(message: message),
                      ],
                      if (!isUser && message.executedResult != null) ...[
                        8.height.heightBox,
                        Text(
                          S.of(context).chatActionCompleted,
                          style: AppTextStyle.sm12.copyWith(
                            color: context.appColorScheme.textSuccess,
                          ),
                        ),
                      ],
                      if (!isUser && message.citations.isNotEmpty) ...[
                        8.height.heightBox,
                        Wrap(
                          spacing: 8.width,
                          runSpacing: 8.height,
                          children: [
                            for (final citation in message.citations)
                              Chip(
                                label: Text(citation),
                                backgroundColor:
                                    context.appColorScheme.surfaceSecondary,
                              ),
                          ],
                        ),
                      ],
                      if (!isUser &&
                          message.type == MessageType.text &&
                          message.status == MessageStatus.success &&
                          (message.content?.isNotEmpty ?? false)) ...[
                        const SizedBox(height: 8),
                        Divider(height: 1, color: colors.outlineVariant),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _CopyMessageButton(message: message),
                        ),
                      ],
                      if (isUser && message.status == MessageStatus.failed)
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
                          label: Text(S.of(context).retry),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmationCard extends StatelessWidget {
  const _ConfirmationCard({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final action = message.confirmation!;
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            action.summary,
            style: AppTextStyle.r14.copyWith(color: colors.textPrimary),
          ),
          12.height.heightBox,
          if (action.canExecute)
            Row(
              children: [
                Expanded(
                  child: IrhButton(
                    label: strings.confirmButton,
                    onPressed: () => context.read<ChatBloc>().add(
                      ConfirmationResponded(
                        messageId: message.id,
                        confirmed: true,
                      ),
                    ),
                  ),
                ),
                8.width.widthBox,
                IrhTextButton(
                  label: strings.cancelButton,
                  onPressed: () => context.read<ChatBloc>().add(
                    ConfirmationResponded(
                      messageId: message.id,
                      confirmed: false,
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              strings.unsupportedChatAction,
              style: AppTextStyle.r12.copyWith(color: colors.textError),
            ),
        ],
      ),
    );
  }
}

class _CopyMessageButton extends StatelessWidget {
  const _CopyMessageButton({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      key: Key('copy-${message.id}'),
      tooltip: S.of(context).copyMessage,
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: message.content!));
        if (!context.mounted) return;
        AppToast.success(context, S.of(context).responseCopied);
      },
      style: IconButton.styleFrom(
        backgroundColor: colors.surfaceContainerHighest,
        foregroundColor: colors.onSurfaceVariant,
        side: BorderSide(color: colors.outlineVariant),
        minimumSize: const Size.square(34),
        maximumSize: const Size.square(34),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
      icon: const Icon(Icons.copy_all_rounded, size: 17),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic_rounded, color: color, size: 23),
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
        ),
        if (message.content?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          Text(
            message.content!,
            style: TextStyle(color: color, fontSize: 14, height: 1.35),
          ),
        ],
      ],
    );
  }
}
