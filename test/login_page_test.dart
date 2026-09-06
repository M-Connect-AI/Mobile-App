import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('mock login opens the home screen', (tester) async {
    final router = GoRouter(
      initialLocation: const LoginRoute().location,
      routes: $appRoutes,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.light,
          locale: const Locale('vi'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    expect(find.byKey(const Key('login-email-field')), findsOneWidget);
    expect(find.byKey(const Key('login-password-field')), findsOneWidget);

    final loginButton = find.byKey(const Key('login-button'));
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
  });
}
