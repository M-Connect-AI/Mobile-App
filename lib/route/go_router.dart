import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../common/navigation/root_navigator_key.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/speech_to_text_repository.dart';
import '../presentation/pages/chat/bloc/chat_bloc.dart';
import '../presentation/pages/chat/chat_page.dart';
import '../presentation/pages/home/chat_history_page.dart';
import '../presentation/pages/home/home_chat_ai_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';

part 'go_router.g.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: const LoginRoute().location,
  routes: appRoutes,
);

final List<RouteBase> appRoutes = [
  ...$appRoutes,
  GoRoute(
    path: HomeChatAiRoute.path,
    builder: (context, state) => const HomeChatAiPage(),
  ),
  GoRoute(
    path: ChatHistoryRoute.path,
    builder: (context, state) => const ChatHistoryPage(),
  ),
  GoRoute(
    path: ChatRoute.path,
    pageBuilder: (context, state) => ChatRoute(
      threadId: state.uri.queryParameters['threadId'],
      initialMessage: state.uri.queryParameters['initialMessage'],
      autoSendInitialMessage:
          state.uri.queryParameters['autoSendInitialMessage'] == 'true',
    ).buildPage(context, state),
  ),
];

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class HomeChatAiRoute extends GoRouteData {
  const HomeChatAiRoute();

  static const path = '/ai';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeChatAiPage();

  Future<T?> push<T>(BuildContext context) => context.push<T>(path);
}

class ChatHistoryRoute extends GoRouteData {
  const ChatHistoryRoute();

  static const path = '/ai/history';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChatHistoryPage();

  Future<T?> push<T>(BuildContext context) => context.push<T>(path);
}

class ChatRoute extends GoRouteData {
  const ChatRoute({
    this.threadId,
    this.initialMessage,
    this.autoSendInitialMessage = false,
  });

  static const path = '/chat';

  final String? threadId;
  final String? initialMessage;
  final bool autoSendInitialMessage;

  Future<T?> push<T>(BuildContext context) {
    final uri = Uri(
      path: path,
      queryParameters: {
        if (threadId != null) 'threadId': threadId,
        if (initialMessage != null) 'initialMessage': initialMessage,
        if (autoSendInitialMessage) 'autoSendInitialMessage': 'true',
      },
    );
    return context.push<T>(uri.toString());
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 360),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      child: BlocProvider(
        create: (context) =>
            ChatBloc(
              context.read<ChatRepository>(),
              context.read<SpeechToTextRepository>(),
            )..add(
              ChatStarted(
                threadId: threadId,
                initialMessage: initialMessage,
                autoSendInitialMessage: autoSendInitialMessage,
              ),
            ),
        child: ChatPage(
          showCloseButton: true,
          autofocusInput: threadId == null && !autoSendInitialMessage,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, .035),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          ),
        );
      },
    );
  }
}
