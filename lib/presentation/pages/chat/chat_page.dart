import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/chat_message.dart';
import '../../../domain/model/chat_result.dart';
import '../../../domain/model/chat_rich_content.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../../resources/app_constants.dart';
import '../../../route/go_router.dart';
import 'bloc/chat_bloc.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.title, this.showCloseButton = false, this.autofocusInput = false});

  final String? title;
  final bool showCloseButton;
  final bool autofocusInput;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  final _isHeaderScrolled = ValueNotifier(false);
  bool _initialScrollScheduled = false;
  int _scrollRequestId = 0;
  double _lastKeyboardInset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(_updateHeaderAppearance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialScrollScheduled) {
      _initialScrollScheduled = true;
      _scrollToBottom(immediately: true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_updateHeaderAppearance);
    _scrollController.dispose();
    _isHeaderScrolled.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (!mounted) return;

    final view = View.of(context);
    final keyboardInset = view.viewInsets.bottom / view.devicePixelRatio;
    final keyboardIsOpening = keyboardInset > _lastKeyboardInset;
    _lastKeyboardInset = keyboardInset;

    if (!keyboardIsOpening) return;

    _scrollToBottom(immediately: true);
  }

  void _scrollToBottom({bool immediately = false}) {
    final requestId = ++_scrollRequestId;
    var attempts = 0;
    var stableFrames = 0;
    double? previousMaxExtent;

    late void Function(Duration) settleAtBottom;
    settleAtBottom = (_) {
      if (!mounted || requestId != _scrollRequestId) return;
      attempts++;
      if (!_scrollController.hasClients) {
        if (attempts < 10) {
          WidgetsBinding.instance.addPostFrameCallback(settleAtBottom);
        }
        return;
      }

      final position = _scrollController.position;
      final maxExtent = position.maxScrollExtent;
      _scrollController.jumpTo(maxExtent);
      final extentIsStable = previousMaxExtent != null && (maxExtent - previousMaxExtent!).abs() < .5;
      final isAtBottom = (position.pixels - maxExtent).abs() < .5;
      stableFrames = extentIsStable && isAtBottom ? stableFrames + 1 : 0;
      previousMaxExtent = maxExtent;

      if (stableFrames < 2 && attempts < 10) {
        WidgetsBinding.instance.addPostFrameCallback(settleAtBottom);
      }
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || requestId != _scrollRequestId) return;
      if (immediately || !_scrollController.hasClients) {
        settleAtBottom(Duration.zero);
        return;
      }
      final target = _scrollController.position.maxScrollExtent;
      _scrollController
          .animateTo(target, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic)
          .whenComplete(() {
            if (!mounted || requestId != _scrollRequestId) return;
            WidgetsBinding.instance.addPostFrameCallback(settleAtBottom);
          });
    });
  }

  void _updateHeaderAppearance() {
    if (!_scrollController.hasClients) return;
    final isScrolled = _scrollController.offset > 4.height;
    if (_isHeaderScrolled.value != isScrolled) {
      _isHeaderScrolled.value = isScrolled;
    }
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
        final restoredThread = state.activeThreadId != null && !state.isLoading && !state.isRestoring;
        if (restoredThread) _initialScrollScheduled = true;
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
        backgroundColor: context.appColorScheme.surfaceSecondary,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Column(
                children: [
                  BlocBuilder<ChatBloc, ChatState>(
                    buildWhen: (previous, current) =>
                        previous.messages != current.messages ||
                        previous.isLoading != current.isLoading ||
                        previous.aiProcessingState != current.aiProcessingState ||
                        previous.backendStatusLabel != current.backendStatusLabel,
                    builder: (context, state) {
                      final hasStreamingMessage =
                          state.messages.isNotEmpty &&
                          state.messages.last.sender == MessageSender.assistant &&
                          state.messages.last.status == MessageStatus.processing;
                      final showTypingIndicator = state.isLoading && !hasStreamingMessage;
                      final itemCount = state.messages.length + (showTypingIndicator ? 1 : 0);
                      return ListView.separated(
                        key: const Key('chat-list'),
                        controller: _scrollController,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.fromLTRB(
                          16.width,
                          MediaQuery.paddingOf(context).top + 84.height,
                          16.width,
                          16.height,
                        ),
                        itemCount: itemCount,
                        separatorBuilder: (context, index) {
                          if (index >= state.messages.length - 1) {
                            return 12.height.heightBox;
                          }
                          final current = state.messages[index];
                          final next = state.messages[index + 1];
                          return (current.sender == next.sender ? 8 : 16).height.heightBox;
                        },
                        itemBuilder: (context, index) {
                          if (showTypingIndicator && index == state.messages.length) {
                            return TypingIndicator(
                              stage: state.aiProcessingState,
                              statusLabel: state.backendStatusLabel,
                            );
                          }
                          final message = state.messages[index];
                          return ChatBubble(key: ValueKey(message.id), message: message);
                        },
                      );
                    },
                  ).expanded(),
                  BlocBuilder<ChatBloc, ChatState>(
                    buildWhen: (previous, current) =>
                        previous.messages != current.messages || previous.isLoading != current.isLoading,
                    builder: (context, state) => _ChatQuickActions(state: state),
                  ),
                  Container(
                    color: context.appColorScheme.surfaceSecondary,
                    child: ChatInput(
                      autofocus: widget.autofocusInput,
                    ).paddingLTRB(14.width, 12.height, 14.width, 12.height),
                  ),
                ],
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isHeaderScrolled,
                builder: (context, isScrolled, child) => _FloatingChatNavigation(
                  title: widget.title,
                  showCloseButton: widget.showCloseButton,
                  isScrolled: isScrolled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatQuickActions extends StatelessWidget {
  const _ChatQuickActions({required this.state});

  final ChatState state;

  @override
  Widget build(BuildContext context) {
    final actions = _quickActions(context, state);
    if (actions.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      key: const Key('chat-quick-actions'),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 14.width),
        child: Row(
          children: [
            for (var index = 0; index < actions.length; index++) ...[
              IrhOptionChip(
                key: Key('chat-suggestion-$index'),
                label: actions[index].label,
                onPressed: () => context.read<ChatBloc>().add(SuggestionSelected(actions[index].text)),
              ),
              if (index < actions.length - 1) 8.width.widthBox,
            ],
          ],
        ),
      ),
    ).paddingOnly(top: 8.height);
  }
}

List<ChatSuggestion> _quickActions(BuildContext context, ChatState state) {
  if (state.isLoading || state.messages.isEmpty) return const [];
  final message = state.messages.last;
  if (message.sender != MessageSender.assistant ||
      message.status != MessageStatus.success ||
      message.suggestions.isEmpty) {
    return const [];
  }
  if (message.executedResult case ChatJiraIssuesResult(:final data)) {
    return message.suggestions
        .map((suggestion) {
          final combined = '${suggestion.label} ${suggestion.text}'.toLowerCase();
          final matches = data.issues
              .where((issue) => combined.contains(issue.key.toLowerCase()))
              .toList(growable: false);
          final issue = data.issues.length == 1
              ? data.issues.single
              : matches.length == 1
              ? matches.single
              : null;
          if (issue == null) return null;
          final label = suggestion.label.toLowerCase();
          if (label.contains('tóm tắt') || label.contains('summar')) {
            return ChatSuggestion(label: S.of(context).jiraSummarizeTask(issue.key), text: suggestion.text);
          }
          if (label.contains('trạng thái') || label.contains('status')) {
            return ChatSuggestion(label: S.of(context).jiraTransitionTask(issue.key), text: suggestion.text);
          }
          if (label.contains('lịch') || label.contains('calendar')) {
            return ChatSuggestion(label: S.of(context).jiraAddTaskToCalendar(issue.key), text: suggestion.text);
          }
          return combined.contains(issue.key.toLowerCase()) ? suggestion : null;
        })
        .whereType<ChatSuggestion>()
        .toList(growable: false);
  }
  return message.suggestions;
}

class _FloatingChatNavigation extends StatelessWidget {
  const _FloatingChatNavigation({required this.title, required this.showCloseButton, required this.isScrolled});

  final String? title;
  final bool showCloseButton;
  final bool isScrolled;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final useOpaqueFallback =
        mediaQuery.disableAnimations || mediaQuery.accessibleNavigation || mediaQuery.highContrast;
    return SizedBox(
      height: mediaQuery.padding.top + 72.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: _NavigationBackdrop(isScrolled: isScrolled, useOpaqueFallback: useOpaqueFallback),
          ),
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: 72.height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _ScrollEdgeGradient(isScrolled: isScrolled),
                  ),
                  Row(
                    children: [
                      _AssistantIdentityCapsule(
                        title: title,
                        isCollapsed: isScrolled,
                        useOpaqueFallback: useOpaqueFallback,
                      ).expanded(),
                      12.width.widthBox,
                      SizedBox(
                        width: 44.width,
                        height: 44.height,
                        child: _GlassSurface(
                          isScrolled: isScrolled,
                          useOpaqueFallback: useOpaqueFallback,
                          height: 44.height,
                          borderRadius: 24,
                          child: Semantics(
                            button: true,
                            enabled: showCloseButton,
                            label: S.of(context).closeAssistant,
                            child: CupertinoButton(
                              key: const Key('close-assistant'),
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(24),
                              onPressed: showCloseButton ? () => GoRouterHelper(context).pop() : null,
                              child: Icon(CupertinoIcons.xmark, size: 20.sp, color: context.appColorScheme.iconPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.width, vertical: 8.height),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBackdrop extends StatelessWidget {
  const _NavigationBackdrop({required this.isScrolled, required this.useOpaqueFallback});

  final bool isScrolled;
  final bool useOpaqueFallback;

  @override
  Widget build(BuildContext context) {
    final surface = context.appColorScheme.surfaceSecondary;
    final overlay = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            surface.withValues(alpha: useOpaqueFallback ? .98 : (isScrolled ? .56 : .4)),
            surface.withValues(alpha: useOpaqueFallback ? .98 : (isScrolled ? .28 : .16)),
            surface.withValues(alpha: 0),
          ],
          stops: const [0, .72, 1],
        ),
      ),
    );
    return IgnorePointer(
      child: ClipRect(
        child: useOpaqueFallback
            ? overlay
            : BackdropFilter(filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), child: overlay),
      ),
    );
  }
}

class _AssistantIdentityCapsule extends StatelessWidget {
  const _AssistantIdentityCapsule({required this.title, required this.isCollapsed, required this.useOpaqueFallback});

  final String? title;
  final bool isCollapsed;
  final bool useOpaqueFallback;

  @override
  Widget build(BuildContext context) {
    final normalizedTitle = title?.trim();
    return _GlassSurface(
      isScrolled: isCollapsed,
      useOpaqueFallback: useOpaqueFallback,
      height: (isCollapsed ? 48 : 56).height,
      borderRadius: 28,
      child: Row(
        children: [
          AnimatedContainer(
            key: const Key('assistant-logo'),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            width: (isCollapsed ? 36 : 40).width,
            height: (isCollapsed ? 36 : 40).height,
            child: Assets.image.logo.svg(fit: BoxFit.cover, alignment: Alignment.topLeft, excludeFromSemantics: true),
          ),
          12.width.widthBox,
          LayoutBuilder(
            builder: (context, constraints) => FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IrhText.semibold(
                      normalizedTitle?.isNotEmpty == true ? normalizedTitle! : S.of(context).newConversationTitle,
                      maxLines: 1,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) => SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: -1,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: isCollapsed
                          ? const SizedBox.shrink(key: Key('collapsed-subtitle'))
                          : IrhText.small(AppConstants.chatbotName, key: const Key('assistant-subtitle'), maxLines: 1),
                    ),
                  ],
                ),
              ),
            ),
          ).expanded(),
        ],
      ).paddingSymmetric(horizontal: 12.width),
    );
  }
}

