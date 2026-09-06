import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/app_text_style.dart';
import '../../../../common/extensions/responsive_extension.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../generated/l10n.dart';
import '../../../../resources/app_constants.dart';
import '../bloc/chat_bloc.dart';
import 'voice_recorder.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, this.autofocus = false}) : onTap = null;

  const ChatInput.launcher({super.key, required this.onTap})
    : autofocus = false;

  final VoidCallback? onTap;
  final bool autofocus;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.onTap == null) {
      _syncController(context.read<ChatBloc>().state.inputText);
    }
  }

  void _syncController(String inputText) {
    if (_controller.text == inputText) return;
    _controller.value = TextEditingValue(
      text: inputText,
      selection: TextSelection.collapsed(offset: inputText.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap != null) {
      return _ChatInputLauncher(onTap: widget.onTap!);
    }
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.inputText != current.inputText,
      listener: (_, state) {
        _syncController(state.inputText);
        if (state.inputText.isEmpty && state.isLoading) {
          _focusNode.unfocus();
        }
      },
      builder: (context, state) {
        if (state.isRecording) {
          return VoiceRecorder(
            duration: state.recordingDuration,
            transcript: state.recognizedText,
            onCancel: () =>
                context.read<ChatBloc>().add(const CancelRecording()),
            onSend: () => context.read<ChatBloc>().add(const StopRecording()),
          );
        }
        final colors = Theme.of(context).colorScheme;
        final hasText = state.inputText.trim().isNotEmpty;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 60,
                  maxHeight: 148,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest.withValues(alpha: .7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  key: const Key('chat-text-field'),
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: widget.autofocus,
                  onTapOutside: (_) => _focusNode.unfocus(),
                  minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 15.5),
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      context.read<ChatBloc>().add(MessageChanged(value)),
                  decoration: const InputDecoration(
                    hintText: 'Nhắn tin cho ${AppConstants.chatbotName}...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 9),
            IconButton.filled(
              key: const Key('chat-action-button'),
              tooltip: hasText ? 'Gửi tin nhắn' : 'Ghi âm',
              style: IconButton.styleFrom(
                minimumSize: const Size.square(60),
                iconSize: 27,
              ),
              onPressed:
                  state.isLoading ||
                      state.recordingState ==
                          RecordingState.requestingPermission
                  ? null
                  : () {
                      if (hasText) {
                        _focusNode.unfocus();
                        context.read<ChatBloc>().add(const SendTextMessage());
                      } else {
                        context.read<ChatBloc>().add(const StartRecording());
                      }
                    },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child:
                    state.recordingState == RecordingState.requestingPermission
                    ? const SizedBox.square(
                        key: Key('permission-loading'),
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        hasText
                            ? Icons.arrow_upward_rounded
                            : Icons.mic_none_rounded,
                        key: ValueKey(hasText ? 'send-icon' : 'mic-icon'),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChatInputLauncher extends StatelessWidget {
  const _ChatInputLauncher({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Semantics(
      button: true,
      label: S.of(context).openChat,
      child: CupertinoButton(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(28),
        onPressed: onTap,
        child: Container(
          height: 56.height,
          decoration: BoxDecoration(
            color: colors.surfaceTemary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              Text(
                S.of(context).chatInputHint,
                style: AppTextStyle.r16.copyWith(color: colors.textTertiary),
              ).expanded(),
              Container(
                width: 40.width,
                height: 40.width,
                decoration: BoxDecoration(
                  color: colors.iconBrand,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: CustomPaint(
                  size: Size(20.sp, 20.sp),
                  painter: _SendArrowPainter(color: colors.surfaceSecondary),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.width),
        ),
      ),
    );
  }
}

class _SendArrowPainter extends CustomPainter {
  const _SendArrowPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * .1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final centerX = size.width / 2;
    canvas.drawLine(
      Offset(centerX, size.height * .8),
      Offset(centerX, size.height * .2),
      paint,
    );
    final path = Path()
      ..moveTo(size.width * .24, size.height * .44)
      ..lineTo(centerX, size.height * .2)
      ..lineTo(size.width * .76, size.height * .44);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SendArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}
