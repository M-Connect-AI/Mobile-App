import 'package:chatbot_project/common/theme/app_theme.dart';
import 'package:chatbot_project/domain/model/auth_session.dart';
import 'package:chatbot_project/domain/model/home_data.dart';
import 'package:chatbot_project/domain/repository/auth_repository.dart';
import 'package:chatbot_project/domain/repository/credential_repository.dart';
import 'package:chatbot_project/domain/repository/home_repository.dart';
import 'package:chatbot_project/generated/l10n.dart';
import 'package:chatbot_project/route/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('real-login flow opens the home screen', (tester) async {
    final auth = _SuccessfulAuthRepository();
    final router = GoRouter(
      initialLocation: const LoginRoute().location,
      routes: appRoutes,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (_) => auth),
          RepositoryProvider<CredentialRepository>(
            create: (_) => _MemoryCredentialRepository(),
          ),
          RepositoryProvider<HomeRepository>(
            create: (_) => const _LoginHomeRepository(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
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
      ),
    );

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    expect(
      find.text('Đăng nhập mô phỏng · Chưa kết nối API thật'),
      findsNothing,
    );

    await tester.tap(find.byKey(const Key('login-email-field')));
    await tester.pumpAndSettle();
    expect(find.text('Tài khoản gợi ý'), findsOneWidget);
    expect(find.text('Sử dụng email khác'), findsOneWidget);
    final suggestedAccount = find.byKey(
      const ValueKey('account-a.nguyen@msb.vn'),
    );
    await tester.ensureVisible(suggestedAccount);
    await tester.tap(suggestedAccount);
    await tester.enterText(
      find.byKey(const Key('login-password-field')),
      'password123',
    );
    final loginButton = find.byKey(const Key('login-button'));
    await tester.ensureVisible(loginButton);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(auth.email, 'a.nguyen@msb.vn');
    expect(find.text('Xin chào, Minh 👋'), findsOneWidget);
  });
}

class _SuccessfulAuthRepository implements AuthRepository {
  String? email;

  @override
  Future<AuthUser> getProfile(String accessToken) async => _session.user;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    this.email = email;
    return _session;
  }
}

class _MemoryCredentialRepository implements CredentialRepository {
  AuthSession? session;

  @override
  Future<void> clear() async => session = null;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value, {required bool persist}) async =>
      session = value;
}

class _LoginHomeRepository implements HomeRepository {
  const _LoginHomeRepository();

  @override
  Future<HomeData> getHomeData() async => const HomeData(
    user: AuthUser(
      id: 'user-id',
      employeeCode: 'EMP001',
      email: 'a.nguyen@msb.vn',
      fullName: 'Minh',
      role: UserRole.staff,
      department: 'Khối bán lẻ',
      annualRemaining: 9,
      annualTotal: 12,
      sickRemaining: 30,
    ),
    leaveBalance: LeaveBalance(
      employeeCode: 'EMP001',
      annualRemaining: 9,
      annualTotal: 12,
      sickRemaining: 30,
    ),
    upcomingTrips: [],
  );
}

const _session = AuthSession(
  accessToken: 'jwt',
  user: AuthUser(
    id: 'user-id',
    employeeCode: 'EMP001',
    email: 'a.nguyen@msb.vn',
    fullName: 'Nguyễn Văn A',
    role: UserRole.staff,
    department: 'Khối bán lẻ',
    annualRemaining: 9,
    annualTotal: 12,
    sickRemaining: 30,
  ),
);