class _GlassSurface extends StatelessWidget {
  const _GlassSurface({
    required this.isScrolled,
    required this.useOpaqueFallback,
    required this.height,
    required this.borderRadius,
    required this.child,
  });

  final bool isScrolled;
  final bool useOpaqueFallback;
  final double height;
  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final glassContent = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: colors.surfacePrimary.withValues(alpha: useOpaqueFallback ? .98 : (isScrolled ? .88 : .7)),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: colors.borderTertiary.withValues(alpha: isScrolled ? .9 : .6), width: .5),
      ),
      child: child,
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: isScrolled ? .1 : .04),
            blurRadius: isScrolled ? 16 : 8,
            offset: Offset(0, isScrolled ? 6.height : 4.height),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: useOpaqueFallback
            ? glassContent
            : BackdropFilter(
                filter: ImageFilter.blur(sigmaX: isScrolled ? 12 : 10, sigmaY: isScrolled ? 12 : 10),
                child: glassContent,
              ),
      ),
    );
  }
}

class _ScrollEdgeGradient extends StatelessWidget {
  const _ScrollEdgeGradient({required this.isScrolled});

  final bool isScrolled;

  @override
  Widget build(BuildContext context) {
    final surface = context.appColorScheme.surfaceSecondary;
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        height: 28.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              surface.withValues(alpha: isScrolled ? .28 : .12),
              surface.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
