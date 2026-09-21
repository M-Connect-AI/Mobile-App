import 'package:chatbot_project/common/navigation/pop_or_go.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

GoRouter _router(String initialLocation) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/home',
      builder: (_, _) => const Scaffold(body: Text('Home')),
    ),
    GoRoute(
      path: '/ai',
      builder: (context, _) => Scaffold(
        body: TextButton(
          onPressed: () => popOrGo(context, '/home'),
          child: const Text('Assistant back'),
        ),
      ),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, _) => Scaffold(
        body: TextButton(
          onPressed: () => popOrGo(context, '/ai'),
          child: const Text('Close chat'),
        ),
      ),
    ),
  ],
);

void main() {
  testWidgets('external chat without a stack returns to assistant then home', (
    tester,
  ) async {
    final router = _router('/chat');
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    await tester.tap(find.text('Close chat'));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/ai');

    await tester.tap(find.text('Assistant back'));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/home');
  });

  testWidgets('chat opened inside app pops to the previous page', (
    tester,
  ) async {
    final router = _router('/ai');
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    router.push('/chat');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Close chat'));
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/ai');
    expect(find.text('Assistant back'), findsOneWidget);
  });
}
