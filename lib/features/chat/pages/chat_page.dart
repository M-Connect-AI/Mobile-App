import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.isLoading != current.isLoading ||
          previous.aiProcessingState != current.aiProcessingState ||
          previous.error != current.error,
      listener: (context, state) {
        _scrollToBottom();
        if (state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error!),
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: const _ChatAppBar(),
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
                    final itemCount =
                        state.messages.length + (state.isLoading ? 1 : 0);
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
                        if (index == state.messages.length) {
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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withValues(alpha: .45),
                    ),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(14, 11, 14, 10),
                child: const ChatInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7879F1), Color(0xFF4D4ED3)],
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
                'AI Assistant',
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
        IconButton(
          tooltip: 'Tùy chọn',
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

  (String, Color) _status(ChatState state, ColorScheme colors) {
    if (state.recordingState == RecordingState.recording) {
      return ('Listening...', colors.error);
    }
    return switch (state.aiProcessingState) {
      AiProcessingState.thinking => ('Thinking...', colors.primary),
      AiProcessingState.understanding => ('Processing...', colors.primary),
      AiProcessingState.callingApi => ('Processing...', colors.primary),
      AiProcessingState.idle => ('Online', const Color(0xFF2EAD72)),
    };
  }
}
