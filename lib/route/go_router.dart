import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/chat/chat_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/login/login_page.dart';

part 'go_router.g.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: const LoginRoute().location,
  routes: $appRoutes,
);

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

@TypedGoRoute<ChatRoute>(path: '/chat')
class ChatRoute extends GoRouteData with _$ChatRoute {
  const ChatRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 360),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      child: const ChatPage(showCloseButton: true),
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
