import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/irh_text.dart';
import '../../../../common/extensions/responsive_extension.dart';
import '../../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../../generated/l10n.dart';
import '../../../../resources/app_constants.dart';
import '../bloc/chat_bloc.dart';
import 'microphone_permission_dialog.dart';
import 'voice_recorder.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, this.autofocus = false}) : onInputTap = null, onMicrophoneTap = null;

  const ChatInput.launcher({super.key, required this.onInputTap, required this.onMicrophoneTap}) : autofocus = false;

  final VoidCallback? onInputTap;
  final VoidCallback? onMicrophoneTap;
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
    if (widget.onInputTap == null) {
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
    if (widget.onInputTap != null && widget.onMicrophoneTap != null) {
      return _ChatInputLauncher(onInputTap: widget.onInputTap!, onMicrophoneTap: widget.onMicrophoneTap!);
    }
    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (previous, current) => previous.inputText != current.inputText,
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
            onCancel: () => context.read<ChatBloc>().add(const CancelRecording()),
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
                constraints: const BoxConstraints(minHeight: 60, maxHeight: 148),
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
                  onChanged: (value) => context.read<ChatBloc>().add(MessageChanged(value)),
                  decoration: InputDecoration(
                    hintText: S.of(context).chatInputHintName(AppConstants.chatbotName),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 9),
            IconButton.filled(
              key: const Key('chat-action-button'),
              tooltip: hasText ? S.of(context).sendMessage : S.of(context).recordVoice,
              style: IconButton.styleFrom(minimumSize: const Size.square(60), iconSize: 27),
              onPressed: state.isLoading || state.recordingState == RecordingState.requestingPermission
                  ? null
                  : () async {
                      if (hasText) {
                        _focusNode.unfocus();
                        context.read<ChatBloc>().add(const SendTextMessage());
                      } else {
                        if (!await confirmMicrophoneAccess(context) || !context.mounted) {
                          return;
                        }
                        context.read<ChatBloc>().add(const StartRecording());
                      }
                    },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: state.recordingState == RecordingState.requestingPermission
                    ? const SizedBox.square(
                        key: Key('permission-loading'),
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        hasText ? Icons.arrow_upward_rounded : Icons.mic_none_rounded,
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
  const _ChatInputLauncher({required this.onInputTap, required this.onMicrophoneTap});

  final VoidCallback onInputTap;
  final VoidCallback onMicrophoneTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Semantics(
          button: true,
          label: S.of(context).openChat,
          child: CupertinoButton(
            key: const Key('chat-launcher-input'),
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(28),
            onPressed: onInputTap,
            child: Container(
              height: 56.height,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(color: colors.surfaceTemary, borderRadius: BorderRadius.circular(28)),
              child: IrhText.regular(
                S.of(context).chatInputHintName(AppConstants.chatbotName),
                color: colors.textTertiary,
              ).paddingSymmetric(horizontal: 20.width, vertical: 16.height),
            ),
          ),
        ).expanded(),
        8.width.widthBox,
        Semantics(
          button: true,
          label: S.of(context).recordVoice,
          child: CupertinoButton(
            key: const Key('chat-launcher-microphone'),
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(28),
            onPressed: onMicrophoneTap,
            child: Container(
              width: 56.width,
              height: 56.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: colors.iconBrand, shape: BoxShape.circle),
              child: Icon(Icons.mic_none_rounded, size: 28.sp, color: colors.surfaceSecondary),
            ),
          ),
        ),
      ],
    );
  }
}
