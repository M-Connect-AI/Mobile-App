import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_toast.dart';
import '../../../domain/model/chat_message.dart';
import '../../../generated/l10n.dart';
import '../../../resources/app_constants.dart';
import '../../../route/go_router.dart';
import 'bloc/chat_bloc.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.showCloseButton = false,
    this.autofocusInput = false,
  });

  final bool showCloseButton;
  final bool autofocusInput;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  bool _initialThreadScrollScheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<ChatBloc>().state;
    if (!_initialThreadScrollScheduled &&
        state.activeThreadId != null &&
        !state.isRestoring) {
      _initialThreadScrollScheduled = true;
      _scrollToBottom(immediately: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool immediately = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      final target = _scrollController.position.maxScrollExtent;
      if (immediately) {
        _scrollController.jumpTo(target);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_scrollController.hasClients) return;
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        return;
      }
      _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.messages != current.messages ||
          previous.isLoading != current.isLoading ||
          previous.isRestoring != current.isRestoring ||
          previous.aiProcessingState != current.aiProcessingState ||
          previous.error != current.error,
      listener: (context, state) {
        final restoredThread =
            state.activeThreadId != null &&
            !state.isLoading &&
            !state.isRestoring;
        if (restoredThread) _initialThreadScrollScheduled = true;
        _scrollToBottom(immediately: restoredThread);
        if (state.sessionExpired) {
          const LoginRoute().go(context);
          return;
        }
        if (state.error != null) {
          AppToast.failed(context, state.error!);
        }
      },
      child: Scaffold(
        appBar: _ChatAppBar(showCloseButton: widget.showCloseButton),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  buildWhen: (previous, current) =>
                      previous.messages != current.messages ||
                      previous.isLoading != current.isLoading ||
                      previous.aiProcessingState != current.aiProcessingState,
                  builder: (context, state) {
                    final hasStreamingMessage =
                        state.messages.isNotEmpty &&
                        state.messages.last.sender == MessageSender.assistant &&
                        state.messages.last.status == MessageStatus.processing;
                    final showTypingIndicator =
                        state.isLoading && !hasStreamingMessage;
                    final itemCount =
                        state.messages.length + (showTypingIndicator ? 1 : 0);
                    return ListView.separated(
                      key: const Key('chat-list'),
                      controller: _scrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(16, 22, 16, 16),
                      itemCount: itemCount,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        if (showTypingIndicator &&
                            index == state.messages.length) {
                          return TypingIndicator(
                            stage: state.aiProcessingState,
                          );
                        }
                        return ChatBubble(message: state.messages[index]);
                      },
                    );
                  },
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: ChatInput(autofocus: widget.autofocusInput),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatAppBar({required this.showCloseButton});

  final bool showCloseButton;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8A45), Color(0xFFF4600C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppConstants.chatbotName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading ||
                    previous.recordingState != current.recordingState ||
                    previous.aiProcessingState != current.aiProcessingState,
                builder: (context, state) {
                  final (label, color) = _status(
                    context,
                    state,
                    Theme.of(context).colorScheme,
                  );
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: Row(
                      key: ValueKey(label),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (showCloseButton)
          IconButton(
            key: const Key('close-assistant'),
            tooltip: S.of(context).closeAssistant,
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close_rounded),
          )
        else
          IconButton(
            tooltip: S.of(context).options,
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        const SizedBox(width: 6),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: .45),
        ),
      ),
    );
  }

  (String, Color) _status(
    BuildContext context,
    ChatState state,
    ColorScheme colors,
  ) {
    final strings = S.of(context);
    if (state.recordingState == RecordingState.recording) {
      return (strings.listening, colors.error);
    }
    return switch (state.aiProcessingState) {
      AiProcessingState.thinking => (strings.thinking, colors.primary),
      AiProcessingState.understanding => (strings.processing, colors.primary),
      AiProcessingState.generatingResponse => (
        strings.processing,
        colors.primary,
      ),
      AiProcessingState.idle => (strings.online, const Color(0xFF2EAD72)),
    };
  }
}
