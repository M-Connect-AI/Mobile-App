import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import 'voice_recorder.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.inputText != current.inputText,
      listener: (_, state) {
        if (_controller.text != state.inputText) {
          _controller.value = TextEditingValue(
            text: state.inputText,
            selection: TextSelection.collapsed(offset: state.inputText.length),
          );
        }
      },
      builder: (context, state) {
        if (state.isRecording) {
          return VoiceRecorder(
            duration: state.recordingDuration,
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
                  minHeight: 52,
                  maxHeight: 132,
                ),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest.withValues(alpha: .7),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(alpha: .6),
                  ),
                ),
                child: TextField(
                  key: const Key('chat-text-field'),
                  controller: _controller,
                  focusNode: _focusNode,
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      context.read<ChatBloc>().add(MessageChanged(value)),
                  decoration: const InputDecoration(
                    hintText: 'Nhắn tin cho AI Assistant...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 9),
            IconButton.filled(
              key: const Key('chat-action-button'),
              tooltip: hasText ? 'Gửi tin nhắn' : 'Ghi âm',
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
