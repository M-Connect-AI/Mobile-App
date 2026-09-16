import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/chat_message.dart';
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
  bool _initialThreadScrollScheduled = false;
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
    final state = context.read<ChatBloc>().state;
    if (!_initialThreadScrollScheduled && state.activeThreadId != null && !state.isRestoring) {
      _initialThreadScrollScheduled = true;
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
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
      _scrollController
          .animateTo(target, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic)
          .whenComplete(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted || !_scrollController.hasClients) return;
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            });
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
                          return ChatBubble(message: state.messages[index]);
                        },
                      );
                    },
                  ).expanded(),
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
    return SafeArea(
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
