import 'package:awesome_extensions/awesome_extensions.dart' hide NavigatorExt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_toast.dart';
import '../../../common/components/assistant_header.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/chat_message.dart';
import '../../../generated/l10n.dart';
import 'bloc/chat_text_size_cubit.dart';
import 'widgets/chat_bubble.dart';

class ChatSettingsPage extends StatelessWidget {
  const ChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      body: SafeArea(
        child: Column(
          children: [
            AssistantHeader(
              title: strings.chatSettingsTitle,
              backLabel: strings.backButton,
              onBack: () => context.pop(),
              backKey: const Key('chat-settings-back-button'),
            ).paddingSymmetric(horizontal: 20.width),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.height.heightBox,
                  IrhText.title(strings.chatTextSizeTitle),
                  8.height.heightBox,
                  IrhText.regular(
                    strings.chatTextSizeDescription,
                    color: colors.textSecondary,
                  ),
                  24.height.heightBox,
                  const _TextSizeCard(),
                  32.height.heightBox,
                  IrhText.medium(strings.chatTextSizePreviewLabel),
                  16.height.heightBox,
                  _PreviewBubble(message: strings.chatTextSizePreviewMessage),
                ],
              ).paddingSymmetric(horizontal: 20.width),
            ).expanded(),
          ],
        ),
      ),
    );
  }
}

class _TextSizeCard extends StatelessWidget {
  const _TextSizeCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: BlocBuilder<ChatTextSizeCubit, int>(
        builder: (context, size) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IrhText.medium(
                  strings.chatTextSizeTitle,
                  maxLines: 1,
                ).expanded(),
                8.width.widthBox,
                IrhText.medium(
                  strings.chatTextSizeValue(size),
                  color: colors.textBrand,
                ),
              ],
            ),
            16.height.heightBox,
            Semantics(
              label: strings.chatTextSizeTitle,
              value: strings.chatTextSizeValue(size),
              child: CupertinoSlider(
                key: const Key('chat-text-size-slider'),
                value: size.toDouble(),
                min: ChatTextSizeCubit.minSize.toDouble(),
                max: ChatTextSizeCubit.maxSize.toDouble(),
                divisions:
                    ChatTextSizeCubit.maxSize - ChatTextSizeCubit.minSize,
                activeColor: colors.iconBrand,
                onChanged: (value) =>
                    context.read<ChatTextSizeCubit>().update(value.round()),
                onChangeEnd: (_) async {
                  final saved = await context.read<ChatTextSizeCubit>().save();
                  if (!saved && context.mounted) {
                    AppToast.showError(context, strings.chatTextSizeSaveError);
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IrhText.small(
                  strings.chatTextSizeValue(ChatTextSizeCubit.minSize),
                ),
                IrhText.small(
                  strings.chatTextSizeValue(ChatTextSizeCubit.maxSize),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewBubble extends StatelessWidget {
  const _PreviewBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => ChatBubble(
    key: const Key('chat-text-size-preview'),
    message: ChatMessage(
      id: 'chat-text-size-preview',
      type: MessageType.text,
      sender: MessageSender.assistant,
      content: message,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      status: MessageStatus.success,
    ),
  );
}
